package com.example.hotel.dto;

import jakarta.validation.constraints.NotNull;

public record ReservationRoomChangeRequest(
        @NotNull(message = "不能为空")
        Long roomId,
        String reason
) {
}
