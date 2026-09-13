package com.example.hotel.dto;

import jakarta.validation.constraints.NotBlank;

public record GuestRequest(
        @NotBlank(message = "不能为空")
        String fullName,
        @NotBlank(message = "不能为空")
        String phone,
        @NotBlank(message = "不能为空")
        String idCard,
        @NotBlank(message = "不能为空")
        String memberLevel,
        String remark
) {
}
