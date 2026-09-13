package com.example.hotel.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record ChangePasswordRequest(
        @NotBlank(message = "不能为空")
        String oldPassword,
        @NotBlank(message = "不能为空")
        @Size(min = 6, max = 32, message = "长度必须为 6 到 32 位")
        String newPassword,
        @NotBlank(message = "不能为空")
        String confirmPassword
) {
}
