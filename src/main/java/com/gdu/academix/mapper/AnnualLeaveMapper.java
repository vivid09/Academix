package com.gdu.academix.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.AttendanceRecordDto;

@Mapper
public interface AnnualLeaveMapper {
	List<AttendanceRecordDto> getAnnualLeaveStatusByemployeeNo(int employeeNo);
}
