package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.EventDto;

@Mapper
public interface EventMapper {
	int insertEvent(EventDto event);
	List<EventDto> getEventListByOwnerNo(int ownerNo);
	int updateEvent(EventDto event);
	int removeEvent(int eventNo);
}
