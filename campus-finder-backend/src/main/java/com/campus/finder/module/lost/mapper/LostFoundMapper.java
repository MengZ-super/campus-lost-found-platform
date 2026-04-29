package com.campus.finder.module.lost.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.finder.module.lost.entity.LostFound;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 失物招领 Mapper
 */
@Mapper
public interface LostFoundMapper extends BaseMapper<LostFound> {

    /**
     * 增加浏览次数
     */
    @Update("UPDATE biz_lost_found SET view_count = view_count + 1 WHERE id = #{id}")
    int incrementViewCount(@Param("id") Long id);

    /**
     * 增加收藏次数
     */
    @Update("UPDATE biz_lost_found SET favorite_count = favorite_count + 1 WHERE id = #{id}")
    int incrementFavoriteCount(@Param("id") Long id);

    /**
     * 减少收藏次数
     */
    @Update("UPDATE biz_lost_found SET favorite_count = GREATEST(favorite_count - 1, 0) WHERE id = #{id}")
    int decrementFavoriteCount(@Param("id") Long id);

    /**
     * 增加认领申请次数
     */
    @Update("UPDATE biz_lost_found SET claim_count = claim_count + 1 WHERE id = #{id}")
    int incrementClaimCount(@Param("id") Long id);
}
