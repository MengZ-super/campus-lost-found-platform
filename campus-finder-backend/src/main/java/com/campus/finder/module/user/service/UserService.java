package com.campus.finder.module.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.campus.finder.common.exception.BusinessException;
import com.campus.finder.common.result.ResultCode;
import com.campus.finder.module.user.entity.User;
import com.campus.finder.module.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * 用户服务
 */
@Service
@RequiredArgsConstructor
public class UserService extends ServiceImpl<UserMapper, User> implements IService<User> {

    /**
     * 根据用户名查询
     */
    public User findByUsername(String username) {
        return lambdaQuery()
                .eq(User::getUsername, username)
                .one();
    }

    /**
     * 根据手机号查询
     */
    public User findByPhone(String phone) {
        return lambdaQuery()
                .eq(User::getPhone, phone)
                .one();
    }

    /**
     * 根据学号查询
     */
    public User findByStudentId(String studentId) {
        return lambdaQuery()
                .eq(User::getStudentId, studentId)
                .isNotNull(User::getStudentId)
                .eq(User::getStudentId, studentId)
                .one();
    }

    /**
     * 根据ID查询（不含已删除）
     */
    public User findById(Long id) {
        return lambdaQuery()
                .eq(User::getId, id)
                .one();
    }

    /**
     * 检查用户名是否存在
     */
    public boolean existsByUsername(String username) {
        return lambdaQuery()
                .eq(User::getUsername, username)
                .count() > 0;
    }

    /**
     * 检查手机号是否存在
     */
    public boolean existsByPhone(String phone) {
        return lambdaQuery()
                .eq(User::getPhone, phone)
                .count() > 0;
    }

    /**
     * 检查学号是否存在
     */
    public boolean existsByStudentId(String studentId) {
        if (studentId == null || studentId.isBlank()) {
            return false;
        }
        return lambdaQuery()
                .eq(User::getStudentId, studentId)
                .count() > 0;
    }

    /**
     * 更新登录信息
     */
    public void updateLoginInfo(Long userId, String loginIp) {
        User user = new User();
        user.setId(userId);
        user.setLastLoginTime(LocalDateTime.now());
        user.setLastLoginIp(loginIp);
        baseMapper.updateById(user);
    }

    /**
     * 检查用户状态
     */
    public User checkUserStatus(Long userId) {
        User user = findById(userId);
        if (user == null) {
            throw new BusinessException(ResultCode.USER_NOT_FOUND);
        }
        if (user.isDisabled()) {
            throw new BusinessException(ResultCode.USER_DISABLED);
        }
        return user;
    }
}
