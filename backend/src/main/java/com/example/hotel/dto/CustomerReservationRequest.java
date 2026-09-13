package com.example.hotel.dto;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;

public record CustomerReservationRequest(
        @NotBlank(message = "不能为空")
        String idCard,
        @NotNull(message = "不能为空")
        Long roomId,
        @NotNull(message = "不能为空")
        @FutureOrPresent(message = "不能早于今天")
        LocalDate checkInDate,
        @NotNull(message = "不能为空")
        LocalDate checkOutDate,
        @NotNull(message = "不能为空")
        @Min(value = 1, message = "至少为 1")
        @Max(value = 6, message = "不能超过 6")
        Integer guestCount,
        String specialRequest
) {
}
