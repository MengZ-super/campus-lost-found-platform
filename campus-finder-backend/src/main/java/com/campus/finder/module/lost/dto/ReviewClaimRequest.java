package com.campus.finder.module.lost.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 审核认领申请请求
 */
@Data
public class ReviewClaimRequest {

    @NotBlank(message = "审核结果不能为空")
    private String action;  // approve-通过，reject-拒绝

    @Size(max = 500, message = "备注最多500个字符")
    private String remark;
}
