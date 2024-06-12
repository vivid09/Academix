package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.FileDto;
import com.gdu.academix.dto.FolderDto;
import com.gdu.academix.dto.UploadDto;

@Mapper
public interface FolderMapper {

  int getDriveCount(int employeeNo);
  int insertDrive(FolderDto folderDto);
  
  List<FolderDto> getFolderList();
  List<FileDto> getFileList();
  
  int insertFile(FileDto fileDto);
  int insertFolder(FolderDto folderDto);
  
  List<UploadDto> getUploadList(Map<String, Object> map);
  
  FolderDto getFolderByMap(Map<String, Object> map);
	
}
