package com.gdu.academix.mapper;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.AttendanceRecordDto;

@Mapper
public interface AttendanceRecordMapper {
	int insertAttendanceRecord(AttendanceRecordDto record);
	List<AttendanceRecordDto> getAttendanceRecordByemployeeNo(int employeeNo);
	AttendanceRecordDto getAttendanceRecordByEmpNoAndDate(int employeeNo, String recordDate);
	int updateAttendanceRecord(AttendanceRecordDto record);
	int removeAttendanceRecord(int recordNo);
}
