package com.campus.finder.module.admin.dto;

import lombok.Data;

/**
 * 管理员用户查询参数
 */
@Data
public class AdminUserQueryRequest {
    private String keyword;
    private Integer status;
    private String role;
}
