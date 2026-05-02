package com.campus.finder.module.lost.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 更新失物招领请求
 */
@Data
public class UpdateLostFoundRequest {

    private Long categoryId;

    @Size(max = 100, message = "标题最多100个字符")
    private String title;

    @Size(max = 2000, message = "描述最多2000个字符")
    private String description;

    @Size(max = 9, message = "最多上传9张图片")
    private List<String> images;

    @Size(max = 500, message = "特征描述最多500个字符")
    private String features;

    @Size(max = 200, message = "地点最多200个字符")
    private String location;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime happenedTime;

    private Double latitude;

    private Double longitude;

    @Size(max = 50, message = "校区最多50个字符")
    private String campus;
}
