package com.campus.finder.module.lost.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.Result;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.module.lost.dto.*;
import com.campus.finder.module.lost.entity.Category;
import com.campus.finder.module.lost.entity.LostFound;
import com.campus.finder.module.lost.service.CategoryService;
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
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 失物招领控制器
 */
@Slf4j
@Tag(name = "失物招领", description = "失物招领管理相关接口")
@RestController
@RequestMapping("/api/lost")
@RequiredArgsConstructor
@SecurityRequirement(name = "Bearer")
public class LostFoundController {

    private final LostFoundService lostFoundService;
    private final CategoryService categoryService;
    private final UserService userService;
    private final ObjectMapper objectMapper;

    // ========== 工具方法 ==========

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
     * 构建DTO（包含用户信息）
     */
    private LostFoundDTO buildDTO(LostFound lostFound, Long currentUserId) {
        Category category = categoryService.findById(lostFound.getCategoryId());
        User publisher = userService.findById(lostFound.getUserId());
        User claimedBy = lostFound.getClaimedBy() != null ? userService.findById(lostFound.getClaimedBy()) : null;

        LostFoundDTO dto = LostFoundDTO.fromEntity(
                lostFound,
                category != null ? category.getName() : null,
                publisher != null ? publisher.getNickname() : null,
                publisher != null ? publisher.getAvatar() : null,
                claimedBy != null ? claimedBy.getNickname() : null
        );

        // 设置当前用户是否已收藏
        if (currentUserId != null) {
            dto.setFavorited(lostFoundService.isFavorited(lostFound.getId(), currentUserId));
        }

        return dto;
    }

    // ========== 发布管理 ==========

    /**
     * 发布失物招领
     */
    @Operation(summary = "发布失物招领", description = "发布丢失物品或捡到物品的信息")
    @PostMapping("/publish")
    public Result<LostFoundDTO> publish(@Valid @RequestBody CreateLostFoundRequest request) {
        Long userId = getCurrentUserId();

        // 验证分类是否存在
        if (!categoryService.existsById(request.getCategoryId())) {
            throw new BusinessException(ResultCode.NOT_FOUND, "分类不存在");
        }

        LostFound lostFound = new LostFound();
        lostFound.setUserId(userId);
        lostFound.setCategoryId(request.getCategoryId());
        lostFound.setItemType(request.getItemType());
        lostFound.setTitle(request.getTitle());
        lostFound.setDescription(request.getDescription());
        lostFound.setFeatures(request.getFeatures());
        lostFound.setLocation(request.getLocation());
        lostFound.setLatitude(request.getLatitude());
        lostFound.setLongitude(request.getLongitude());
        lostFound.setHappenedTime(request.getHappenedTime());
        lostFound.setCampus(request.getCampus());

        // 图片转JSON
        if (request.getImages() != null && !request.getImages().isEmpty()) {
            try {
                lostFound.setImages(objectMapper.writeValueAsString(request.getImages()));
            } catch (JsonProcessingException e) {
                log.error("图片序列化失败", e);
                throw new BusinessException(ResultCode.INTERNAL_SERVER_ERROR, "图片处理失败");
            }
        }

        lostFoundService.create(lostFound);
        return Result.success("发布成功", buildDTO(lostFound, userId));
    }

