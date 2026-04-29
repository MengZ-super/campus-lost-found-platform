package com.campus.finder.module.auth.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 刷新Token请求
 */
@Data
@Schema(description = "刷新Token请求")
public class RefreshTokenRequest {

    @Schema(description = "RefreshToken", example = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...")
    @NotBlank(message = "RefreshToken不能为空")
    private String refreshToken;
}
