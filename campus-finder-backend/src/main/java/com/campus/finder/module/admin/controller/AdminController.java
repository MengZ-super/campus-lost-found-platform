package com.campus.finder.module.admin.controller;

import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.Result;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.module.admin.dto.*;
import com.campus.finder.module.admin.service.AdminService;
import com.campus.finder.module.lost.dto.ReviewClaimRequest;
import com.campus.finder.module.lost.entity.Category;
import com.campus.finder.module.user.entity.User;
import com.campus.finder.module.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@Tag(name = "管理后台", description = "管理员专属接口")
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
@SecurityRequirement(name = "Bearer")
public class AdminController {

    private final AdminService adminService;
    private final UserService userService;

    private Long getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null) throw new BusinessException(ResultCode.UNAUTHORIZED);
        Object details = auth.getDetails();
        if (details instanceof Long) return (Long) details;
        User user = userService.findByUsername(auth.getName());
        if (user == null) throw new BusinessException(ResultCode.USER_NOT_FOUND);
        return user.getId();
    }

    // ==================== 仪表盘 ====================

    @Operation(summary = "仪表盘", description = "获取后台首页统计数据")
    @GetMapping("/dashboard")
    public Result<DashboardDTO> dashboard() {
        return Result.success(adminService.getDashboard());
    }

    // ==================== 用户管理 ====================

    @Operation(summary = "用户列表", description = "分页查询所有用户")
    @GetMapping("/users")
    public Result<UserPageDTO> listUsers(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            AdminUserQueryRequest query) {
        return Result.success(adminService.listUsers(pageNum, pageSize, query));
    }

    @Operation(summary = "用户详情", description = "查看指定用户的详细信息")
    @GetMapping("/users/{id}")
    public Result<User> userDetail(@PathVariable Long id) {
        return Result.success(adminService.getUserDetail(id));
    }

    @Operation(summary = "切换用户状态", description = "启用或禁用用户")
    @PutMapping("/users/{id}/status")
    public Result<Void> toggleUserStatus(@PathVariable Long id) {
        Long operatorId = getCurrentUserId();
        adminService.toggleUserStatus(id, operatorId);
        return Result.success();
    }

    // ==================== 物品管理 ====================

    @Operation(summary = "物品列表", description = "分页查询所有物品")
    @GetMapping("/items")
    public Result<ItemPageDTO> listItems(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String itemType,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Long categoryId) {
        return Result.success(adminService.listItems(pageNum, pageSize, keyword, itemType, status, categoryId));
    }

    @Operation(summary = "强制关闭", description = "管理员强制关闭物品记录")
    @PostMapping("/items/{id}/close")
    public Result<Void> forceClose(@PathVariable Long id, @RequestBody Map<String, String> body) {
        Long operatorId = getCurrentUserId();
        String reason = body.getOrDefault("reason", "管理员强制关闭");
        adminService.forceCloseItem(id, reason, operatorId);
        return Result.success();
    }

    @Operation(summary = "强制删除", description = "管理员强制删除物品记录")
    @DeleteMapping("/items/{id}")
    public Result<Void> forceDelete(@PathVariable Long id) {
        adminService.forceDeleteItem(id);
        return Result.success();
    }

    // ==================== 认领管理 ====================

    @Operation(summary = "认领列表", description = "分页查询所有认领申请")
    @GetMapping("/claims")
    public Result<ClaimPageDTO> listClaims(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Long lostFoundId) {
        return Result.success(adminService.listClaims(pageNum, pageSize, status, lostFoundId));
    }

    @Operation(summary = "审核认领", description = "管理员审核认领申请")
    @PostMapping("/claims/{id}/review")
    public Result<Void> reviewClaim(@PathVariable Long id, @Valid @RequestBody ReviewClaimRequest request) {
        Long operatorId = getCurrentUserId();
        adminService.reviewClaim(id, request.getAction(), request.getRemark(), operatorId);
        return Result.success();
    }

    // ==================== 分类管理 ====================

    @Operation(summary = "全部分类", description = "获取所有分类（含禁用）")
    @GetMapping("/categories")
    public Result<List<Category>> listCategories() {
        return Result.success(adminService.listAllCategories());
    }

    @Operation(summary = "创建分类", description = "新增物品分类")
    @PostMapping("/categories")
    public Result<Category> createCategory(@RequestBody Category category) {
        return Result.success(adminService.createCategory(category));
    }

    @Operation(summary = "更新分类", description = "修改物品分类信息")
    @PutMapping("/categories/{id}")
    public Result<Category> updateCategory(@PathVariable Long id, @RequestBody Category category) {
        return Result.success(adminService.updateCategory(id, category));
    }

    @Operation(summary = "删除分类", description = "删除物品分类")
    @DeleteMapping("/categories/{id}")
    public Result<Void> deleteCategory(@PathVariable Long id) {
        adminService.deleteCategory(id);
        return Result.success();
    }
}
