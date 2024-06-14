package com.gdu.academix.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FileDto {
	
  /**
   * 
   * @author 장윤수
   * 
   * @param fileNo           : 파일 번호
   * @param fileUploadPath   : 업로드 경로
   * @param filesystemName   : 파일 이름
   * @param originalFilename : 원본 이름
   * @param fileUploadDt     : 업로드 날짜
   * @param ownerNo          : 파일 소유 직원 번호
   * @param FolderDto folder -> folderNo : 폴더 번호
   */
  
  private int fileNo, ownerNo;
  private String fileUploadPath, filesystemName, originalFilename;
  private Timestamp fileUploadDt;
  private FolderDto folder;
  
}
