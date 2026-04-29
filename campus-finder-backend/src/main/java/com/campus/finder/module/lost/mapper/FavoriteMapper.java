package com.campus.finder.module.lost.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.campus.finder.module.lost.entity.Favorite;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 收藏 Mapper
 */
@Mapper
public interface FavoriteMapper extends BaseMapper<Favorite> {

    /**
     * 检查用户是否已收藏
     */
    @Select("SELECT * FROM biz_favorite WHERE user_id = #{userId} AND lost_found_id = #{lostFoundId} AND deleted = 0 LIMIT 1")
    Favorite findByUserIdAndLostFoundId(@Param("userId") Long userId, @Param("lostFoundId") Long lostFoundId);

    /**
     * 检查用户是否已收藏
     */
    @Select("SELECT COUNT(*) FROM biz_favorite WHERE user_id = #{userId} AND lost_found_id = #{lostFoundId} AND deleted = 0")
    int countByUserIdAndLostFoundId(@Param("userId") Long userId, @Param("lostFoundId") Long lostFoundId);
}
