package com.example.hotel.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.hotel.entity.RoomType;
import com.example.hotel.exception.BusinessException;
import com.example.hotel.mapper.RoomTypeMapper;
import com.example.hotel.service.RoomTypeService;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class RoomTypeServiceImpl extends ServiceImpl<RoomTypeMapper, RoomType> implements RoomTypeService {

    @Override
    public List<RoomType> listAll() {
        return list(new LambdaQueryWrapper<RoomType>().orderByAsc(RoomType::getId));
    }

    @Override
    public RoomType getDetail(Long id) {
        RoomType roomType = getById(id);
        if (roomType == null) {
            throw new BusinessException("房型不存在");
        }
        return roomType;
    }
}
