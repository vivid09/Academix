package com.gdu.academix.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.FolderDto;
import com.gdu.academix.mapper.FolderMapper;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MyPageUtils;
import com.gdu.academix.utils.MySecurityUtils;

@Transactional
@Service
public class FolderServiceImpl implements FolderService {

  private final FolderMapper folderMapper;
  private final MyFileUtils myFileUtils;
  private final MyPageUtils myPageUtils;

  public FolderServiceImpl(FolderMapper folderMapper, MyFileUtils myFileUtils, MyPageUtils myPageUtils) {
    this.folderMapper = folderMapper;
    this.myFileUtils = myFileUtils;
    this.myPageUtils = myPageUtils;
  }

  @Transactional(readOnly=true)
  @Override
  public ResponseEntity<Map<String, Object>> checkDrive(int employeeNo) {
    boolean exists = folderMapper.getDriveCount(employeeNo) > 0 ? true : false;
    return new ResponseEntity<>(Map.of("exists", exists)
        , HttpStatus.OK);
  }

  @Override
  public int createDrive(Map<String, Object> params) {
    String folderName = (String) params.get("folderName");
    int employeeNo = Integer.parseInt(String.valueOf(params.get("employeeNo")));
    String folderUploadPath = "/" + employeeNo + "_" + folderName;
    File dir = new File(folderUploadPath);
    if(!dir.exists()) {
      dir.mkdirs();
    }
    
    EmployeesDto employee = new EmployeesDto();
    employee.setEmployeeNo(employeeNo);
    FolderDto folder = FolderDto.builder()
                          .folderName(MySecurityUtils.getPreventXss(folderName))
                          .folderUploadPath(folderUploadPath)
                          .employee(employee)
                        .build();
    
    return folderMapper.insertDrive(folder);
  }
  
  @Override
  public int registerUpload(MultipartHttpServletRequest multipartRequest) {
    int employeeNo = Integer.parseInt(multipartRequest.getParameter("employeeNo"));
    List<MultipartFile> files = multipartRequest.getFiles("files");
    int insertFolderCount;
    if(files.get(0).getSize() == 0) {
      insertFolderCount = 1;
    } else {
      insertFolderCount = 0;
    }
    
    // int folderNo = ;
    
//    for (MultipartFile multipartFile : files) {
//      if(multipartFile != null && !multipartFile.isEmpty()) {
//        String fileUploadPath = ;
//        File dir = new File(fileUploadPath);
//      }
//      String originalFilename = multipartFile.getOriginalFilename();
//      String filesystemName = myFileUtils.getFilesystemName(originalFilename);
//      File file = new File(dir, filesystemName);
//    }
    
    
    EmployeesDto employee = new EmployeesDto();
    employee.setEmployeeNo(employeeNo);
    
    return 0;
  }
  
  @Override
  public int createFolder(Map<String, Object> params) {
    String folderName = (String) params.get("folderName");
    String folderUploadPath = "/" + folderName;
    int employeeNo = Integer.parseInt(String.valueOf(params.get("employeeNo")));
    int parentFolderNo = Integer.parseInt(String.valueOf(params.get("parentFolderNo")));
    
    EmployeesDto employee = new EmployeesDto();
    employee.setEmployeeNo(employeeNo);
    FolderDto folder = FolderDto.builder()
                          .folderName(MySecurityUtils.getPreventXss(folderName))
                          .folderUploadPath(folderUploadPath)
                          .parentFolderNo(parentFolderNo)
                          .employee(employee)
                        .build();
    
    return folderMapper.insertFolder(folder);
  }
  
  
  
  
  
  
}
