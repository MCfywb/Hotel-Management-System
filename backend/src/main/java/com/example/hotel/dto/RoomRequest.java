package com.example.hotel.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record RoomRequest(
        @NotBlank(message = "不能为空")
        String roomNumber,
        @NotNull(message = "不能为空")
        Long roomTypeId,
        @NotNull(message = "不能为空")
        @Min(value = 1, message = "至少为 1")
        Integer floor,
        @NotBlank(message = "不能为空")
        String status,
        @NotBlank(message = "不能为空")
        String cleanStatus
) {
}
