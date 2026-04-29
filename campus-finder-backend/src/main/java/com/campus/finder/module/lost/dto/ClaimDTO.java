package com.campus.finder.module.lost.dto;

import com.campus.finder.module.lost.entity.Claim;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 认领申请DTO
 */
@Data
public class ClaimDTO {

    private Long id;
    private Long lostFoundId;
    private Long userId;
    private String claimType;

    // ========== 认领信息 ==========
    private String description;
    private String features;
    private String contact;
    private List<String> proofImages;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime expectTime;

    // ========== 审核状态 ==========
    private String status;
    private String statusText;
    private String remark;
    private Long reviewedBy;
    private String reviewerNickname;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime reviewedTime;

    // ========== 物品信息（用于列表展示） ==========
    private String lostFoundTitle;
    private String lostFoundLocation;
    private List<String> lostFoundImages;

    // ========== 申请人信息 ==========
    private String applicantNickname;
    private String applicantAvatar;

    // ========== 系统字段 ==========
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;

    /**
     * JSON解析器（复用）
     */
    private static final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 转换为DTO
     */
    public static ClaimDTO fromEntity(Claim claim) {
        if (claim == null) {
            return null;
        }
        ClaimDTO dto = new ClaimDTO();
        dto.setId(claim.getId());
        dto.setLostFoundId(claim.getLostFoundId());
        dto.setUserId(claim.getUserId());
        dto.setClaimType(claim.getClaimType());
        dto.setDescription(claim.getDescription());
        dto.setFeatures(claim.getFeatures());
        dto.setContact(claim.getContact());
        dto.setExpectTime(claim.getExpectTime());
        dto.setStatus(claim.getStatus());
        dto.setStatusText(getStatusText(claim.getStatus()));
        dto.setRemark(claim.getRemark());
        dto.setReviewedBy(claim.getReviewedBy());
        dto.setReviewedTime(claim.getReviewedTime());
        dto.setCreateTime(claim.getCreateTime());
        dto.setUpdateTime(claim.getUpdateTime());

        // 解析图片JSON
        if (claim.getProofImages() != null && !claim.getProofImages().isEmpty()) {
            try {
                dto.setProofImages(objectMapper.readValue(claim.getProofImages(), java.util.List.class));
            } catch (Exception e) {
                dto.setProofImages(List.of());
            }
        }

        return dto;
    }

    /**
     * 获取状态文本
     */
    public static String getStatusText(String status) {
        return switch (status) {
            case "pending" -> "待审核";
            case "approved" -> "已通过";
            case "rejected" -> "已拒绝";
            case "cancelled" -> "已取消";
            default -> "未知";
        };
    }
}
