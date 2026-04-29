package com.campus.finder.module.lost.controller;

import com.campus.finder.common.result.Result;
import com.campus.finder.module.lost.dto.CategoryDTO;
import com.campus.finder.module.lost.entity.Category;
import com.campus.finder.module.lost.service.CategoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 分类控制器
 */
@Tag(name = "物品分类", description = "物品分类管理相关接口")
@RestController
@RequestMapping("/api/lost/category")
@RequiredArgsConstructor
public class CategoryController {

    private final CategoryService categoryService;

    /**
     * 获取所有分类
     */
    @Operation(summary = "获取分类列表", description = "获取所有启用的物品分类")
    @GetMapping("/list")
    public Result<List<CategoryDTO>> listCategories() {
        List<Category> categories = categoryService.findAllEnabled();
        List<CategoryDTO> dtos = categories.stream()
                .map(CategoryDTO::fromEntity)
                .collect(Collectors.toList());
        return Result.success(dtos);
    }
}
