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
  int updateHit(int blogNo);
  BlogDto getBlogByNo(int blogNo);
  int updateBlog(BlogDto blog);
  List<BlogImageDto> getBlogImageList(int blogNo);
  int deleteBlogImage(String filesystemName);
  int deleteBlogImageList(int blogNo);
  int deleteBlog(int blogNo);
  List<BlogImageDto> getBlogImageInYesterday();
  
  int insertComment(CommentDto comment);
  int getCommentCount(int blogNo);
  List<CommentDto> getCommentList(Map<String, Object> map);
  int insertReply(CommentDto comment);
  int deleteComment(int commentNo);
}
