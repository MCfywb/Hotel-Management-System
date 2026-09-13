package com.example.hotel.dto;

import jakarta.validation.constraints.NotBlank;

public record CustomerLoginRequest(
        @NotBlank(message = "不能为空")
        String phone,
        @NotBlank(message = "不能为空")
        String password
) {
}
