package com.campus.finder.module.lost.dto;

import lombok.Data;

import java.util.List;

/**
 * 认领申请分页结果DTO
 */
@Data
public class ClaimPageDTO {

    private long current;
    private long size;
    private long total;
    private long pages;
    private List<ClaimDTO> records;
}
