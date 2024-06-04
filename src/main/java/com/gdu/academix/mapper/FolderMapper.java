package com.gdu.academix.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.FolderDto;

@Mapper
public interface FolderMapper {

  int getDriveCount(int employeeNo);
  int insertFolder(FolderDto folderDto);
  
  FolderDto getFolderByMap(Map<String, Object> map);
	
}
