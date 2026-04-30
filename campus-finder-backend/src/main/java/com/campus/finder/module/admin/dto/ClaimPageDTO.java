package com.campus.finder.module.admin.dto;

import com.campus.finder.module.lost.dto.ClaimDTO;
import lombok.Data;

import java.util.List;

/**
 * 认领分页结果（复用 ClaimDTO）
 */
@Data
public class ClaimPageDTO {
    private long current;
    private long size;
    private long total;
    private long pages;
    private List<ClaimDTO> records;
}
