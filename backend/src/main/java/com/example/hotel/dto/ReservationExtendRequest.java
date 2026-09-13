package com.example.hotel.dto;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;

public record ReservationExtendRequest(
        @NotNull(message = "不能为空")
        @FutureOrPresent(message = "不能早于今天")
        LocalDate checkOutDate
) {
}
