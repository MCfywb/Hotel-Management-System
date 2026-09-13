package com.example.hotel.dto;

import jakarta.validation.constraints.NotBlank;

public record ReservationStatusRequest(
        @NotBlank(message = "不能为空")
        String status
) {
}
