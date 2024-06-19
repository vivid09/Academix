package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.AnonDto;
import com.gdu.academix.dto.BlogDto;
import com.gdu.academix.dto.CommentDto;
import com.gdu.academix.dto.BlogImageDto;

@Mapper
public interface AnonMapper {
  int insertAnon(AnonDto anon);
  int insertBlogImage(BlogImageDto blogImage);
  int getAnonCount();
  List<AnonDto> getAnonList(Map<String, Object> map);
  int updateHit(int postNo);
  AnonDto getAnonByNo(int postNo);
  int updateAnon(AnonDto anon);
  List<BlogImageDto> getBlogImageList(int postNo);
  int deleteBlogImage(String filesystemName);
  int deleteBlogImageList(int postNo);
  int deleteAnon(int postNo);
  int updatePostStatus(AnonDto anon);
  List<BlogImageDto> getBlogImageInYesterday();
  
  
  int insertAnonComment(CommentDto comment);
  int getCommentCount(int postNo);
  List<CommentDto> getCommentList(Map<String, Object> map);
  int insertReply(CommentDto comment);
  int deleteComment(int commentNo);
  int deleteCommentByAnonNo(int postNo);
  
  //게시물 상세- 조회수
  int getHitCountByPostNo(int postNo);
  
}
