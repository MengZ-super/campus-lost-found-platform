package com.campus.finder.module.lost.dto;

import lombok.Data;

import java.time.LocalDate;

/**
 * 失物招领查询请求
 */
@Data
public class LostFoundQueryRequest {

    // ========== 筛选条件 ==========
    private Long categoryId;
    private String itemType;      // lost-丢失物品，found-捡到物品
    private String status;        // pending-待认领，claimed-已认领，closed-已结束
    private String location;      // 地点关键词
    private String campus;        // 校区

    // ========== 时间范围 ==========
    private LocalDate startDate;
    private LocalDate endDate;

    // ========== 搜索关键词 ==========
    private String keyword;

    // ========== 排序 ==========
    private String sortBy;        // newest-最新，hot-热门，views-浏览量
}
