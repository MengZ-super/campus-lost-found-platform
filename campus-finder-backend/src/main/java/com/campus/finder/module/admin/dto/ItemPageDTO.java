package com.campus.finder.module.admin.dto;

import com.campus.finder.module.lost.dto.LostFoundDTO;
import lombok.Data;

import java.util.List;

/**
 * 物品分页结果（复用 LostFoundDTO）
 */
@Data
public class ItemPageDTO {
    private long current;
    private long size;
    private long total;
    private long pages;
    private List<LostFoundDTO> records;
}
