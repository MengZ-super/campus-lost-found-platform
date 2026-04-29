package com.campus.finder.module.lost.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 失物招领实体（捡到物品）
 */
@Data
@TableName("biz_lost_found")
public class LostFound implements Serializable {

    private static final long serialVersionUID = 1L;

    // ========== 基本信息 ==========

    /**
     * 记录ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 发布者ID
     */
    private Long userId;

    /**
     * 分类ID
     */
    private Long categoryId;

    /**
     * 物品类型：lost-丢失物品，found-捡到物品
     */
    private String itemType;

    // ========== 物品信息 ==========

    /**
     * 标题
     */
    private String title;

    /**
     * 物品描述
     */
    private String description;

    /**
     * 图片地址（JSON数组格式）
     */
    private String images;

    /**
     * 物品特征
     */
    private String features;

    // ========== 地点和时间 ==========

    /**
     * 发现/丢失地点
     */
    private String location;

    /**
     * 发现/丢失时间
     */
    private LocalDateTime happenedTime;

    /**
     * 校区
     */
    private String campus;

    // ========== 状态管理 ==========

    /**
     * 物品状态：pending-待认领，claimed-已认领，closed-已结束，expired-已过期
     */
    private String status;

    /**
     * 认领者ID（当物品被认领后）
     */
    private Long claimedBy;

    /**
     * 认领时间
     */
    private LocalDateTime claimedTime;

    /**
     * 关闭时间
     */
    private LocalDateTime closedTime;

    /**
     * 关闭原因
     */
    private String closeReason;

    // ========== 统计信息 ==========

    /**
     * 浏览次数
     */
    private Integer viewCount;

    /**
     * 收藏次数
     */
    private Integer favoriteCount;

    /**
     * 认领申请次数
     */
    private Integer claimCount;

    // ========== 系统字段 ==========

    /**
     * 删除标记：0-未删除，1-已删除
     */
    @TableLogic
    private Integer deleted;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    // ========== 状态常量 ==========

    public static final String STATUS_PENDING = "pending";
    public static final String STATUS_CLAIMED = "claimed";
    public static final String STATUS_CLOSED = "closed";
    public static final String STATUS_EXPIRED = "expired";

    // ========== 物品类型常量 ==========

    public static final String ITEM_TYPE_FOUND = "found";
    public static final String ITEM_TYPE_LOST = "lost";

    // ========== 状态判断方法 ==========

    public boolean isPending() {
        return STATUS_PENDING.equals(this.status);
    }

    public boolean isClaimed() {
        return STATUS_CLAIMED.equals(this.status);
    }

    public boolean isClosed() {
        return STATUS_CLOSED.equals(this.status) || STATUS_EXPIRED.equals(this.status);
    }
}
