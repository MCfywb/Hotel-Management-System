package com.example.hotel.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.hotel.entity.Room;
import com.example.hotel.mapper.RoomMapper;
import com.example.hotel.service.RoomService;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class RoomServiceImpl extends ServiceImpl<RoomMapper, Room> implements RoomService {

    @Override
    public List<Room> listAllRooms() {
        return list(new LambdaQueryWrapper<Room>().orderByAsc(Room::getRoomNumber));
    }
}
