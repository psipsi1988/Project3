<%@page import="java.util.Map"%>
<%@page import="model.MemberDTO"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- LoginProcess.jsp --%>

<%
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");

String id_save = request.getParameter("id_save");

//MariaDB정보로 변경되므로 초기화 파라미터를 수정한다. 
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");




MemberDAO dao = new MemberDAO(drv, url);


String result = "";
//방법3 : Map 컬렉션에 회원정보 저장 후 반환받기
Map<String, String> memberInfo  = dao.getMemberMap(id, pw);

//Map의 id키값에 저장된 값이 있는지 확인
if(memberInfo.get("id")!=null){
	//저장된 값이 있다면 세션영역에 아이디, 패스워드, 이름을 속성으로 저장한다. 
	session.setAttribute("USER_ID", memberInfo.get("id"));
	session.setAttribute("USER_PW", memberInfo.get("pass"));
	session.setAttribute("USER_NAME", memberInfo.get("name"));
	
	

	//로그인과 쿠키 생성이 완료되면  기존 로그인 페이지로 이동한다. 
	
	
	response.sendRedirect("../main/main.jsp");
}
else{
	//result="아이디와 비밀번호가 틀렸습니다";
	out.println("<script>alert('아이디/비밀번호가 틀렸습니다.');  history.go(-1);</script>");
	
}




%>