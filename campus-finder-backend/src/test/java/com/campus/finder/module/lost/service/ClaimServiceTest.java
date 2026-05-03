package com.campus.finder.module.lost.service;

import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.module.lost.entity.Claim;
import com.campus.finder.module.lost.entity.LostFound;
import com.campus.finder.module.lost.mapper.ClaimMapper;
import com.campus.finder.module.lost.mapper.LostFoundMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * 认领申请服务测试 - 验证重复提交防护
 */
@ExtendWith(MockitoExtension.class)
class ClaimServiceTest {

    @Mock
    private ClaimMapper claimMapper;

    @Mock
    private LostFoundMapper lostFoundMapper;

    @Mock
    private LostFoundService lostFoundService;

    private ClaimService claimService;

    private LostFound pendingItem;

    @BeforeEach
    void setUp() {
        claimService = new ClaimService(claimMapper, lostFoundMapper, lostFoundService);

        pendingItem = new LostFound();
        pendingItem.setId(1L);
        pendingItem.setUserId(100L);
        pendingItem.setStatus(LostFound.STATUS_PENDING);
    }

    private Claim createClaim(Long userId) {
        Claim claim = new Claim();
        claim.setLostFoundId(1L);
        claim.setUserId(userId);
        claim.setClaimType("found");
        claim.setDescription("这是我的物品");
        claim.setContact("13800138000");
        return claim;
    }

    @Test
    @DisplayName("重复提交认领申请应该被拒绝")
    void submitClaim_duplicateSubmission_shouldReject() {
        Claim claim = createClaim(200L);
        when(lostFoundService.getByIdOrThrow(1L)).thenReturn(pendingItem);
        when(claimMapper.countPendingByLostFoundIdAndUserId(1L, 200L)).thenReturn(1);

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            claimService.submitClaim(claim);
        });

        assertEquals("已提交过认领申请，请等待审核", exception.getMessage());
        verify(claimMapper, never()).insert(any(Claim.class));
    }

    @Test
    @DisplayName("不能认领自己发布的物品")
    void submitClaim_ownItem_shouldReject() {
        Claim claim = createClaim(100L);
        when(lostFoundService.getByIdOrThrow(1L)).thenReturn(pendingItem);

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            claimService.submitClaim(claim);
        });

        assertEquals("不能认领自己发布的物品", exception.getMessage());
    }

    @Test
    @DisplayName("物品已被认领时不能提交申请")
    void submitClaim_itemAlreadyClaimed_shouldReject() {
        pendingItem.setStatus(LostFound.STATUS_CLAIMED);
        Claim claim = createClaim(200L);
        when(lostFoundService.getByIdOrThrow(1L)).thenReturn(pendingItem);

        BusinessException exception = assertThrows(BusinessException.class, () -> {
            claimService.submitClaim(claim);
        });

        assertEquals("该物品不可认领", exception.getMessage());
    }
}