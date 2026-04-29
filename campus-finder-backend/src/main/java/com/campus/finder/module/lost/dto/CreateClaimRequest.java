package com.campus.finder.module.lost.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 提交认领申请请求
 */
@Data
public class CreateClaimRequest {

    @NotNull(message = "物品ID不能为空")
    private Long lostFoundId;

    @NotBlank(message = "认领类型不能为空")
    private String claimType;  // found-认领捡到的物品，lost-提供丢失物品线索

    @NotBlank(message = "认领说明不能为空")
    @Size(max = 1000, message = "认领说明最多1000个字符")
    private String description;

    @Size(max = 500, message = "特征描述最多500个字符")
    private String features;

    @NotBlank(message = "联系方式不能为空")
    @Size(max = 100, message = "联系方式最多100个字符")
    private String contact;

    @Size(max = 5, message = "最多上传5张证明图片")
    private List<String> proofImages;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime expectTime;
}
