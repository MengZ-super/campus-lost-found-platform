package com.campus.finder.module.lost.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 发布失物招领请求
 */
@Data
public class CreateLostFoundRequest {

    @NotNull(message = "分类不能为空")
    private Long categoryId;

    @NotBlank(message = "物品类型不能为空")
    private String itemType;  // lost-丢失物品，found-捡到物品

    @NotBlank(message = "标题不能为空")
    @Size(max = 100, message = "标题最多100个字符")
    private String title;

    @NotBlank(message = "描述不能为空")
    @Size(max = 2000, message = "描述最多2000个字符")
    private String description;

    @Size(max = 9, message = "最多上传9张图片")
    private List<String> images;

    @Size(max = 500, message = "特征描述最多500个字符")
    private String features;

    @NotBlank(message = "地点不能为空")
    @Size(max = 200, message = "地点最多200个字符")
    private String location;

    @NotNull(message = "时间不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime happenedTime;

    private Double latitude;

    private Double longitude;

    @Size(max = 50, message = "校区最多50个字符")
    private String campus;
}
