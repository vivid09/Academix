package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.BlogDto;
import com.gdu.academix.dto.CommentDto;
import com.gdu.academix.dto.BlogImageDto;

@Mapper
public interface BlogMapper {
  int insertBlog(BlogDto blog);
  int insertBlogImage(BlogImageDto blogImage);
  int getBlogCount();
  List<BlogDto> getBlogList(Map<String, Object> map);
  int updateHit(int notiPostNo);
  BlogDto getBlogByNo(int notiPostNo);
  int updateBlog(BlogDto blog);
  List<BlogImageDto> getBlogImageList(int notiPostNo);
  int deleteBlogImage(String filesystemName);
  int deleteBlogImageList(int notiPostNo);
  int deleteBlog(int notiPostNo);
  List<BlogImageDto> getBlogImageInYesterday();
  
  
  int insertNotiComment(CommentDto comment);
  int getCommentCount(int notiPostNo);
  List<CommentDto> getCommentList(Map<String, Object> map);
  int insertReply(CommentDto comment);
  int deleteComment(int commentNo);
  int deleteCommentByNotiPostNo(int notiPostNo);
}
