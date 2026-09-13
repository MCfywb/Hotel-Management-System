package com.example.hotel.dto;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.time.LocalDate;

public record CreateReservationRequest(
        @NotBlank(message = "不能为空")
        String guestName,
        @NotBlank(message = "不能为空")
        @Pattern(regexp = "^1\\d{10}$", message = "格式不正确")
        String phone,
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
        BigDecimal breakfastFee,
        BigDecimal extraBedFee,
        BigDecimal depositAmount,
        BigDecimal couponAmount,
        String channel,
        String specialRequest
) {
}
