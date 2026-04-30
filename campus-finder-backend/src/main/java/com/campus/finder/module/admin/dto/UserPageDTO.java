package com.campus.finder.module.admin.dto;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.campus.finder.module.user.entity.User;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 用户分页结果
 */
@Data
public class UserPageDTO {
    private long current;
    private long size;
    private long total;
    private long pages;
    private List<UserRow> records;

    @Data
    public static class UserRow {
        private Long id;
        private String username;
        private String nickname;
        private String phone;
        private String studentId;
        private String email;
        private Integer gender;
        private Integer status;
        private String role;
        private String avatar;
        private LocalDateTime lastLoginTime;
        private LocalDateTime createTime;

        public static UserRow fromEntity(User user) {
            if (user == null) return null;
            UserRow row = new UserRow();
            row.setId(user.getId());
            row.setUsername(user.getUsername());
            row.setNickname(user.getNickname());
            row.setPhone(user.getPhone());
            row.setStudentId(user.getStudentId());
            row.setEmail(user.getEmail());
            row.setGender(user.getGender());
            row.setStatus(user.getStatus());
            row.setRole(user.getRole());
            row.setAvatar(user.getAvatar());
            row.setLastLoginTime(user.getLastLoginTime());
            row.setCreateTime(user.getCreateTime());
            return row;
        }
    }

    public static UserPageDTO fromPage(Page<User> page) {
        UserPageDTO dto = new UserPageDTO();
        dto.setCurrent(page.getCurrent());
        dto.setSize(page.getSize());
        dto.setTotal(page.getTotal());
        dto.setPages(page.getPages());
        dto.setRecords(page.getRecords().stream().map(UserRow::fromEntity).toList());
        return dto;
    }
}
