package com.campus.finder.module.user.controller;

import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.Result;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.common.util.PasswordUtil;
import com.campus.finder.module.user.dto.ChangePasswordRequest;
import com.campus.finder.module.user.dto.UpdateProfileRequest;
import com.campus.finder.module.user.dto.UserProfileDTO;
import com.campus.finder.module.user.entity.User;
import com.campus.finder.module.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

/**
 * 用户控制器
 */
@Tag(name = "用户管理", description = "个人资料管理相关接口")
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
@SecurityRequirement(name = "Bearer")
public class UserController {

    private final UserService userService;

    /**
     * 获取当前用户ID
     */
    private Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BusinessException(ResultCode.UNAUTHORIZED);
        }
        // 从认证信息中获取用户ID（需要JwtAuthenticationFilter设置）
        Object userId = authentication.getDetails();
        if (userId instanceof Long) {
            return (Long) userId;
        }
        // 兼容：通过用户名查找
        String username = authentication.getName();
        User user = userService.findByUsername(username);
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        return user.getId();
    }

    /**
     * 获取个人资料
     */
    @Operation(summary = "获取个人资料", description = "获取当前登录用户的详细资料")
    @GetMapping("/profile")
    public Result<UserProfileDTO> getProfile() {
        Long userId = getCurrentUserId();
        User user = userService.checkUserStatus(userId);
        return Result.success(UserProfileDTO.fromUser(user));
    }

    /**
     * 更新个人资料
     */
    @Operation(summary = "更新个人资料", description = "更新当前登录用户的资料信息")
    @PutMapping("/profile")
    public Result<UserProfileDTO> updateProfile(@Valid @RequestBody UpdateProfileRequest request) {
        Long userId = getCurrentUserId();
        User user = userService.checkUserStatus(userId);

        // 检查手机号是否被其他用户使用
        if (request.getPhone() != null && !request.getPhone().equals(user.getPhone())) {
            if (userService.existsByPhone(request.getPhone())) {
                throw new BusinessException(ResultCode.PHONE_EXISTS);
            }
            user.setPhone(request.getPhone());
        }

        // 更新其他字段
        if (request.getNickname() != null) {
            user.setNickname(request.getNickname());
        }
        if (request.getAvatar() != null) {
            user.setAvatar(request.getAvatar());
        }
        if (request.getEmail() != null) {
            user.setEmail(request.getEmail());
        }
        if (request.getGender() != null) {
            user.setGender(request.getGender());
        }

        userService.updateById(user);
        return Result.success("资料更新成功", UserProfileDTO.fromUser(user));
    }

    /**
     * 修改密码
     */
    @Operation(summary = "修改密码", description = "修改当前登录用户的密码")
    @PutMapping("/password")
    public Result<Void> changePassword(@Valid @RequestBody ChangePasswordRequest request) {
        Long userId = getCurrentUserId();
        User user = userService.checkUserStatus(userId);

        // 验证原密码
        if (!PasswordUtil.matches(request.getOldPassword(), user.getPassword())) {
            throw new BusinessException(ResultCode.OLD_PASSWORD_ERROR);
        }

        // 验证新密码确认
        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw new BusinessException(ResultCode.VALIDATION_ERROR, "两次密码输入不一致");
        }

        // 验证新密码强度
        if (!PasswordUtil.isStrongEnough(request.getNewPassword())) {
            throw new BusinessException(ResultCode.VALIDATION_ERROR, "密码必须包含字母和数字，长度至少6位");
        }

        // 更新密码
        user.setPassword(PasswordUtil.encode(request.getNewPassword()));
        userService.updateById(user);

        return Result.success("密码修改成功", null);
    }

}
