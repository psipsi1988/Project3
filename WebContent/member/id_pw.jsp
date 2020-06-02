<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="../bootstrap4.4.1/jquery/jquery-3.5.1.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script>
	function id_pwFrm1Validate(fn){
		alert (open_email.value);
		if(!fn.name1.value){
			alert("이름을 입력하세요");
			fn.name1.focus();
			return false;
		}
		if(fn.email1.value==""){
			alert("이메일을 입력하세요");
			fn.email1.focus();
			return false;
	}

</script>
 <body>
	<div>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<form action="id_helpProcess.jsp" method="post" name="id_pwFrm1" onsubmit="return id_pwFrm1Validate(this);">
				<div class="idpw_box">
					<div class="id_box">
						<ul>
							<li><input type="text" id="name1" name="name1" value="박성일" class="login_input01" /></li>
							<li><input type="text" id="email1"  name="email1"value="psipsi1988@naver.com" class="login_input01" /></li>
							
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" class="id_btn"/>					
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
				
					</div>
					
					<div class="pw_box">
						<ul>
							<li><input type="text" id="id2"  name="id2" value="오른쪽 아이디" class="login_input01" /></li>
							<li><input type="text" id="name2"  name="name2" value="오른쪽 이름" class="login_input01" /></li>
							<li><input type="text" id="email2"  name="email2" value="오른쪽 이메일" class="login_input01" /></li>
						</ul>
						<a href=""><img src="../images/member/id_btn01.gif" class="pw_btn" /></a>
					</div>
					</form>
				</div>
			</div>
		</div>
		
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
