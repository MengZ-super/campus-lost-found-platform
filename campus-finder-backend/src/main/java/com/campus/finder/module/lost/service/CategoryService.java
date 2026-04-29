package com.campus.finder.module.lost.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.campus.finder.module.lost.entity.Category;
import com.campus.finder.module.lost.mapper.CategoryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 分类服务
 */
@Service
@RequiredArgsConstructor
public class CategoryService extends ServiceImpl<CategoryMapper, Category> implements IService<Category> {

    /**
     * 获取所有启用的分类
     */
    public List<Category> findAllEnabled() {
        return lambdaQuery()
                .eq(Category::getStatus, 1)
                .orderByAsc(Category::getSort)
                .list();
    }

    /**
     * 根据ID查询
     */
    public Category findById(Long id) {
        return getById(id);
    }

    /**
     * 检查分类是否存在
     */
    public boolean existsById(Long id) {
        return id != null && lambdaQuery().eq(Category::getId, id).count() > 0;
    }
}
