package com.campus.finder.module.lost.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 关闭物品记录请求
 */
@Data
public class CloseItemRequest {

    @NotBlank(message = "关闭原因不能为空")
    @Size(max = 500, message = "关闭原因最多500个字符")
    private String reason;
}
