package com.gdu.academix.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.AttendanceRecordDto;

@Mapper
public interface AttendanceRecordMapper {
	int insertAttendanceRecord(AttendanceRecordDto record);
	List<AttendanceRecordDto> getAttendanceRecordByemployeeNo(int ownerNo);
	int updateAttendanceRecord(AttendanceRecordDto record);
	int removeAttendanceRecord(int recordNo);
}
