package com.example.hotel.exception;

import com.example.hotel.common.ApiResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.ConstraintViolationException;
import java.io.IOException;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    /** 校验字段名 -> 中文名，用于把 "username" 之类的英文键转成中文提示。 */
    private static final Map<String, String> FIELD_LABELS = Map.ofEntries(
            Map.entry("username", "用户名"),
            Map.entry("password", "密码"),
            Map.entry("oldPassword", "当前密码"),
            Map.entry("newPassword", "新密码"),
            Map.entry("confirmPassword", "确认密码"),
            Map.entry("displayName", "显示名称"),
            Map.entry("phone", "手机号"),
            Map.entry("idCard", "身份证号"),
            Map.entry("guestName", "住客姓名"),
            Map.entry("fullName", "住客姓名"),
            Map.entry("memberLevel", "会员等级"),
            Map.entry("roomId", "房间"),
            Map.entry("roomTypeId", "房型"),
            Map.entry("roomNumber", "房号"),
            Map.entry("checkInDate", "入住日期"),
            Map.entry("checkOutDate", "离店日期"),
            Map.entry("guestCount", "入住人数"),
            Map.entry("status", "状态"),
            Map.entry("cleanStatus", "清洁状态"),
            Map.entry("floor", "楼层"),
            Map.entry("name", "房型名称"),
            Map.entry("basePrice", "基础价格"),
            Map.entry("maxGuests", "最大入住人数"),
            Map.entry("bedType", "床型"),
            Map.entry("area", "面积"),
            Map.entry("description", "房型描述"),
            Map.entry("amenities", "设施信息"),
            Map.entry("role", "用户角色")
    );

    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ApiResponse<Void>> handleBusinessException(BusinessException ex) {
        HttpStatus status = "登录已失效，请重新登录".equals(ex.getMessage()) ? HttpStatus.UNAUTHORIZED : HttpStatus.BAD_REQUEST;
        return ResponseEntity.status(status).body(ApiResponse.fail(ex.getMessage()));
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiResponse<Void> handleValidationException(MethodArgumentNotValidException ex) {
        String message = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(error -> {
                    String fieldLabel = FIELD_LABELS.getOrDefault(error.getField(), error.getField());
                    String defaultMessage = error.getDefaultMessage();
                    if (defaultMessage == null || defaultMessage.isBlank()) {
                        return fieldLabel + "不能为空";
                    }
                    return fieldLabel + defaultMessage;
                })
                .distinct()
                .collect(Collectors.joining("；"));
        return ApiResponse.fail(message);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiResponse<Void> handleConstraintViolation(ConstraintViolationException ex) {
        return ApiResponse.fail(ex.getMessage());
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ApiResponse<Void> handleException(Exception ex) {
        return ApiResponse.fail(ex.getMessage());
    }

    public static void writeJsonError(HttpServletResponse response, int status, String message) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json;charset=UTF-8");
        OBJECT_MAPPER.writeValue(response.getWriter(), ApiResponse.fail(message));
    }
}
