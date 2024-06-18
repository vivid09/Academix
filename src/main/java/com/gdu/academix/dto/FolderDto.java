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
public class FolderDto {

  /**
   * 
   * @author 장윤수
   * 
   * @param folderNo         : 폴더 번호
   * @param folderName       : 폴더명
   * @param folderCreateDt   : 폴더 생성 일자
   * @param folderUploadPath : 폴더 경로
   * @param parentFolderNo   : 부모 폴더 번호
   * @param ownerNo          : 폴더 소유 직원 번호
   */
  
  private int folderNo, parentFolderNo, ownerNo;
  private String folderName, folderUploadPath;
  private Timestamp folderCreateDt;
}
