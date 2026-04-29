package com.campus.finder.module.lost.dto;

import com.campus.finder.module.lost.entity.Category;
import lombok.Data;

/**
 * 分类DTO
 */
@Data
public class CategoryDTO {

    private Long id;
    private String name;
    private String icon;
    private String description;
    private Integer sort;

    /**
     * 转换为DTO
     */
    public static CategoryDTO fromEntity(Category category) {
        if (category == null) {
            return null;
        }
        CategoryDTO dto = new CategoryDTO();
        dto.setId(category.getId());
        dto.setName(category.getName());
        dto.setIcon(category.getIcon());
        dto.setDescription(category.getDescription());
        dto.setSort(category.getSort());
        return dto;
    }
}
