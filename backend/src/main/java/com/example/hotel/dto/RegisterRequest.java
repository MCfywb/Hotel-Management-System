package com.example.hotel.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record RegisterRequest(
        @NotBlank(message = "不能为空")
        @Size(min = 4, max = 32, message = "长度必须为 4 到 32 位")
        String username,
        @NotBlank(message = "不能为空")
        @Size(max = 32, message = "长度不能超过 32 个字符")
        String displayName,
        @NotBlank(message = "不能为空")
        @Size(min = 6, max = 32, message = "长度必须为 6 到 32 位")
        String password,
        @NotBlank(message = "不能为空")
        String confirmPassword,
        String role
) {
}
