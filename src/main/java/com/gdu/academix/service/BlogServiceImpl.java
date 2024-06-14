package com.gdu.academix.service;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gdu.academix.dto.BlogDto;
import com.gdu.academix.dto.BlogImageDto;
import com.gdu.academix.dto.CommentDto;
import com.gdu.academix.dto.UserDto;
import com.gdu.academix.mapper.BlogMapper;
import com.gdu.academix.utils.MyFileUtils;
import com.gdu.academix.utils.MyPageUtils;
import com.gdu.academix.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public class BlogServiceImpl implements BlogService {

  private final BlogMapper blogMapper;
  private final MyPageUtils myPageUtils;
  private final MyFileUtils myFileUtils;
  
  public BlogServiceImpl(BlogMapper blogMapper, MyPageUtils myPageUtils, MyFileUtils myFileUtils) {
	super();
	this.blogMapper = blogMapper;
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
  public int registerBlog(HttpServletRequest request) {
    
    // 요청 파라미터
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    // UserDto + BlogDto 객체 생성
    UserDto user = new UserDto();
    user.setUserNo(userNo);
    BlogDto blog = BlogDto.builder()
                     .title(MySecurityUtils.getPreventXss(title))
                     .contents(MySecurityUtils.getPreventXss(contents))
                     .user(user)
                   .build();
    
    // DB에 blog 저장
    int insertCount = blogMapper.insertBlog(blog);
    
    // Summernote Editor에 추가한 이미지들을 BLOG_IMAGE_T에 저장하기
    for(String editorImage : getEditorImageList(contents)) {
      BlogImageDto blogImage = BlogImageDto.builder()
          .blogNo(blog.getBlogNo())
          .uploadPath(myFileUtils.getBlogImageUploadPath())
          .filesystemName(editorImage)
          .build();
      blogMapper.insertBlogImage(blogImage);
    }
    
    // DB에 blog 저장
    return insertCount;
    
  }

  @Transactional(readOnly=true)
  @Override
  public ResponseEntity<Map<String, Object>> getBlogList(HttpServletRequest request) {
    
    // 전체 블로그 개수
    int total = blogMapper.getBlogCount();
    
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
    return new ResponseEntity<>(Map.of("blogList", blogMapper.getBlogList(map)
                                      , "totalPage", myPageUtils.getTotalPage())
                              , HttpStatus.OK);
    
  }
  
  @Override
  public int updateHit(int blogNo) {
    return blogMapper.updateHit(blogNo);
  }
  
  @Transactional(readOnly=true)
  @Override
  public BlogDto getBlogByNo(int blogNo) {
    return blogMapper.getBlogByNo(blogNo);
  }
  
  @Transactional(readOnly=true)
  public List<String> getEditorImageList(String contents) {
    
    // Summernote Editor에 추가한 이미지 목록 반환하기 (Jsoup 라이브러리 사용)
    
    List<String> editorImageList = new ArrayList<>();
    
    Document document = Jsoup.parse(contents);
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
  
  @Override
  public int modifyBlog(HttpServletRequest request) {
    
    // 수정할 제목/내용/블로그번호
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    int blogNo = Integer.parseInt(request.getParameter("blogNo"));
    
    // DB에 저장된 기존 이미지 가져오기
    // 1. blogImageDtoList : BlogImageDto를 요소로 가지고 있음
    // 2. blogImageList    : 이미지 이름(filesystemName)을 요소로 가지고 있음
    List<BlogImageDto> blogImageDtoList = blogMapper.getBlogImageList(blogNo);
    List<String> blogImageList = blogImageDtoList.stream()
                                  .map(blogImageDto -> blogImageDto.getFilesystemName())
                                  .collect(Collectors.toList());
        
    // Editor에 포함된 이미지 이름(filesystemName)
    List<String> editorImageList = getEditorImageList(contents);

    // Editor에 포함되어 있으나 DB에 없는 이미지는 BLOG_IMAGE_T에 추가해야 함
    editorImageList.stream()
      .filter(editorImage -> !blogImageList.contains(editorImage))         // 조건 : Editor에 포함되어 있으나 기존 이미지에 포함되어 있지 않다.
      .map(editorImage -> BlogImageDto.builder()                           // 변환 : Editor에 포함된 이미지 이름을 BlogImageDto로 변환한다.
                            .blogNo(blogNo)
                            .uploadPath(myFileUtils.getBlogImageUploadPath())
                            .filesystemName(editorImage)
                            .build())
      .forEach(blogImageDto -> blogMapper.insertBlogImage(blogImageDto));  // 순회 : 변환된 BlogImageDto를 BLOG_IMAGE_T에 추가한다.
    
    // 블로그를 만들 때는 있었는데 수정할 때는 없는 이미지들 삭제 (수정하면서 지운 이미지들)
    List<BlogImageDto> removeList = blogImageDtoList.stream()
                                      .filter(blogImageDto -> !editorImageList.contains(blogImageDto.getFilesystemName()))  // 조건 : 기존 이미지 중에서 Editor에 포함되어 있지 않다.
                                      .collect(Collectors.toList());                                                        // 조건을 만족하는 blogImageDto를 리스트로 반환한다.

    for(BlogImageDto blogImageDto : removeList) {
      // BLOG_IMAGE_T 테이블에서 삭제
      blogMapper.deleteBlogImage(blogImageDto.getFilesystemName());  // 파일명이 일치하면 삭제(파일명은 UUID로 만들어졌으므로 파일명의 중복은 없다고 생각하면 된다.)
      // 이미지 파일 삭제
      File file = new File(blogImageDto.getUploadPath(), blogImageDto.getFilesystemName());
      if(file.exists()) {
        file.delete();
      }
    }
    
    // 수정할 제목/내용/블로그번호를 가진 BlogDto
    BlogDto blog = BlogDto.builder()
                    .title(title)
                    .contents(contents)
                    .blogNo(blogNo)
                    .build();
    
    // BLOG_T 수정
    int modifyResult = blogMapper.updateBlog(blog);
    
    return modifyResult;
    
  }

  @Override
  public int removeBlog(int blogNo) {
    
    // BLOG_IMAGE_T 테이블에서 블로그 만들 때 사용한 이미지 파일 삭제
    List<BlogImageDto> blogImageDtoList = blogMapper.getBlogImageList(blogNo);
    for(BlogImageDto blogImage : blogImageDtoList) {
      File file = new File(blogImage.getUploadPath(), blogImage.getFilesystemName());
      if(file.exists()) {
        file.delete();
      }
    }
    
    // BLOG_IMAGE_T 삭제
    blogMapper.deleteBlogImageList(blogNo);
    
    // BLOG_T 삭제
    return blogMapper.deleteBlog(blogNo);
    
  }
  
  @Override
  public int registerComment(HttpServletRequest request) {
    
    // 요청 파라미터
    String contents = MySecurityUtils.getPreventXss(request.getParameter("contents"));
    int blogNo = Integer.parseInt(request.getParameter("blogNo"));
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    // UserDto 객체 생성
    UserDto user = new UserDto();
    user.setUserNo(userNo);
    
    // CommentDto 객체 생성
    CommentDto comment = CommentDto.builder()
                            .contents(contents)
                            .user(user)
                            .blogNo(blogNo)
                          .build();
    
    // DB 에 저장 & 결과 반환
    return blogMapper.insertComment(comment);
    
  }
  
  @Transactional(readOnly=true)
  @Override
  public Map<String, Object> getCommentList(HttpServletRequest request) {
    
    // 요청 파라미터
    int blogNo = Integer.parseInt(request.getParameter("blogNo"));
    int page = Integer.parseInt(request.getParameter("page"));
    
    // 전체 댓글 개수
    int total = blogMapper.getCommentCount(blogNo);
    
    // 한 페이지에 표시할 댓글 개수
    int display = 10;
    
    // 페이징 처리
    myPageUtils.setPaging(total, display, page);
    
    // 목록을 가져올 때 사용할 Map 생성
    Map<String, Object> map = Map.of("blogNo", blogNo
                                   , "begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    // 결과 (목록, 페이징) 반환
    return Map.of("commentList", blogMapper.getCommentList(map)
                , "paging", myPageUtils.getAsyncPaging());
    
  }
  
  @Override
  public int registerReply(HttpServletRequest request) {
    
    // 요청 파라미터
    String contents = request.getParameter("contents");
    int groupNo = Integer.parseInt(request.getParameter("groupNo"));
    int blogNo = Integer.parseInt(request.getParameter("blogNo"));
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    // UserDto 객체 생성
    UserDto user = new UserDto();
    user.setUserNo(userNo);
    
    // CommentDto 객체 생성
    CommentDto reply = CommentDto.builder()
                          .contents(contents)
                          .groupNo(groupNo)
                          .blogNo(blogNo)
                          .user(user)
                        .build();
    
    // DB 에 저장하고 결과 반환
    return blogMapper.insertReply(reply);
    
  }
  
  @Override
  public int removeComment(int commentNo) {
    return blogMapper.deleteComment(commentNo);
  }
  
  @Override
  public void removeBlogImageNotOnTheTable() {
    
    // 1. 어제 작성된 블로그의 이미지 목록 (DB)
    List<BlogImageDto> blogImageList = blogMapper.getBlogImageInYesterday();
    
    // 2. List<BlogImageDto> -> List<Path> (Path는 경로+파일명으로 구성)
    List<Path> blogImagePathList = blogImageList.stream()
                                                .map(blogImageDto -> new File(blogImageDto.getUploadPath(), blogImageDto.getFilesystemName()).toPath())
                                                .collect(Collectors.toList());
    
    // 3. 어제 저장된 블로그 이미지 목록 (디렉토리)
    File dir = new File(myFileUtils.getBlogImageUploadPathInYesterday());
    
    // 4. 삭제할 File 객체들
    File[] targets = dir.listFiles(file -> !blogImagePathList.contains(file.toPath()));

    // 5. 삭제
    if(targets != null && targets.length != 0) {
      for(File target : targets) {
        target.delete();
      }
    }
    
  }
  
}
