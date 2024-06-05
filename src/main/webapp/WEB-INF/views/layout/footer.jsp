<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
  <footer class="main-footer">
    
  </footer>

<script src="${contextPath}/js/checkDrive.js?dt=${dt}"></script>

</body>
</html>


