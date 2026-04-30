package com.campus.finder.common.result;

import org.springframework.http.HttpStatus;

/**
 * 响应码枚举
 */
public enum ResultCode {

    // 成功
    SUCCESS(200, "操作成功"),

    // 客户端错误 4xx
    BAD_REQUEST(400, "请求参数错误"),
    UNAUTHORIZED(401, "未授权，请登录"),
    FORBIDDEN(403, "禁止访问"),
    NOT_FOUND(404, "资源不存在"),
    METHOD_NOT_ALLOWED(405, "请求方法不允许"),

    // 认证相关 401
    TOKEN_EXPIRED(40101, "Token已过期"),
    TOKEN_INVALID(40102, "Token无效"),
    TOKEN_MALFORMED(40103, "Token格式错误"),
    REFRESH_TOKEN_EXPIRED(40104, "RefreshToken已过期"),

    // 业务错误 5xx
    USER_NOT_FOUND(40401, "用户不存在"),
    USER_DISABLED(40402, "用户已被禁用"),
    USERNAME_EXISTS(40901, "用户名已存在"),
    PHONE_EXISTS(40902, "手机号已注册"),
    STUDENT_ID_EXISTS(40903, "学号已注册"),
    PASSWORD_ERROR(40105, "密码错误"),
    OLD_PASSWORD_ERROR(40106, "原密码错误"),

    // 服务端错误
    INTERNAL_SERVER_ERROR(500, "服务器内部错误"),
    SERVICE_UNAVAILABLE(503, "服务暂不可用"),

    // 参数校验
    VALIDATION_ERROR(422, "参数校验失败"),

    // 业务错误
    BUSINESS_ERROR(40001, "业务处理失败"),

    // 失物招领相关
    LOST_FOUND_NOT_FOUND(40410, "物品记录不存在"),
    CLAIM_NOT_FOUND(40411, "认领申请不存在"),
    CATEGORY_NOT_FOUND(40412, "分类不存在"),
    NOT_OWNER(40310, "无权操作此记录"),
    ALREADY_CLAIMED(40910, "该物品已被认领"),
    ALREADY_APPLIED(40911, "已提交过认领申请"),
    CANNOT_CLAIM_OWN(40912, "不能认领自己发布的物品"),

    // 管理端
    CATEGORY_IN_USE(40920, "该分类下还有物品，无法删除");

    private final int code;
    private final String message;

    ResultCode(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public HttpStatus getHttpStatus() {
        return switch (this) {
            case SUCCESS -> HttpStatus.OK;
            case BAD_REQUEST, VALIDATION_ERROR -> HttpStatus.BAD_REQUEST;
            case UNAUTHORIZED, TOKEN_EXPIRED, TOKEN_INVALID, TOKEN_MALFORMED,
                 REFRESH_TOKEN_EXPIRED, PASSWORD_ERROR, OLD_PASSWORD_ERROR -> HttpStatus.UNAUTHORIZED;
            case FORBIDDEN -> HttpStatus.FORBIDDEN;
            case NOT_FOUND, USER_NOT_FOUND -> HttpStatus.NOT_FOUND;
            case METHOD_NOT_ALLOWED -> HttpStatus.METHOD_NOT_ALLOWED;
            case USERNAME_EXISTS, PHONE_EXISTS, STUDENT_ID_EXISTS -> HttpStatus.CONFLICT;
            case USER_DISABLED -> HttpStatus.FORBIDDEN;
            default -> HttpStatus.INTERNAL_SERVER_ERROR;
        };
    }
}
