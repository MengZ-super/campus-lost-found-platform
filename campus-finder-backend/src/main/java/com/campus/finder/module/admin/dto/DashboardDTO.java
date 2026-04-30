package com.campus.finder.module.admin.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 仪表盘统计
 */
@Data
public class DashboardDTO {

    private long totalUsers;

    private long totalItems;
    private long pendingItems;
    private long claimedItems;
    private long closedItems;

    private long totalClaims;
    private long pendingClaims;
    private long approvedClaims;
    private long rejectedClaims;

    private List<RecentItem> recentItems;

    @Data
    public static class RecentItem {
        private Long id;
        private String title;
        private String itemType;
        private String status;
        private String publisherName;
        private LocalDateTime createTime;
    }
}
