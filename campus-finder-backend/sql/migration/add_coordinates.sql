-- Migration: Add latitude/longitude fields to biz_lost_found table
-- Date: 2026-05-02
ALTER TABLE biz_lost_found
    ADD COLUMN latitude DOUBLE NULL COMMENT '纬度',
    ADD COLUMN longitude DOUBLE NULL COMMENT '经度';
