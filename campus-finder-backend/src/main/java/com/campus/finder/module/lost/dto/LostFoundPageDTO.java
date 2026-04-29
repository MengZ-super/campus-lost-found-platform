package com.campus.finder.module.lost.dto;

import lombok.Data;

import java.util.List;

/**
 * 失物招领分页结果DTO
 */
@Data
public class LostFoundPageDTO {

    private long current;
    private long size;
    private long total;
    private long pages;
    private List<LostFoundDTO> records;
}
