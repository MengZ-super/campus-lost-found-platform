package com.campus.finder.module.lost.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.campus.finder.module.lost.entity.Claim;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 认领申请 Mapper
 */
@Mapper
public interface ClaimMapper extends BaseMapper<Claim> {

    /**
     * 检查用户是否已申请过该物品
     */
    @Select("SELECT COUNT(*) FROM biz_claim WHERE lost_found_id = #{lostFoundId} AND user_id = #{userId} AND deleted = 0")
    int countByLostFoundIdAndUserId(@Param("lostFoundId") Long lostFoundId, @Param("userId") Long userId);

    /**
     * 检查用户是否有待处理的认领申请
     */
    @Select("SELECT COUNT(*) FROM biz_claim WHERE lost_found_id = #{lostFoundId} AND user_id = #{userId} AND status = 'pending' AND deleted = 0")
    int countPendingByLostFoundIdAndUserId(@Param("lostFoundId") Long lostFoundId, @Param("userId") Long userId);

    /**
     * 查询物品的所有申请
     */
    @Select("SELECT * FROM biz_claim WHERE lost_found_id = #{lostFoundId} AND deleted = 0 ORDER BY create_time DESC")
    List<Claim> findByLostFoundId(@Param("lostFoundId") Long lostFoundId);
}
