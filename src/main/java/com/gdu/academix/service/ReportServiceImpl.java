package com.gdu.academix.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gdu.academix.dto.ReportDto;
import com.gdu.academix.mapper.ReportMapper;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MyPageUtils;
import com.gdu.academix.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public class ReportServiceImpl implements ReportService {

  private final ReportMapper reportMapper;
  private final MyPageUtils myPageUtils;
  private final MyFileUtils myFileUtils;
  
  
  public ReportServiceImpl(ReportMapper reportMapper, MyPageUtils myPageUtils, MyFileUtils myFileUtils) {
	super();
	this.reportMapper = reportMapper;
	this.myPageUtils = myPageUtils;
	this.myFileUtils = myFileUtils;
  }

  @Transactional(readOnly=true)
  @Override
  public ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile) {
    
    // 이미지 저장할 경로 생성
    String uploadPath = myFileUtils.getBlogImageUploadPath();
    File dir = new File(uploadPath);
    if(!dir.exists()) {
      dir.mkdirs();
    }
    
    // 이미지 저장할 이름 생성
    String filesystemName = myFileUtils.getFilesystemName(multipartFile.getOriginalFilename());
    
    // 이미지 저장
    File file = new File(dir, filesystemName);
    try {
      multipartFile.transferTo(file);
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    // 이미지가 저장된 경로를 Map 으로 반환
    return new ResponseEntity<>(Map.of("src", uploadPath + "/" + filesystemName)
                              , HttpStatus.OK);
    
  }

  @Override
  public int registerReport(HttpServletRequest request) {
    
    // 요청 파라미터
    
    String description = request.getParameter("description");
    int authorNo = Integer.parseInt(request.getParameter("authorNo"));
    int reportCategory = Integer.parseInt(request.getParameter("reportCategory"));
    int postNo = Integer.parseInt(request.getParameter("postNo"));
    
    ReportDto report = ReportDto.builder()
                     .reportCategory(reportCategory)
                     .description(MySecurityUtils.getPreventXss(description))
                     .authorNo(authorNo)
                     .postNo(postNo)
                   .build();
    
    // DB에 blog 저장
    int insertCount = reportMapper.insertReport(report);
    
//    
    // DB에 blog 저장
    return insertCount;
    
  }

  @Transactional(readOnly=true)
  @Override
  public ResponseEntity<Map<String, Object>> getReportList(HttpServletRequest request) {
    
    // 전체 블로그 개수
    int total = reportMapper.getReportCount();
    
    // 스크롤 이벤트마다 가져갈 목록 개수
    int display = 10;
    
    // 현재 페이지 번호
    int page = Integer.parseInt(request.getParameter("page"));
    
    // 페이징 처리
    myPageUtils.setPaging(total, display, page);
    
    // 목록 가져올 때 전달할 Map 생성
    Map<String, Object> map = Map.of("begin" , myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    // 목록 화면으로 반환할 값 (목록 + 전체 페이지 수)
    return new ResponseEntity<>(Map .of("reportList", reportMapper.getReportList(map)
                                      , "totalPage", myPageUtils.getTotalPage())
                              , HttpStatus.OK);
    
  }

  @Transactional(readOnly=true)
  @Override
  public ReportDto getReportByNo(int reportNo) {
    return reportMapper.getReportByNo(reportNo);
  }
  
  @Transactional(readOnly=true)
  public List<String> getEditorImageList(String content) {
    
    // Summernote Editor에 추가한 이미지 목록 반환하기 (Jsoup 라이브러리 사용)
    
    List<String> editorImageList = new ArrayList<>();
    
    Document document = Jsoup.parse(content);
    Elements elements =  document.getElementsByTag("img");
    
    if(elements != null) {
      for(Element element : elements) {
        String src = element.attr("src");
        String filesystemName = src.substring(src.lastIndexOf("/") + 1);
        editorImageList.add(filesystemName);
      }
    }
    
    return editorImageList;
    
  }
  
//  @Override
//  public int modifyReport(HttpServletRequest request) {
//    
//    // 수정할 제목/내용/블로그번호
//    String description = request.getParameter("description");
//    int reportNo = Integer.parseInt(request.getParameter("reportNo"));
//    int reportCategory = Integer.parseInt(request.getParameter("reportCategory"));
//    
//    
//    // 수정할 제목/내용/블로그번호를 가진 BlogDto
//    ReportDto report = ReportDto.builder()
//    		 		.description(description)
//                    .reportCategory(reportCategory)
//                    .reportNo(reportNo)
//                    .build();
//    
//    // BLOG_T 수정
//    int modifyResult = reportMapper.updateReport(report);
//    
//    
//    return modifyResult;
//    
//    
//    
//  }

  @Override
  public int removeReport(int reportNo) {
    
    
    
    // BLOG_T 삭제
    return reportMapper.deleteReport(reportNo);
    
  }
}
  
