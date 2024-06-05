package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.LeaveRequestDto;
import com.gdu.academix.dto.RequestAttachDto;
import com.gdu.academix.dto.RequestsDto;

@Mapper
public interface RequestsMapper {

  int insertRequest(RequestsDto requests);
  int insertLeaveRequest(LeaveRequestDto leaveRequest);
  int insertRequestsAttach(RequestAttachDto attach);
  List<RequestsDto>getList(Map<String, Object> map);
  int getRequestsCount();
  LeaveRequestDto getRequestsbyNo(int requestNo);
  int requestApproval(RequestsDto requests);
  int requestReject(RequestsDto requests);
  List<LeaveRequestDto>getListPage(Map<String, Object> map);
  int requestModify(LeaveRequestDto leaveRequest);
  int requestModify2(RequestsDto requests);
  int requestModify3(RequestAttachDto attach);
  int removeRequest(int requestNo);
  int removeRequest2(int requestNo);
  int removeRequest3(int requestNo);
}
