package com.campus.finder.config;

import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.common.util.JwtUtil;
import com.campus.finder.module.auth.service.AuthService;
import com.campus.finder.module.user.entity.User;
import com.campus.finder.module.user.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * JWT认证过滤器
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final AuthService authService;
    private final UserService userService;
    private final ObjectMapper objectMapper;
    private final RedisTemplate<String, String> redisTemplate;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        try {
            String token = extractToken(request);

            if (token != null && jwtUtil.validateToken(token)) {
                // 检查Token是否在黑名单
                if (authService.isTokenBlacklisted(token)) {
                    sendErrorResponse(response, ResultCode.TOKEN_INVALID);
                    return;
                }

                // 解析Token获取用户信息
                String username = jwtUtil.getUsernameFromToken(token);
                Long userId = jwtUtil.getUserIdFromToken(token);

                // 验证用户状态
                User user = userService.checkUserStatus(userId);

                // 创建认证令牌
                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(
                                user.getUsername(),
                                null,
                                Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"))
                        );

                // 将用户ID存入details
                authentication.setDetails(userId);

                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authentication);

                log.debug("JWT认证成功: username={}, userId={}", username, userId);
            }
        } catch (ExpiredJwtException e) {
            log.warn("Token已过期: {}", e.getMessage());
            sendErrorResponse(response, ResultCode.TOKEN_EXPIRED);
            return;
        } catch (JwtException e) {
            log.warn("Token无效: {}", e.getMessage());
            sendErrorResponse(response, ResultCode.TOKEN_INVALID);
            return;
        } catch (BusinessException e) {
            sendErrorResponse(response, e.getCode(), e.getMessage());
            return;
        } catch (Exception e) {
            log.error("JWT认证异常", e);
        }

        filterChain.doFilter(request, response);
    }

    /**
     * 从请求中提取Token
     */
    private String extractToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }

    /**
     * 发送错误响应
     */
    private void sendErrorResponse(HttpServletResponse response, ResultCode resultCode) throws IOException {
        sendErrorResponse(response, resultCode.getCode(), resultCode.getMessage());
    }

    /**
     * 发送错误响应
     */
    private void sendErrorResponse(HttpServletResponse response, int code, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("code", code);
        errorResponse.put("message", message);
        errorResponse.put("timestamp", System.currentTimeMillis());

        objectMapper.writeValue(response.getWriter(), errorResponse);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        String path = request.getServletPath();
        // 忽略认证相关路径
        return path.startsWith("/api/auth/") ||
                path.startsWith("/swagger-ui") ||
                path.startsWith("/api-docs") ||
                path.startsWith("/v3/api-docs") ||
                path.equals("/error");
    }
}
