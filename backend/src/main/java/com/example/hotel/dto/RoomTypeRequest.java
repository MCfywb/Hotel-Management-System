package com.example.hotel.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public record RoomTypeRequest(
        @NotBlank(message = "不能为空")
        String name,
        @NotNull(message = "不能为空")
        BigDecimal basePrice,
        @NotNull(message = "不能为空")
        @Min(value = 1, message = "至少为 1")
        Integer maxGuests,
        @NotBlank(message = "不能为空")
        String bedType,
        @NotNull(message = "不能为空")
        @Min(value = 1, message = "至少为 1")
        Integer area,
        @NotBlank(message = "不能为空")
        String description,
        @NotBlank(message = "不能为空")
        String amenities
) {
}
