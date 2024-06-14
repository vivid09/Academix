package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.DepartmentsDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.LeaveUserDto;
import com.gdu.academix.dto.UserDto;

@Mapper
public interface UserMapper {
  EmployeesDto getUserByMap(Map<String, Object> map);
  LeaveUserDto getLeaveUserByMap(Map<String, Object> map);
  int insertUser(UserDto user);
  int deleteUser(int userNo);
  int insertAccessHistory(Map<String, Object> map);
  int updateAccessHistory(String sessionId);
  
  
  // 오채원 - 추가(24/05/28)
  List<EmployeesDto> getUserList();
  List<DepartmentsDto> getDepartmentsList();
  List<EmployeesDto> getUserProfileList(List<Integer> employeeNoList);
  EmployeesDto getUserProfileByNo(int EmployeeNo);
}
