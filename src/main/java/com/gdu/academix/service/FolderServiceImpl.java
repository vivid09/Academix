package com.gdu.academix.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.FileDto;
import com.gdu.academix.dto.FolderDto;
import com.gdu.academix.mapper.FolderMapper;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MyPageUtils;
import com.gdu.academix.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

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
    int ownerNo = Integer.parseInt(String.valueOf(params.get("ownerNo")));
    String folderUploadPath = "c:/" + ownerNo + "_" + folderName;
    File dir = new File(folderUploadPath);
    if(!dir.exists()) {
      dir.mkdirs();
    }
    
    FolderDto folder = FolderDto.builder()
                          .folderName(MySecurityUtils.getPreventXss(folderName))
                          .folderUploadPath(folderUploadPath)
                          .ownerNo(ownerNo)
                        .build();
    
    return folderMapper.insertDrive(folder);
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> getFileList() {
    Map<String, Object> map = Map.of("file", folderMapper.getFileList(), "folder", folderMapper.getFolderList());
    return ResponseEntity.ok(map);
  }
  
  @Override
  public boolean registerUpload(MultipartHttpServletRequest multipartRequest) {
    int ownerNo = Integer.parseInt(multipartRequest.getParameter("ownerNo"));
    int folderNo = Integer.parseInt(multipartRequest.getParameter("folderNo"));
    FolderDto folder = new FolderDto();
    folder.setFolderNo(folderNo);
    
    List<MultipartFile> files = multipartRequest.getFiles("files");
    int insertFolderCount;
    if(files.get(0).getSize() == 0) {
      insertFolderCount = 1;
    } else {
      insertFolderCount = 0;
    }
    
    for (MultipartFile multipartFile : files) {
      if(multipartFile != null && !multipartFile.isEmpty()) {
        String fileUploadPath = multipartRequest.getParameter("folderUploadPath");
        File dir = new File(fileUploadPath);
        
        String originalFilename = multipartFile.getOriginalFilename();
        String filesystemName = myFileUtils.getFilesystemName(originalFilename);
        File file = new File(dir, filesystemName);
        
        try {
          multipartFile.transferTo(file);
          
          FileDto fileDto = FileDto.builder()
                            .fileUploadPath(fileUploadPath)
                            .filesystemName(filesystemName)
                            .originalFilename(originalFilename)
                            .folder(folder)
                            .ownerNo(ownerNo)
                          .build();
          
          insertFolderCount += folderMapper.insertFile(fileDto);
          
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    }
    return insertFolderCount == files.size();
  }
  
  @Override
  public int addFolder(Map<String, Object> params) {
    int ownerNo = Integer.parseInt(String.valueOf(params.get("ownerNo")));
    int parentFolderNo = Integer.parseInt(String.valueOf(params.get("parentFolderNo")));
    String parentFolderUploadPath = (String) params.get("parentFolderUploadPath");
    String folderName = (String) params.get("folderName");
    String folderUploadPath = parentFolderUploadPath + "/" + folderName;
    
    File dir = new File(folderUploadPath);
    if(!dir.exists()) {
      dir.mkdirs();
    }
    
    FolderDto folder = FolderDto.builder()
                          .folderName(MySecurityUtils.getPreventXss(folderName))
                          .folderUploadPath(folderUploadPath)
                          .parentFolderNo(parentFolderNo)
                          .ownerNo(ownerNo)
                        .build();
    
    return folderMapper.insertFolder(folder);
  }
  
  @Override
  public void loadUploadList(Model model) {
    Map<String, Object> modelMap = model.asMap();
    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
    
    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
    int display = Integer.parseInt(optDisplay.orElse("20"));
    
    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(optPage.orElse("1"));
    
    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
    String sort = optSort.orElse("DESC");
    
    Optional<String> optParentFolderNo = Optional.ofNullable(request.getParameter("parentFolderNo"));
    int parentFolderNo = Integer.parseInt(optParentFolderNo.orElse("1"));
    
    int total = folderMapper.getDriveListCount(parentFolderNo);
    
    myPageUtils.setPaging(total, display, page);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd()
                                   , "sort", sort
                                   , "parentFolderNo", parentFolderNo);
    
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("driveList", folderMapper.getDriveList(map));
    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/drive/main.do", sort, display));
    model.addAttribute("display", display);
    model.addAttribute("sort", sort);
    model.addAttribute("page", page);
    model.addAttribute("parentFolderNo", parentFolderNo);
  }
  
  @Override
  public ResponseEntity<Resource> download(HttpServletRequest request) {
    
    String[] fileNoStrings = request.getParameterValues("fileNo");
    if (fileNoStrings == null || fileNoStrings.length == 0) {
      return new ResponseEntity<Resource>(HttpStatus.BAD_REQUEST);
    }
    List<Integer> fileNos = Arrays.stream(fileNoStrings).map(Integer::parseInt).collect(Collectors.toList());
    
    List<FileDto> fileList = new ArrayList<>();
    for (Integer fileNo : fileNos) {
      fileList.addAll(folderMapper.getfileList(fileNo));
    }
    
    // 첨부 파일이 없으면 종료
    if(fileList.isEmpty()) {
      return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
    }
    
    // 임시 zip 파일 저장할 경로
    File tempDir = new File(myFileUtils.getTempPath());
    if(!tempDir.exists()) {
      tempDir.mkdirs();
    }
    
    // 임시 zip 파일 이름
    String tempFilename = myFileUtils.getTempFilename() + ".zip";
    
    // 임시 zip 파일 File 객체
    File tempFile = new File(tempDir, tempFilename);
    
    // 첨부 파일들을 하나씩 zip 파일로 모으기
    try {
      
      // ZipOutputStream 객체 생성
      ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(tempFile));
      
      for (FileDto file : fileList) {
        
        // zip 파일에 포함할 ZipEntry 객체 생성
        ZipEntry zipEntry = new ZipEntry(file.getOriginalFilename());
    
        // zip 파일에 ZipEntry 객체 명단 추가 (파일의 이름만 등록한 상황)
        zout.putNextEntry(zipEntry);
        
        // 실제 첨부 파일을 zip 파일에 등록 (첨부 파일을 읽어서 zip 파일로 보냄)
        BufferedInputStream in = new BufferedInputStream(new FileInputStream(new File(file.getFileUploadPath(), file.getFilesystemName())));
        zout.write(in.readAllBytes());
        
        // 사용한 자원 정리
        in.close();
        zout.closeEntry();
      }  // for
      
      // zout 자원 반납
      zout.close();
      
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    // 다운로드 할 zip File 객체 -> Resource 객체
    Resource resource = new FileSystemResource(tempFile);
    
    // 다운로드용 응답 헤더 설정 (HTTP 참조)
    HttpHeaders responseHeader = new HttpHeaders();
    responseHeader.add("Content-Disposition", "attachment; filename=" + tempFilename);
    responseHeader.add("Content-Length", tempFile.length() + "");
    
    // 다운로드 진행
    return new ResponseEntity<Resource>(resource, responseHeader, HttpStatus.OK);
  }
  
  @Override
  public void removeTempFiles() {
    File tempDir = new File(myFileUtils.getTempPath());
    File[] tempFiles = tempDir.listFiles();
    if(tempFiles != null) {
      for(File tempFile : tempFiles) {
        tempFile.delete();
      }
    }
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> removeFile(Map<String, List<Integer>> params) {
    List<Integer> fileNos = params.get("fileNos");
    
    int totalDeleteCount = 0;
    
    for (int fileNo : fileNos) {
      List<FileDto> fileDtos = folderMapper.getfileList(fileNo);
      
      for (FileDto fileDto : fileDtos) {
        if (fileDto != null) {
          File file = new File(fileDto.getFileUploadPath(), fileDto.getFilesystemName());
          if(file.exists()) {
            file.delete();
          }
        }
      }
      int deleteCount = folderMapper.deleteFile(fileNo);
      totalDeleteCount += deleteCount;
    }
    
    return ResponseEntity.ok(Map.of("deleteCount", totalDeleteCount));
  }
  
  
}
