package com.example.hotel.controller;

import com.example.hotel.common.ApiResponse;
import com.example.hotel.entity.RoomType;
import com.example.hotel.service.RoomTypeService;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/room-types")
public class RoomTypeController {

    private final RoomTypeService roomTypeService;

    public RoomTypeController(RoomTypeService roomTypeService) {
        this.roomTypeService = roomTypeService;
    }

    @GetMapping
    public ApiResponse<List<RoomType>> list() {
        return ApiResponse.success(roomTypeService.listAll());
    }
}
