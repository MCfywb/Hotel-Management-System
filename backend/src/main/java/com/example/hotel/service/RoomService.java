package com.example.hotel.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.hotel.entity.Room;
import java.util.List;

public interface RoomService extends IService<Room> {

    List<Room> listAllRooms();
}
