package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.AttachDto;
import com.gdu.academix.dto.UploadDto;

@Mapper
public interface UploadMapper {
  int insertUpload(UploadDto upload);
  int insertAttach(AttachDto attach);
  int getUploadCount();
  List<UploadDto> getUploadList(Map<String, Object> map);
  UploadDto getUploadByNo(int uploadNo);
  List<AttachDto> getAttachList(int uploadNo);
  AttachDto getAttachByNo(int attachNo);
  int updateDownloadCount(int attachNo);
  int updateUpload(UploadDto upload);
  int deleteAttach(int attachNo);
  int deleteUpload(int uploadNo);
}
