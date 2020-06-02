<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ include file="../include/global_head.jsp" %>
<%-- 파일명 : idCheckProc.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
    
<%


String id = request.getParameter("id");
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");


MemberDAO dao = new MemberDAO(drv, url);

String result = "";

	if(id!=null){
		if(dao.idCheck(id)==false){
			result="사용 가능한 아이디입니다.";
		}
		if(dao.idCheck(id)==true){
			result="중복된 아이디입니다.";
		}
	}
	else{
		result="아이디를 입력하세요";
	}


%>
<%=result  %>