package com.campus.finder.module.admin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.module.admin.dto.*;
import com.campus.finder.module.lost.dto.ClaimDTO;
import com.campus.finder.module.lost.dto.LostFoundDTO;
import com.campus.finder.module.lost.entity.Category;
import com.campus.finder.module.lost.entity.Claim;
import com.campus.finder.module.lost.entity.LostFound;
import com.campus.finder.module.lost.service.CategoryService;
import com.campus.finder.module.lost.service.ClaimService;
import com.campus.finder.module.lost.service.LostFoundService;
import com.campus.finder.module.user.entity.User;
import com.campus.finder.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserService userService;
    private final LostFoundService lostFoundService;
    private final ClaimService claimService;
    private final CategoryService categoryService;

    // ==================== 仪表盘 ====================

    public DashboardDTO getDashboard() {
        DashboardDTO dto = new DashboardDTO();

        dto.setTotalUsers(userService.count());
        dto.setTotalItems(lostFoundService.count());
        dto.setPendingItems(lostFoundService.lambdaQuery()
                .eq(LostFound::getStatus, LostFound.STATUS_PENDING).count());
        dto.setClaimedItems(lostFoundService.lambdaQuery()
                .eq(LostFound::getStatus, LostFound.STATUS_CLAIMED).count());
        dto.setClosedItems(lostFoundService.lambdaQuery()
                .eq(LostFound::getStatus, LostFound.STATUS_CLOSED).count());

        dto.setTotalClaims(claimService.count());
        dto.setPendingClaims(claimService.lambdaQuery()
                .eq(Claim::getStatus, Claim.STATUS_PENDING).count());
        dto.setApprovedClaims(claimService.lambdaQuery()
                .eq(Claim::getStatus, Claim.STATUS_APPROVED).count());
        dto.setRejectedClaims(claimService.lambdaQuery()
                .eq(Claim::getStatus, Claim.STATUS_REJECTED).count());

        List<LostFound> recent = lostFoundService.lambdaQuery()
                .orderByDesc(LostFound::getCreateTime)
                .last("LIMIT 10")
                .list();
        dto.setRecentItems(recent.stream().map(item -> {
            DashboardDTO.RecentItem ri = new DashboardDTO.RecentItem();
            ri.setId(item.getId());
            ri.setTitle(item.getTitle());
            ri.setItemType(item.getItemType());
            ri.setStatus(item.getStatus());
            ri.setCreateTime(item.getCreateTime());
            User publisher = userService.getById(item.getUserId());
            ri.setPublisherName(publisher != null ? publisher.getNickname() : "未知");
            return ri;
        }).toList());

        return dto;
    }

    // ==================== 用户管理 ====================

    public UserPageDTO listUsers(int pageNum, int pageSize, AdminUserQueryRequest query) {
        Page<User> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();

        if (query != null) {
            if (query.getKeyword() != null && !query.getKeyword().isBlank()) {
                wrapper.and(w -> w.like(User::getUsername, query.getKeyword())
                        .or().like(User::getNickname, query.getKeyword())
                        .or().like(User::getPhone, query.getKeyword()));
            }
            if (query.getStatus() != null) {
                wrapper.eq(User::getStatus, query.getStatus());
            }
            if (query.getRole() != null && !query.getRole().isBlank()) {
                wrapper.eq(User::getRole, query.getRole());
            }
        }
        wrapper.orderByDesc(User::getCreateTime);
        userService.page(page, wrapper);
        return UserPageDTO.fromPage(page);
    }

    public User getUserDetail(Long userId) {
        User user = userService.getById(userId);
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        return user;
    }

    @Transactional
    public void toggleUserStatus(Long targetUserId, Long operatorUserId) {
        if (targetUserId.equals(operatorUserId)) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "不能禁用自己");
        }
        User user = userService.getById(targetUserId);
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        user.setStatus(user.getStatus() != null && user.getStatus() == 1 ? 0 : 1);
        userService.updateById(user);
        log.info("管理员 {} 切换用户 {} 状态为 {}", operatorUserId, targetUserId, user.getStatus());
    }

    // ==================== 物品管理 ====================

    public ItemPageDTO listItems(int pageNum, int pageSize, String keyword,
                                  String itemType, String status, Long categoryId) {
        Page<LostFound> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<LostFound> wrapper = new LambdaQueryWrapper<>();

        if (keyword != null && !keyword.isBlank()) {
            wrapper.and(w -> w.like(LostFound::getTitle, keyword)
                    .or().like(LostFound::getDescription, keyword));
        }
        if (itemType != null && !itemType.isBlank()) {
            wrapper.eq(LostFound::getItemType, itemType);
        }
        if (status != null && !status.isBlank()) {
            wrapper.eq(LostFound::getStatus, status);
        }
        if (categoryId != null) {
            wrapper.eq(LostFound::getCategoryId, categoryId);
        }
        wrapper.orderByDesc(LostFound::getCreateTime);

        lostFoundService.page(page, wrapper);

        ItemPageDTO dto = new ItemPageDTO();
        dto.setCurrent(page.getCurrent());
        dto.setSize(page.getSize());
        dto.setTotal(page.getTotal());
        dto.setPages(page.getPages());
        dto.setRecords(page.getRecords().stream()
                .map(LostFoundDTO::fromEntity)
                .toList());
        return dto;
    }

    @Transactional
    public void forceCloseItem(Long itemId, String reason, Long operatorUserId) {
        lostFoundService.closeItem(itemId, reason);
        log.info("管理员 {} 强制关闭物品 {}", operatorUserId, itemId);
    }

    @Transactional
    public void forceDeleteItem(Long itemId) {
        lostFoundService.removeById(itemId);
        log.info("管理员强制删除物品 {}", itemId);
    }

    // ==================== 认领管理 ====================

    public ClaimPageDTO listClaims(int pageNum, int pageSize, String status, Long lostFoundId) {
        Page<Claim> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<Claim> wrapper = new LambdaQueryWrapper<>();

        if (status != null && !status.isBlank()) {
            wrapper.eq(Claim::getStatus, status);
        }
        if (lostFoundId != null) {
            wrapper.eq(Claim::getLostFoundId, lostFoundId);
        }
        wrapper.orderByDesc(Claim::getCreateTime);

        claimService.page(page, wrapper);

        ClaimPageDTO dto = new ClaimPageDTO();
        dto.setCurrent(page.getCurrent());
        dto.setSize(page.getSize());
        dto.setTotal(page.getTotal());
        dto.setPages(page.getPages());
        dto.setRecords(page.getRecords().stream()
                .map(ClaimDTO::fromEntity)
                .toList());
        return dto;
    }

    @Transactional
    public void reviewClaim(Long claimId, String action, String remark, Long operatorUserId) {
        if ("approve".equals(action)) {
            claimService.approveClaim(claimId, operatorUserId);
        } else if ("reject".equals(action)) {
            claimService.rejectClaim(claimId, remark, operatorUserId);
        } else {
            throw new BusinessException(ResultCode.VALIDATION_ERROR, "无效的审核操作");
        }
        log.info("管理员 {} 审核认领申请 {}: {}", operatorUserId, claimId, action);
    }

    // ==================== 分类管理 ====================

    public List<Category> listAllCategories() {
        return categoryService.lambdaQuery()
                .orderByAsc(Category::getSort)
                .list();
    }

    @Transactional
    public Category createCategory(Category category) {
        if (category.getSort() == null) {
            category.setSort(0);
        }
        categoryService.save(category);
        return category;
    }

    @Transactional
    public Category updateCategory(Long id, Category input) {
        Category category = categoryService.getById(id);
        if (category == null) {
            throw new BusinessException(ResultCode.CATEGORY_NOT_FOUND);
        }
        if (input.getName() != null) category.setName(input.getName());
        if (input.getIcon() != null) category.setIcon(input.getIcon());
        if (input.getDescription() != null) category.setDescription(input.getDescription());
        if (input.getSort() != null) category.setSort(input.getSort());
        if (input.getStatus() != null) category.setStatus(input.getStatus());
        categoryService.updateById(category);
        return category;
    }

    @Transactional
    public void deleteCategory(Long id) {
        long count = lostFoundService.lambdaQuery()
                .eq(LostFound::getCategoryId, id)
                .count();
        if (count > 0) {
            throw new BusinessException(ResultCode.CATEGORY_IN_USE);
        }
        categoryService.removeById(id);
    }
}
