package com.gdu.academix.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.service.AnonService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@RequestMapping("/anon")
@RequiredArgsConstructor
@Controller
public class AnonController {
  
  private final AnonService anonService;
  
  @GetMapping("/list.page")
  public String list() {
    return "anon/list";
  }
  
  @GetMapping("/write.page")
  public String writePage() {
    return "anon/write";
  }
  
  @PostMapping(value="/summernote/imageUpload.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> summernoteImageUpload(@RequestParam("image") MultipartFile multipartFile) {
    return anonService.summernoteImageUpload(multipartFile);
  }
  
  @PostMapping("/registerAnon.do")
  public String register(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int insertCount = anonService.registerAnon(request);
    redirectAttributes.addFlashAttribute("insertResult", insertCount == 1 ? "게시글이 등록되었습니다." : "게시글이 등록되지 않았습니다.");
    return "redirect:/anon/list.page";
  }
  
  @GetMapping(value="/getAnonList.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getAnonList(HttpServletRequest request) {
    return anonService.getAnonList(request);
  }
  
  @GetMapping("/updateHit.do")
  public String updateHit(@RequestParam int postNo, HttpServletRequest request,
          HttpServletResponse response) {
	  /* 조회수 로직 */
	  Cookie oldCookie = null;
      Cookie[] cookies = request.getCookies();

          for (Cookie cookie : cookies) {
              System.out.println("cookie.getName " + cookie.getName());
              System.out.println("cookie.getValue " + cookie.getValue());
              if(cookie.getName().equals("hitChk")) {
            	  oldCookie = cookie;
              }
          }
          if(oldCookie != null) {
        	  if (!oldCookie.getValue().contains(Integer.toString(postNo))) {
        		  anonService.updateHit(postNo);
        		  oldCookie.setValue(oldCookie.getValue() + "_" + Integer.toString(postNo));
        		  oldCookie.setMaxAge(30);  /* 쿠키 시간 */
        		  response.addCookie(oldCookie);
        	  }
          }else {
        	  Cookie newCookie = new Cookie("hitChk", Integer.toString(postNo));
        	  anonService.updateHit(postNo);
        	  newCookie.setMaxAge(30);
        	  response.addCookie(newCookie);
          }
	  return "redirect:/anon/detail.do?postNo=" + postNo;
  }
  
  @GetMapping("/detail.do")
  public String detail(@RequestParam int postNo, Model model) {
    model.addAttribute("anon", anonService.getAnonByNo(postNo));
    return "anon/detail";
  }
  
  @PostMapping("/editAnon.do")
  public String editAnon(@RequestParam int postNo, Model model) {
    model.addAttribute("anon", anonService.getAnonByNo(postNo));
    return "anon/edit";
  }
  
  @PostMapping("/modifyAnon.do")
  public String modifyAnon(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int modifyCount = anonService.modifyAnon(request);
    redirectAttributes
      .addAttribute("postNo", request.getParameter("postNo"))
      .addFlashAttribute("modifyResult", modifyCount == 1 ? "수정되었습니다.": "수정되지 않았습니다.");
    return "redirect:/anon/detail.do?postNo={postNo}";
  }
  
  @PostMapping("/removeAnon.do")
  public String removeAnon(@RequestParam(value="postNo", required=false, defaultValue="0") int postNo
                         , RedirectAttributes redirectAttributes) {
    int removeCount = anonService.removeAnon(postNo);
    redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "블로그가 삭제되었습니다." : "블로그가 삭제되지 않았습니다.");
    return "redirect:/anon/list.page";
  }
  
  @PostMapping(value="/updatePostStatus.do", produces="application/json")
  public String updatePostStatus(HttpServletRequest request) {
	  ResponseEntity.ok(Map.of("removePost", anonService.updatePostStatus(request)));
    return "redirect:/anon/list.page";
  }
  
  @PostMapping(value="/registerComment.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> registerComment(HttpServletRequest request) {
    return ResponseEntity.ok(Map.of("insertCount", anonService.registerComment(request)));
  }
  
  @GetMapping(value="/comment/list.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> commentList(HttpServletRequest request) {
    return ResponseEntity.ok(anonService.getCommentList(request));
  }
  
  @PostMapping(value="/comment/registerReply.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> registerReply(HttpServletRequest request) {
    return ResponseEntity.ok(Map.of("insertReplyCount", anonService.registerReply(request)));
  }
  
  @PostMapping(value="/removeComment.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> removeComment(@RequestParam(value="commentNo", required=false, defaultValue="0") int commentNo) {
    return ResponseEntity.ok(Map.of("removeResult", anonService.removeComment(commentNo) == 1 ? "댓글이 삭제되었습니다." : "댓글이 삭제되지 않았습니다."));
  }
  
	//조회 수
	@GetMapping(value="/get-hit-count-by-postno", produces="application/json")
	public ResponseEntity<Map<String, Object>> getHitCount(@RequestParam("postNo") int postNo) {
		System.out.println(anonService.getHitCountByPostNo(postNo));
	  return ResponseEntity.ok(Map.of("hitCount", anonService.getHitCountByPostNo(postNo)));
	}
  
}