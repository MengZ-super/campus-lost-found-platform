package com.campus.finder.module.lost.controller;

import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.Result;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.module.lost.dto.ClaimDTO;
import com.campus.finder.module.lost.dto.CreateClaimRequest;
import com.campus.finder.module.lost.dto.ReviewClaimRequest;
import com.campus.finder.module.lost.entity.Claim;
import com.campus.finder.module.lost.entity.LostFound;
import com.campus.finder.module.lost.service.ClaimService;
import com.campus.finder.module.lost.service.LostFoundService;
import com.campus.finder.module.user.entity.User;
import com.campus.finder.module.user.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 认领申请控制器
 */
@Slf4j
@Tag(name = "认领申请", description = "失物招领认领申请相关接口")
@RestController
@RequestMapping("/api/lost/claim")
@RequiredArgsConstructor
@SecurityRequirement(name = "Bearer")
public class ClaimController {

    private final ClaimService claimService;
    private final LostFoundService lostFoundService;
    private final UserService userService;
    private final ObjectMapper objectMapper;

    /**
     * 获取当前用户ID
     */
    private Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BusinessException(ResultCode.UNAUTHORIZED);
        }
        Object userId = authentication.getDetails();
        if (userId instanceof Long) {
            return (Long) userId;
        }
        String username = authentication.getName();
        User user = userService.findByUsername(username);
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        return user.getId();
    }

    /**
     * 获取当前用户
     */
    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BusinessException(ResultCode.UNAUTHORIZED);
        }
        String username = authentication.getName();
        User user = userService.findByUsername(username);
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        return user;
    }

    /**
     * 构建DTO
     */
    private ClaimDTO buildDTO(Claim claim) {
        LostFound lostFound = lostFoundService.findById(claim.getLostFoundId());
        User applicant = userService.findById(claim.getUserId());
        User reviewer = claim.getReviewedBy() != null ? userService.findById(claim.getReviewedBy()) : null;

        ClaimDTO dto = ClaimDTO.fromEntity(claim);
        if (dto != null) {
            dto.setLostFoundTitle(lostFound != null ? lostFound.getTitle() : null);
            dto.setLostFoundLocation(lostFound != null ? lostFound.getLocation() : null);
            if (lostFound != null && lostFound.getImages() != null && !lostFound.getImages().isEmpty()) {
                try {
                    dto.setLostFoundImages(objectMapper.readValue(lostFound.getImages(), java.util.List.class));
                } catch (Exception e) {
                    dto.setLostFoundImages(java.util.List.of());
                }
            }
            dto.setApplicantNickname(applicant != null ? applicant.getNickname() : null);
            dto.setApplicantAvatar(applicant != null ? applicant.getAvatar() : null);
            dto.setReviewerNickname(reviewer != null ? reviewer.getNickname() : null);
        }
        return dto;
    }

    /**
     * 提交认领申请
     */
    @Operation(summary = "提交申请", description = "提交失物招领认领申请")
    @PostMapping("/apply")
    public Result<ClaimDTO> apply(@Valid @RequestBody CreateClaimRequest request) {
        Long userId = getCurrentUserId();

        Claim claim = new Claim();
        claim.setLostFoundId(request.getLostFoundId());
        claim.setUserId(userId);
        claim.setClaimType(request.getClaimType());
        claim.setDescription(request.getDescription());
        claim.setFeatures(request.getFeatures());
        claim.setContact(request.getContact());
        claim.setExpectTime(request.getExpectTime());

        // 图片转JSON
        if (request.getProofImages() != null && !request.getProofImages().isEmpty()) {
            try {
                claim.setProofImages(objectMapper.writeValueAsString(request.getProofImages()));
            } catch (JsonProcessingException e) {
                log.error("图片序列化失败", e);
                throw new BusinessException(ResultCode.INTERNAL_SERVER_ERROR, "图片处理失败");
            }
        }

        claimService.submitClaim(claim);
        return Result.success("申请提交成功", buildDTO(claim));
    }

    /**
     * 取消申请
     */
    @Operation(summary = "取消申请", description = "取消待审核的认领申请")
    @PostMapping("/{id}/cancel")
    public Result<Void> cancel(@PathVariable Long id) {
        Long userId = getCurrentUserId();
        claimService.cancelClaim(id, userId);
        return Result.success("取消申请成功", null);
    }

    /**
     * 获取申请详情
     */
    @Operation(summary = "申请详情", description = "获取认领申请详细信息")
    @GetMapping("/{id}")
    public Result<ClaimDTO> getDetail(@PathVariable Long id) {
        getCurrentUserId(); // 验证登录

        Claim claim = claimService.getByIdOrThrow(id);
        return Result.success(buildDTO(claim));
    }

    /**
     * 获取我的申请
     */
    @Operation(summary = "我的申请", description = "获取当前用户提交的所有认领申请")
    @GetMapping("/my")
    public Result<List<ClaimDTO>> myClaims() {
        Long userId = getCurrentUserId();

        List<Claim> list = claimService.findByUserId(userId);
        List<ClaimDTO> dtoList = list.stream()
                .map(this::buildDTO)
                .collect(Collectors.toList());

        return Result.success(dtoList);
    }

    /**
     * 获取物品的所有申请（仅物品发布者可查看）
     */
    @Operation(summary = "物品申请列表", description = "获取某个物品的所有认领申请")
    @GetMapping("/lost-found/{lostFoundId}")
    public Result<List<ClaimDTO>> getClaimsByLostFound(@PathVariable Long lostFoundId) {
        Long userId = getCurrentUserId();

        LostFound lostFound = lostFoundService.getByIdOrThrow(lostFoundId);

        // 只有物品发布者和管理员可以查看申请
        User currentUser = getCurrentUser();
        if (!lostFound.getUserId().equals(userId) && !currentUser.isAdmin()) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权查看此物品的申请");
        }

        List<Claim> list = claimService.findByLostFoundId(lostFoundId);
        List<ClaimDTO> dtoList = list.stream()
                .map(this::buildDTO)
                .collect(Collectors.toList());

        return Result.success(dtoList);
    }

    /**
     * 审核申请（通过/拒绝）
     */
    @Operation(summary = "审核申请", description = "审核认领申请，通过或拒绝")
    @PostMapping("/{id}/review")
    public Result<ClaimDTO> review(@PathVariable Long id, @Valid @RequestBody ReviewClaimRequest request) {
        Long userId = getCurrentUserId();

        Claim claim = claimService.getByIdOrThrow(id);
        LostFound lostFound = lostFoundService.getByIdOrThrow(claim.getLostFoundId());

        // 只有物品发布者和管理员可以审核
        User currentUser = getCurrentUser();
        if (!lostFound.getUserId().equals(userId) && !currentUser.isAdmin()) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权审核此申请");
        }

        Claim result;
        if ("approve".equals(request.getAction())) {
            result = claimService.approveClaim(id, userId);
        } else if ("reject".equals(request.getAction())) {
            result = claimService.rejectClaim(id, request.getRemark(), userId);
        } else {
            throw new BusinessException(ResultCode.VALIDATION_ERROR, "无效的审核操作");
        }

        return Result.success("审核完成", buildDTO(result));
    }
}
