package com.campus.finder.module.auth.controller;

import com.campus.finder.common.result.Result;
import com.campus.finder.module.auth.dto.*;
import com.campus.finder.module.auth.service.AuthService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

/**
 * 认证控制器
 */
@Tag(name = "认证管理", description = "用户注册、登录、退出等认证相关接口")
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @Value("${jwt.access-token-expiration}")
    private long accessTokenExpiration;

    /**
     * 用户注册
     */
    @Operation(summary = "用户注册", description = "支持用户名+密码注册，需要提供手机号")
    @PostMapping("/register")
    public Result<AuthResponse> register(@Valid @RequestBody RegisterRequest request) {
        AuthResponse response = authService.register(request);
        return Result.success("注册成功", response);
    }

    /**
     * 用户登录
     */
    @Operation(summary = "用户登录", description = "支持用户名或手机号登录")
    @PostMapping("/login")
    public Result<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        AuthResponse response = authService.login(request);
        return Result.success("登录成功", response);
    }

    /**
     * 退出登录
     */
    @Operation(summary = "退出登录", description = "使当前Token失效")
    @PostMapping("/logout")
    public Result<Void> logout(HttpServletRequest request) {
        String token = extractToken(request);
        authService.logout(token);
        return Result.success("退出成功", null);
    }

    /**
     * 刷新Token
     */
    @Operation(summary = "刷新Token", description = "使用RefreshToken换取新的AccessToken")
    @PostMapping("/refresh")
    public Result<AuthResponse> refreshToken(@Valid @RequestBody RefreshTokenRequest request) {
        AuthResponse response = authService.refreshToken(request);
        return Result.success("刷新成功", response);
    }

    /**
     * 获取当前用户信息
     */
    @Operation(summary = "获取当前用户信息", description = "获取已登录用户的基本信息")
    @GetMapping("/me")
    public Result<AuthResponse> getCurrentUser(Authentication authentication) {
        if (authentication == null) {
            return Result.error(401, "未登录");
        }
        // 这里可以扩展返回更多信息
        AuthResponse response = AuthResponse.builder()
                .username(authentication.getName())
                .build();
        return Result.success(response);
    }

    /**
     * 从请求中提取Token
     */
    private String extractToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }
}
