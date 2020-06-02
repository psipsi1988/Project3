<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%
request.setCharacterEncoding("UTF-8");


//멀티게시판 구현을 위한 파라미터 처리
String bname = request.getParameter("bname");
  if(bname==null || bname.equals("")){
	//만약 bname의 값이 없다면 로그인 화면으로 강제이동시킨다. 
	JavascriptUtil.jsAlertLocation("필수 파라미터 누락됨", "../member/login.jsp", out);
	return;
}

String boardTitle = "";
switch(bname){
case "notice" : 
	boardTitle = "공지사항";
	break;
case "calendar" : 
	boardTitle = "프로그램일정";	
case "free" : 
	boardTitle = "자유게시판";
	break;
case "photo" : 
	boardTitle = "사진게시판";
	break;
case "info" : 
	boardTitle = "정보자료실";
	break;
}
%>