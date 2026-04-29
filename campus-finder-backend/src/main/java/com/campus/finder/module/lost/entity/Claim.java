package com.campus.finder.module.lost.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 认领申请实体
 */
@Data
@TableName("biz_claim")
public class Claim implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 申请ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 失物招领记录ID
     */
    private Long lostFoundId;

    /**
     * 申请人ID
     */
    private Long userId;

    /**
     * 物品类型：found-捡到物品（申请认领），lost-丢失物品（提供线索）
     */
    private String claimType;

    // ========== 认领信息 ==========

    /**
     * 认领说明
     */
    private String description;

    /**
     * 物品特征描述（用于验证）
     */
    private String features;

    /**
     * 联系方式
     */
    private String contact;

    /**
     * 证明材料（图片）
     */
    private String proofImages;

    /**
     * 期望认领时间
     */
    private LocalDateTime expectTime;

    // ========== 审核状态 ==========

    /**
     * 申请状态：pending-待审核，approved-已通过，rejected-已拒绝，cancelled-已取消
     */
    private String status;

    /**
     * 审核备注（拒绝原因）
     */
    private String remark;

    /**
     * 审核人ID
     */
    private Long reviewedBy;

    /**
     * 审核时间
     */
    private LocalDateTime reviewedTime;

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
    public static final String STATUS_APPROVED = "approved";
    public static final String STATUS_REJECTED = "rejected";
    public static final String STATUS_CANCELLED = "cancelled";

    // ========== 认领类型 ==========

    public static final String CLAIM_TYPE_CLAIM = "found";      // 认领捡到的物品
    public static final String CLAIM_TYPE_PROVIDE = "lost";    // 提供丢失物品线索
}
