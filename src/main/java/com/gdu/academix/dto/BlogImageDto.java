package com.gdu.academix.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class BlogImageDto {
  private int driveAttachNo, notiPostNo, postNo;
  private String uploadPath, originalFilename, filesystemName; 
  private Date uploadDate;
}
