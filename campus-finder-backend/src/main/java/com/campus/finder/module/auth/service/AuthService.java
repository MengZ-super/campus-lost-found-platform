package com.campus.finder.module.auth.service;

import cn.hutool.core.bean.BeanUtil;
import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.common.util.JwtUtil;
import com.campus.finder.common.util.PasswordUtil;
import com.campus.finder.module.auth.dto.*;
import com.campus.finder.module.user.entity.User;
import com.campus.finder.module.user.service.UserService;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.concurrent.TimeUnit;

/**
 * 认证服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserService userService;
    private final JwtUtil jwtUtil;

    @Value("${jwt.access-token-expiration}")
    private long accessTokenExpiration;

    private final RedisTemplate<String, String> redisTemplate;

    private static final String BLACKLIST_PREFIX = "jwt:blacklist:";
    private static final String REFRESH_TOKEN_PREFIX = "jwt:refresh:";

    /**
     * 用户注册
     */
    @Transactional(rollbackFor = Exception.class)
    public AuthResponse register(RegisterRequest request) {
        // 校验密码确认
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new BusinessException(ResultCode.VALIDATION_ERROR, "两次密码输入不一致");
        }

        // 校验密码强度
        if (!PasswordUtil.isStrongEnough(request.getPassword())) {
            throw new BusinessException(ResultCode.VALIDATION_ERROR, "密码必须包含字母和数字，长度至少6位");
        }

        // 检查用户名唯一性
        if (userService.existsByUsername(request.getUsername())) {
            throw new BusinessException(ResultCode.USERNAME_EXISTS);
        }

        // 检查手机号唯一性
        if (userService.existsByPhone(request.getPhone())) {
            throw new BusinessException(ResultCode.PHONE_EXISTS);
        }

        // 检查学号唯一性（如果提供）
        if (request.getStudentId() != null && !request.getStudentId().isBlank()) {
            if (userService.existsByStudentId(request.getStudentId())) {
                throw new BusinessException(ResultCode.STUDENT_ID_EXISTS);
            }
        }

        // 创建用户
        User user = new User();
        user.setUsername(request.getUsername());
        user.setPassword(PasswordUtil.encode(request.getPassword()));
        user.setPhone(request.getPhone());
        user.setStudentId(request.getStudentId());
        user.setNickname(request.getNickname() != null ? request.getNickname() : request.getUsername());
        user.setStatus(1); // 正常状态
        user.setRole("user");

        userService.save(user);
        log.info("用户注册成功: username={}, phone={}", user.getUsername(), user.getPhone());

        // 生成Token
        return generateAuthResponse(user);
    }

    /**
     * 用户登录
     */
    public AuthResponse login(LoginRequest request) {
        // 根据用户名或手机号查询用户
        User user = userService.findByUsername(request.getUsername());
        if (user == null) {
            user = userService.findByPhone(request.getUsername());
        }

        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }

        // 检查用户状态
        if (user.isDisabled()) {
            throw new BusinessException(ResultCode.USER_DISABLED);
        }

        // 验证密码
        if (!PasswordUtil.matches(request.getPassword(), user.getPassword())) {
            throw new BusinessException(ResultCode.PASSWORD_ERROR);
        }

        // 更新登录信息
        userService.updateLoginInfo(user.getId(), null);

        log.info("用户登录成功: username={}", user.getUsername());

        // 生成Token
        return generateAuthResponse(user);
    }

    /**
     * 退出登录
     */
    public void logout(String accessToken) {
        if (accessToken != null && !accessToken.isBlank()) {
            // 将Token加入黑名单
            String blacklistKey = BLACKLIST_PREFIX + accessToken;
            long remainingTime = jwtUtil.getRemainingTime(accessToken);
            if (remainingTime > 0) {
                redisTemplate.opsForValue().set(blacklistKey, "1", remainingTime, TimeUnit.MILLISECONDS);
            }

            // 删除RefreshToken
            Long userId = jwtUtil.getUserIdFromToken(accessToken);
            if (userId != null) {
                String refreshTokenKey = REFRESH_TOKEN_PREFIX + userId;
                redisTemplate.delete(refreshTokenKey);
            }

            log.info("用户退出登录成功");
        }
    }

    /**
     * 刷新Token
     */
    public AuthResponse refreshToken(RefreshTokenRequest request) {
        String refreshToken = request.getRefreshToken();

        try {
            // 验证RefreshToken
            if (!jwtUtil.validateToken(refreshToken)) {
                throw new BusinessException(ResultCode.TOKEN_INVALID);
            }

            // 检查是否已过期
            if (jwtUtil.isTokenExpired(refreshToken)) {
                throw new BusinessException(ResultCode.REFRESH_TOKEN_EXPIRED);
            }

            // 从Redis获取用户ID验证
            Long userId = jwtUtil.getUserIdFromToken(refreshToken);
            String storedToken = redisTemplate.opsForValue().get(REFRESH_TOKEN_PREFIX + userId);

            if (storedToken == null || !storedToken.equals(refreshToken)) {
                throw new BusinessException(ResultCode.TOKEN_INVALID, "Token已失效，请重新登录");
            }

            // 获取用户信息
            User user = userService.checkUserStatus(userId);

            // 生成新Token
            return generateAuthResponse(user);

        } catch (ExpiredJwtException e) {
            throw new BusinessException(ResultCode.REFRESH_TOKEN_EXPIRED);
        } catch (JwtException e) {
            throw new BusinessException(ResultCode.TOKEN_INVALID);
        }
    }

    /**
     * 生成认证响应
     */
    private AuthResponse generateAuthResponse(User user) {
        String role = user.getRole() != null ? user.getRole() : "user";
        String accessToken = jwtUtil.generateAccessToken(user.getId(), user.getUsername(), role);
        String refreshToken = jwtUtil.generateRefreshToken(user.getId(), user.getUsername(), role);

        // 存储RefreshToken到Redis
        redisTemplate.opsForValue().set(
                REFRESH_TOKEN_PREFIX + user.getId(),
                refreshToken,
                accessTokenExpiration * 7L, // 7天
                TimeUnit.MILLISECONDS
        );

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .tokenType("Bearer")
                .expiresIn(accessTokenExpiration / 1000) // 转换为秒
                .userId(user.getId())
                .username(user.getUsername())
                .nickname(user.getNickname())
                .avatar(user.getAvatar())
                .role(role)
                .build();
    }

    /**
     * 检查Token是否在黑名单
     */
    public boolean isTokenBlacklisted(String token) {
        return Boolean.TRUE.equals(redisTemplate.hasKey(BLACKLIST_PREFIX + token));
    }
}
