package com.campus.finder.module.lost.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.module.lost.entity.Claim;
import com.campus.finder.module.lost.entity.LostFound;
import com.campus.finder.module.lost.mapper.ClaimMapper;
import com.campus.finder.module.lost.mapper.LostFoundMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 认领申请服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ClaimService extends ServiceImpl<ClaimMapper, Claim> implements IService<Claim> {

    private final ClaimMapper claimMapper;
    private final LostFoundMapper lostFoundMapper;
    private final LostFoundService lostFoundService;

    /**
     * 根据ID查询
     */
    public Claim findById(Long id) {
        return claimMapper.selectById(id);
    }

    /**
     * 根据ID查询或抛出异常
     */
    public Claim getByIdOrThrow(Long id) {
        Claim claim = findById(id);
        if (claim == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "认领申请不存在");
        }
        return claim;
    }

    /**
     * 根据失物招领ID查询所有申请
     */
    public List<Claim> findByLostFoundId(Long lostFoundId) {
        return claimMapper.findByLostFoundId(lostFoundId);
    }

    /**
     * 根据用户ID查询申请
     */
    public List<Claim> findByUserId(Long userId) {
        return lambdaQuery()
                .eq(Claim::getUserId, userId)
                .orderByDesc(Claim::getCreateTime)
                .list();
    }

    /**
     * 提交认领申请
     */
    @Transactional
    public Claim submitClaim(Claim claim) {
        Long lostFoundId = claim.getLostFoundId();
        Long userId = claim.getUserId();

        // 检查物品是否存在且可认领
        LostFound lostFound = lostFoundService.getByIdOrThrow(lostFoundId);
        if (!lostFound.isPending()) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "该物品不可认领");
        }

        // 不能认领自己发布的物品
        if (lostFound.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "不能认领自己发布的物品");
        }

        // 检查是否已有待处理的认领申请
        if (claimMapper.countPendingByLostFoundIdAndUserId(lostFoundId, userId) > 0) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "已提交过认领申请，请等待审核");
        }

        // 设置初始状态
        claim.setStatus(Claim.STATUS_PENDING);

        // 保存申请
        save(claim);

        // 增加认领计数
        lostFoundMapper.incrementClaimCount(lostFoundId);

        return claim;
    }

    /**
     * 审核通过认领申请
     */
    @Transactional
    public Claim approveClaim(Long claimId, Long reviewerId) {
        Claim claim = getByIdOrThrow(claimId);

        if (!claim.getStatus().equals(Claim.STATUS_PENDING)) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "只能审核待处理的申请");
        }

        // 更新申请状态
        claim.setStatus(Claim.STATUS_APPROVED);
        claim.setReviewedBy(reviewerId);
        claim.setReviewedTime(LocalDateTime.now());
        updateById(claim);

        // 更新物品状态为已认领
        Long lostFoundId = claim.getLostFoundId();
        LostFound lostFound = lostFoundService.getByIdOrThrow(lostFoundId);
        lostFound.setStatus(LostFound.STATUS_CLAIMED);
        lostFound.setClaimedBy(claim.getUserId());
        lostFound.setClaimedTime(LocalDateTime.now());
        lostFoundService.updateById(lostFound);

        // 拒绝该物品的其他申请
        lambdaUpdate()
                .eq(Claim::getLostFoundId, lostFoundId)
                .eq(Claim::getStatus, Claim.STATUS_PENDING)
                .ne(Claim::getId, claimId)
                .set(Claim::getStatus, Claim.STATUS_REJECTED)
                .set(Claim::getRemark, "该物品已被他人认领")
                .update();

        return claim;
    }

    /**
     * 拒绝认领申请
     */
    @Transactional
    public Claim rejectClaim(Long claimId, String reason, Long reviewerId) {
        Claim claim = getByIdOrThrow(claimId);

        if (!claim.getStatus().equals(Claim.STATUS_PENDING)) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "只能审核待处理的申请");
        }

        claim.setStatus(Claim.STATUS_REJECTED);
        claim.setRemark(reason);
        claim.setReviewedBy(reviewerId);
        claim.setReviewedTime(LocalDateTime.now());
        updateById(claim);

        return claim;
    }

    /**
     * 取消申请
     */
    @Transactional
    public void cancelClaim(Long claimId, Long userId) {
        Claim claim = getByIdOrThrow(claimId);

        // 只能取消自己的申请
        if (!claim.getUserId().equals(userId)) {
            throw new BusinessException(ResultCode.FORBIDDEN, "无权操作此申请");
        }

        if (!claim.getStatus().equals(Claim.STATUS_PENDING)) {
            throw new BusinessException(ResultCode.BUSINESS_ERROR, "只能取消待审核的申请");
        }

        claim.setStatus(Claim.STATUS_CANCELLED);
        updateById(claim);
    }

    /**
     * 检查用户是否已申请
     */
    public boolean hasApplied(Long lostFoundId, Long userId) {
        return claimMapper.countByLostFoundIdAndUserId(lostFoundId, userId) > 0;
    }

    /**
     * 获取物品待处理的申请数量
     */
    public long countPendingByLostFoundId(Long lostFoundId) {
        return lambdaQuery()
                .eq(Claim::getLostFoundId, lostFoundId)
                .eq(Claim::getStatus, Claim.STATUS_PENDING)
                .count();
    }
}
