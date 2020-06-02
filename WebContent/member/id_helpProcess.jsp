<%@page import="java.util.Map"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ include file="../include/global_head.jsp" %>
<%-- 파일명 : id_helpProcess.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name1"); //이름
String email = request.getParameter("email1"); //이메일

String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");


MemberDAO dao = new MemberDAO(drv, url);


String result = "";
String id_result1 = "";
String id_result2 = "";
String id_result3 = "";

	if(dao.id_help(name, email)==true){
		
		MemberDAO dao2 = new MemberDAO(application);
		
		Map<String, String> memberInfo  = dao2.getIdMap(name, email);
		session.setAttribute("id_result3", memberInfo.get("id"));
		id_result1 = memberInfo.get("id");
		//session.setAttribute("USER_ID", memberInfo.get("id"));
		response.setContentType("text/html; charset=UTF-8");
		//out.println("<script>alert('아이디가 검색되었습니다');  location.href='./login.jsp';</script>");

		out.println("<script>alert('아이디가 검색되었습니다'); </script>");

		out.flush();
		
		result="아이디 검색됨";
		
	}
	else{
		result="이름, 이메일과 일치하는 아이디가 없습니다.";
		out.println("<script>alert('이름, 이메일과 일치하는 아이디가 없습니다.');  history.go(-1);</script>");
	}


%>


	<script>
	function loginValidate(fn){
		if(!fn.user_id.value){
			alert("아이디를 입력하세요");
			fn.user_id.focus();
			return false;
		}
		if(fn.user_pw.value==""){
			alert("패스워드를 입력하세요");
			fn.user_pw.focus();
			return false;
		}
	}
	</script>
	<style>
	.login_btn01{
	 background-image: url('../images/login_btn.gif');
	    background-position:  0px 0px;
	    background-repeat: no-repeat;
	    width: 91x;
	    height: 21x;
	    border: 0px;
	 cursor:pointer;
	 outline: 0;
	}
	</style>

 <body>
	<center>
	
	
	
	
	
	
	
	
	
	
	<form action="LoginProcess.jsp" method="post" name="loginFrm" onsubmit="return loginValidate(this);">
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
				<div class="login_box01">
					<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
					<ul>
						<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" />
						<input type="text" id="user_id" name="user_id" value="<%=id_result1  %>" class="login_input01" /></li>
						
						<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" />
						<input type="password" id="user_pw" name="user_pw" value="" class="login_input01" /></li>
					</ul>
					
					<input type="submit" value="" tabindex="3" class="login_btn01" />
					<a href=""><input type="image" src="../images/login_btn.gif" class="login_btn01" /></a>
					
					
					
				</div>
				<p style="text-align:center; margin-bottom:50px;"><a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기"  /></a>&nbsp;<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	</form>














	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>


