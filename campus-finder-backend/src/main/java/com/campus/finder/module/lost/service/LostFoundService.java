package com.campus.finder.module.lost.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.module.lost.entity.Favorite;
import com.campus.finder.module.lost.entity.LostFound;
import com.campus.finder.module.lost.mapper.FavoriteMapper;
import com.campus.finder.module.lost.mapper.LostFoundMapper;
import com.campus.finder.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 失物招领服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class LostFoundService extends ServiceImpl<LostFoundMapper, LostFound> implements IService<LostFound> {

    private final LostFoundMapper lostFoundMapper;
    private final FavoriteMapper favoriteMapper;
    private final UserService userService;

    // ========== 基础CRUD ==========

    /**
     * 根据ID查询
     */
    public LostFound findById(Long id) {
        return lostFoundMapper.selectById(id);
    }

    /**
     * 根据ID查询并检查存在性
     */
    public LostFound getByIdOrThrow(Long id) {
        LostFound lostFound = findById(id);
        if (lostFound == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "物品记录不存在");
        }
        return lostFound;
    }

    /**
     * 创建失物招领记录
     */
    public LostFound create(LostFound lostFound) {
        // 初始化统计字段
        lostFound.setViewCount(0);
        lostFound.setFavoriteCount(0);
        lostFound.setClaimCount(0);
        lostFound.setStatus(LostFound.STATUS_PENDING);

        save(lostFound);
        return lostFound;
    }

    /**
     * 更新失物招领记录
     */
    public LostFound update(LostFound lostFound) {
        updateById(lostFound);
        return lostFound;
    }

    /**
     * 删除记录
     */
    public void delete(Long id) {
        removeById(id);
    }

    // ========== 查询方法 ==========

    /**
     * 分页查询失物招领列表
     */
    public Page<LostFound> findPage(Page<LostFound> page, LambdaQueryWrapper<LostFound> wrapper) {
        return lostFoundMapper.selectPage(page, wrapper);
    }

    /**
     * 根据用户ID查询
     */
    public List<LostFound> findByUserId(Long userId) {
        return lambdaQuery()
                .eq(LostFound::getUserId, userId)
                .orderByDesc(LostFound::getCreateTime)
                .list();
    }

    /**
     * 根据分类查询
     */
    public List<LostFound> findByCategoryId(Long categoryId) {
        return lambdaQuery()
                .eq(LostFound::getCategoryId, categoryId)
                .eq(LostFound::getStatus, LostFound.STATUS_PENDING)
                .orderByDesc(LostFound::getCreateTime)
                .list();
    }

    /**
     * 搜索标题和描述
     */
    public List<LostFound> searchByKeyword(String keyword) {
        return lambdaQuery()
                .like(LostFound::getTitle, keyword)
                .or()
                .like(LostFound::getDescription, keyword)
                .or()
                .like(LostFound::getLocation, keyword)
                .orderByDesc(LostFound::getCreateTime)
                .list();
    }

    // ========== 状态流转 ==========

    /**
     * 认领物品
     */
    @Transactional
    public LostFound claimItem(Long id, Long claimedBy) {
        LostFound lostFound = getByIdOrThrow(id);

        if (!lostFound.isPending()) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "该物品不可认领");
        }

        lostFound.setStatus(LostFound.STATUS_CLAIMED);
        lostFound.setClaimedBy(claimedBy);
        lostFound.setClaimedTime(LocalDateTime.now());

        updateById(lostFound);
        return lostFound;
    }

    /**
     * 关闭物品记录
     */
    @Transactional
    public LostFound closeItem(Long id, String reason) {
        LostFound lostFound = getByIdOrThrow(id);

        if (lostFound.isClosed()) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "该记录已关闭");
        }

        lostFound.setStatus(LostFound.STATUS_CLOSED);
        lostFound.setCloseReason(reason);
        lostFound.setClosedTime(LocalDateTime.now());

        updateById(lostFound);
        return lostFound;
    }

    /**
     * 重新开启待认领状态
     */
    @Transactional
    public LostFound reopenItem(Long id) {
        LostFound lostFound = getByIdOrThrow(id);

        if (!lostFound.isClaimed()) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "只能重新开启已认领的物品");
        }

        lostFound.setStatus(LostFound.STATUS_PENDING);
        lostFound.setClaimedBy(null);
        lostFound.setClaimedTime(null);

        updateById(lostFound);
        return lostFound;
    }

    // ========== 统计相关 ==========

    /**
     * 增加浏览次数
     */
    public void incrementViewCount(Long id) {
        lostFoundMapper.incrementViewCount(id);
    }

    /**
     * 检查是否是物品发布者
     */
    public boolean isOwner(Long id, Long userId) {
        LostFound lostFound = findById(id);
        return lostFound != null && lostFound.getUserId().equals(userId);
    }

    // ========== 收藏相关 ==========

    /**
     * 收藏物品
     */
    @Transactional
    public void favorite(Long lostFoundId, Long userId) {
        // 检查是否已收藏
        if (isFavorited(lostFoundId, userId)) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "已收藏该物品");
        }

        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setLostFoundId(lostFoundId);
        favoriteMapper.insert(favorite);

        // 增加收藏计数
        lostFoundMapper.incrementFavoriteCount(lostFoundId);
    }

    /**
     * 取消收藏
     */
    @Transactional
    public void unfavorite(Long lostFoundId, Long userId) {
        Favorite favorite = favoriteMapper.findByUserIdAndLostFoundId(userId, lostFoundId);
        if (favorite == null) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "未收藏该物品");
        }

        favoriteMapper.deleteById(favorite.getId());

        // 减少收藏计数
        lostFoundMapper.decrementFavoriteCount(lostFoundId);
    }

    /**
     * 检查是否已收藏
     */
    public boolean isFavorited(Long lostFoundId, Long userId) {
        return favoriteMapper.countByUserIdAndLostFoundId(userId, lostFoundId) > 0;
    }

    /**
     * 获取用户的收藏列表
     */
    public List<LostFound> findFavoritesByUserId(Long userId) {
        // 获取所有收藏记录的lostFoundId
        List<Long> lostFoundIds = favoriteMapper.selectList(
                new LambdaQueryWrapper<Favorite>()
                        .eq(Favorite::getUserId, userId)
        ).stream().map(Favorite::getLostFoundId).toList();

        if (lostFoundIds.isEmpty()) {
            return List.of();
        }

        return lambdaQuery()
                .in(LostFound::getId, lostFoundIds)
                .list();
    }
}