    /**
     * 更新失物招领
     */
    @Operation(summary = "更新失物招领", description = "更新已发布的失物招领信息")
    @PutMapping("/{id}")
    public Result<LostFoundDTO> update(@PathVariable Long id, @Valid @RequestBody UpdateLostFoundRequest request) {
        Long userId = getCurrentUserId();

        LostFound lostFound = lostFoundService.getByIdOrThrow(id);

        // 只能更新自己的记录
        if (!lostFound.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权操作此记录");
        }

        // 只能更新待认领状态的记录
        if (!lostFound.isPending()) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "只能更新待认领状态的记录");
        }

        // 更新字段
        if (request.getCategoryId() != null) {
            if (!categoryService.existsById(request.getCategoryId())) {
                throw new BusinessException(ResultCode.NOT_FOUND, "分类不存在");
            }
            lostFound.setCategoryId(request.getCategoryId());
        }
        if (request.getTitle() != null) {
            lostFound.setTitle(request.getTitle());
        }
        if (request.getDescription() != null) {
            lostFound.setDescription(request.getDescription());
        }
        if (request.getFeatures() != null) {
            lostFound.setFeatures(request.getFeatures());
        }
        if (request.getLocation() != null) {
            lostFound.setLocation(request.getLocation());
        }
        if (request.getLatitude() != null) {
            lostFound.setLatitude(request.getLatitude());
        }
        if (request.getLongitude() != null) {
            lostFound.setLongitude(request.getLongitude());
        }
        if (request.getHappenedTime() != null) {
            lostFound.setHappenedTime(request.getHappenedTime());
        }
        if (request.getCampus() != null) {
            lostFound.setCampus(request.getCampus());
        }
        if (request.getImages() != null) {
            try {
                lostFound.setImages(objectMapper.writeValueAsString(request.getImages()));
            } catch (JsonProcessingException e) {
                log.error("图片序列化失败", e);
                throw new BusinessException(ResultCode.INTERNAL_SERVER_ERROR, "图片处理失败");
            }
        }

        lostFoundService.update(lostFound);
        return Result.success("更新成功", buildDTO(lostFound, userId));
    }

    /**
     * 删除失物招领
     */
    @Operation(summary = "删除失物招领", description = "删除已发布的失物招领记录")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        Long userId = getCurrentUserId();

        LostFound lostFound = lostFoundService.getByIdOrThrow(id);

        // 只能删除自己的记录
        if (!lostFound.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权操作此记录");
        }

        lostFoundService.delete(id);
        return Result.success("删除成功", null);
    }

    // ========== 查询接口 ==========

    /**
     * 获取详情
     */
    @Operation(summary = "获取详情", description = "获取失物招领详细信息")
    @GetMapping("/{id}")
    public Result<LostFoundDTO> getDetail(@PathVariable Long id) {
        Long userId = getCurrentUserId();

        LostFound lostFound = lostFoundService.getByIdOrThrow(id);

        // 增加浏览次数
        lostFoundService.incrementViewCount(id);
        lostFound.setViewCount(lostFound.getViewCount() + 1);

        return Result.success(buildDTO(lostFound, userId));
    }

    /**
     * 分页查询列表
     */
    @Operation(summary = "列表查询", description = "分页查询失物招领列表，支持筛选和搜索")
    @GetMapping("/list")
    public Result<Page<LostFoundDTO>> list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            LostFoundQueryRequest query) {

        Long userId = getCurrentUserId();

        Page<LostFound> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<LostFound> wrapper = new LambdaQueryWrapper<>();

        // 筛选条件
        if (query.getCategoryId() != null) {
            wrapper.eq(LostFound::getCategoryId, query.getCategoryId());
        }
        if (query.getItemType() != null && !query.getItemType().isEmpty()) {
            wrapper.eq(LostFound::getItemType, query.getItemType());
        }
        if (query.getStatus() != null && !query.getStatus().isEmpty()) {
            wrapper.eq(LostFound::getStatus, query.getStatus());
        } else {
            // 默认只显示待认领的
            wrapper.eq(LostFound::getStatus, LostFound.STATUS_PENDING);
        }
        if (query.getCampus() != null && !query.getCampus().isEmpty()) {
            wrapper.eq(LostFound::getCampus, query.getCampus());
        }
        if (query.getLocation() != null && !query.getLocation().isEmpty()) {
            wrapper.like(LostFound::getLocation, query.getLocation());
        }

        // 时间范围
        if (query.getStartDate() != null) {
            wrapper.ge(LostFound::getHappenedTime, query.getStartDate().atStartOfDay());
        }
        if (query.getEndDate() != null) {
            wrapper.le(LostFound::getHappenedTime, query.getEndDate().atTime(23, 59, 59));
        }

        // 关键词搜索
        if (query.getKeyword() != null && !query.getKeyword().isEmpty()) {
            wrapper.and(w -> w.like(LostFound::getTitle, query.getKeyword())
                    .or()
                    .like(LostFound::getDescription, query.getKeyword())
                    .or()
                    .like(LostFound::getLocation, query.getKeyword()));
        }

        // 排序
        String sortBy = query.getSortBy();
        if ("hot".equals(sortBy)) {
            wrapper.orderByDesc(LostFound::getViewCount, LostFound::getFavoriteCount);
        } else if ("views".equals(sortBy)) {
            wrapper.orderByDesc(LostFound::getViewCount);
        } else {
            wrapper.orderByDesc(LostFound::getCreateTime);
        }

        Page<LostFound> result = lostFoundService.findPage(page, wrapper);

        // 转换为DTO
        List<LostFoundDTO> dtoList = result.getRecords().stream()
                .map(item -> buildDTO(item, userId))
                .collect(Collectors.toList());

        Page<LostFoundDTO> dtoPage = new Page<>();
        dtoPage.setCurrent(result.getCurrent());
        dtoPage.setSize(result.getSize());
        dtoPage.setTotal(result.getTotal());
        dtoPage.setPages(result.getPages());
        dtoPage.setRecords(dtoList);

        return Result.success(dtoPage);
    }

    /**
     * 搜索
     */
    @Operation(summary = "搜索", description = "按关键词搜索失物招领")
    @GetMapping("/search")
    public Result<List<LostFoundDTO>> search(@RequestParam String keyword) {
        Long userId = getCurrentUserId();

        if (keyword == null || keyword.trim().isEmpty()) {
            return Result.success(List.of());
        }

        List<LostFound> list = lostFoundService.searchByKeyword(keyword.trim());
        List<LostFoundDTO> dtoList = list.stream()
                .map(item -> buildDTO(item, userId))
                .collect(Collectors.toList());

        return Result.success(dtoList);
    }

    /**
     * 获取我的发布
     */
    @Operation(summary = "我的发布", description = "获取当前用户发布的所有失物招领")
    @GetMapping("/my")
    public Result<List<LostFoundDTO>> myList() {
        Long userId = getCurrentUserId();

        List<LostFound> list = lostFoundService.findByUserId(userId);
        List<LostFoundDTO> dtoList = list.stream()
                .map(item -> buildDTO(item, userId))
                .collect(Collectors.toList());

        return Result.success(dtoList);
    }

    // ========== 状态流转 ==========

    /**
     * 关闭物品记录
     */
    @Operation(summary = "关闭记录", description = "关闭失物招领记录")
    @PostMapping("/{id}/close")
    public Result<LostFoundDTO> close(@PathVariable Long id, @Valid @RequestBody CloseItemRequest request) {
        Long userId = getCurrentUserId();

        LostFound lostFound = lostFoundService.getByIdOrThrow(id);

        // 只能关闭自己的记录
        if (!lostFound.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权操作此记录");
        }

        lostFoundService.closeItem(id, request.getReason());
        return Result.success("关闭成功", buildDTO(lostFoundService.getByIdOrThrow(id), userId));
    }

    /**
     * 重新开启
     */
    @Operation(summary = "重新开启", description = "将已认领的物品重新设为待认领状态")
    @PostMapping("/{id}/reopen")
    public Result<LostFoundDTO> reopen(@PathVariable Long id) {
        Long userId = getCurrentUserId();

        LostFound lostFound = lostFoundService.getByIdOrThrow(id);

        // 只能操作自己的记录
        if (!lostFound.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权操作此记录");
        }

        lostFoundService.reopenItem(id);
        return Result.success("重新开启成功", buildDTO(lostFoundService.getByIdOrThrow(id), userId));
    }

    // ========== 收藏相关 ==========

    /**
     * 收藏
     */
    @Operation(summary = "收藏", description = "收藏失物招领记录")
    @PostMapping("/{id}/favorite")
    public Result<Void> favorite(@PathVariable Long id) {
        Long userId = getCurrentUserId();

        lostFoundService.getByIdOrThrow(id);
        lostFoundService.favorite(id, userId);
        return Result.success("收藏成功", null);
    }

    /**
     * 取消收藏
     */
    @Operation(summary = "取消收藏", description = "取消收藏失物招领记录")
    @DeleteMapping("/{id}/favorite")
    public Result<Void> unfavorite(@PathVariable Long id) {
        Long userId = getCurrentUserId();

        lostFoundService.unfavorite(id, userId);
        return Result.success("取消收藏成功", null);
    }

    /**
     * 获取我的收藏
     */
    @Operation(summary = "我的收藏", description = "获取当前用户收藏的所有失物招领")
    @GetMapping("/favorites")
    public Result<List<LostFoundDTO>> myFavorites() {
        Long userId = getCurrentUserId();

        List<LostFound> list = lostFoundService.findFavoritesByUserId(userId);
        List<LostFoundDTO> dtoList = list.stream()
                .map(item -> buildDTO(item, userId))
                .collect(Collectors.toList());

        return Result.success(dtoList);
    }
}
