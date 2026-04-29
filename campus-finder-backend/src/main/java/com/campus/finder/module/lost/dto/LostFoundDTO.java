package com.campus.finder.module.lost.dto;

import com.campus.finder.module.lost.entity.LostFound;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 失物招领DTO
 */
@Data
public class LostFoundDTO {

    // ========== 基本信息 ==========
    private Long id;
    private Long userId;
    private Long categoryId;
    private String itemType;
    private String categoryName;

    // ========== 物品信息 ==========
    private String title;
    private String description;
    private List<String> images;
    private String features;

    // ========== 地点和时间 ==========
    private String location;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime happenedTime;
    private String campus;

    // ========== 状态信息 ==========
    private String status;
    private String statusText;
    private Long claimedBy;
    private String claimedByNickname;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime claimedTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime closedTime;
    private String closeReason;

    // ========== 用户信息 ==========
    private String publisherNickname;
    private String publisherAvatar;

    // ========== 统计信息 ==========
    private Integer viewCount;
    private Integer favoriteCount;
    private Integer claimCount;

    // ========== 系统字段 ==========
    private Boolean favorited;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;

    /**
     * JSON解析器（复用）
     */
    private static final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 转换为DTO（基础信息）
     */
    public static LostFoundDTO fromEntity(LostFound lostFound) {
        if (lostFound == null) {
            return null;
        }
        LostFoundDTO dto = new LostFoundDTO();
        dto.setId(lostFound.getId());
        dto.setUserId(lostFound.getUserId());
        dto.setCategoryId(lostFound.getCategoryId());
        dto.setItemType(lostFound.getItemType());
        dto.setTitle(lostFound.getTitle());
        dto.setDescription(lostFound.getDescription());
        dto.setFeatures(lostFound.getFeatures());
        dto.setLocation(lostFound.getLocation());
        dto.setHappenedTime(lostFound.getHappenedTime());
        dto.setCampus(lostFound.getCampus());
        dto.setStatus(lostFound.getStatus());
        dto.setStatusText(getStatusText(lostFound.getStatus()));
        dto.setClaimedBy(lostFound.getClaimedBy());
        dto.setClaimedTime(lostFound.getClaimedTime());
        dto.setClosedTime(lostFound.getClosedTime());
        dto.setCloseReason(lostFound.getCloseReason());
        dto.setViewCount(lostFound.getViewCount());
        dto.setFavoriteCount(lostFound.getFavoriteCount());
        dto.setClaimCount(lostFound.getClaimCount());
        dto.setCreateTime(lostFound.getCreateTime());
        dto.setUpdateTime(lostFound.getUpdateTime());
        dto.setFavorited(false);

        // 解析图片JSON
        if (lostFound.getImages() != null && !lostFound.getImages().isEmpty()) {
            try {
                dto.setImages(objectMapper.readValue(lostFound.getImages(), java.util.List.class));
            } catch (Exception e) {
                dto.setImages(List.of());
            }
        }

        return dto;
    }

    /**
     * 转换为DTO（包含用户信息）
     */
    public static LostFoundDTO fromEntity(LostFound lostFound,
                                          String categoryName,
                                          String publisherNickname,
                                          String publisherAvatar,
                                          String claimedByNickname) {
        LostFoundDTO dto = fromEntity(lostFound);
        if (dto != null) {
            dto.setCategoryName(categoryName);
            dto.setPublisherNickname(publisherNickname);
            dto.setPublisherAvatar(publisherAvatar);
            dto.setClaimedByNickname(claimedByNickname);
        }
        return dto;
    }

    /**
     * 获取状态文本
     */
    public static String getStatusText(String status) {
        return switch (status) {
            case "pending" -> "待认领";
            case "claimed" -> "已认领";
            case "closed" -> "已结束";
            case "expired" -> "已过期";
            default -> "未知";
        };
    }
}
