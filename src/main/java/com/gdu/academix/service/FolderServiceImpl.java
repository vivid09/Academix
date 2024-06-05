package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.FolderDto;
import com.gdu.academix.mapper.FolderMapper;
import com.gdu.academix.utils.MySecurityUtils;

@Transactional
@Service
public class FolderServiceImpl implements FolderService {

  private final FolderMapper folderMapper;
  
  public FolderServiceImpl(FolderMapper folderMapper) {
    this.folderMapper = folderMapper;
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
    String folderUploadPath = "/" + folderName;
    int employeeNo = Integer.parseInt(String.valueOf(params.get("employeeNo")));
    
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
