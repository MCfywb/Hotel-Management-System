package com.example.hotel.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.hotel.entity.RoomType;
import java.util.List;

public interface RoomTypeService extends IService<RoomType> {

    List<RoomType> listAll();

    RoomType getDetail(Long id);
}
