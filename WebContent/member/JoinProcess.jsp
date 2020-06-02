<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Map"%>
<%@page import="model.MemberDTO"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- JoinProcess.jsp --%>

<%
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name"); //이름
String id = request.getParameter("id"); //아이디
String pass2 = request.getParameter("pass2"); //패스워드
String mobile1 = request.getParameter("mobile1"); //전화번호 앞
String mobile2 = request.getParameter("mobile2"); //전화번호 중간
String mobile3 = request.getParameter("mobile3"); //전화번호 뒤
String email_1 = request.getParameter("email_1"); //이메일 앞
String email_2 = request.getParameter("email_2"); //이메일 뒤
String open_email = request.getParameter("open_email"); //이메일 수신 동의여부
String sample4_postcode = request.getParameter("sample4_postcode"); //우변번호
String sample4_roadAddress = request.getParameter("sample4_roadAddress"); //도로명 주소
String sample4_detailAddress = request.getParameter("sample4_detailAddress"); //상세주소
String sample4_jibunAddress = request.getParameter("sample4_jibunAddress"); //지번주소
String sample4_extraAddress = request.getParameter("sample4_extraAddress"); //주소 참고 사항

MemberDTO dto = new MemberDTO();
dto.setName(name);
dto.setId(id);
dto.setPass(pass2);
dto.setPhone(mobile1+"-"+mobile2+"-"+mobile3);
dto.setEmail(email_1+"@"+email_2);
dto.setOpen_email(open_email);




dto.setAddress(sample4_postcode+"|"+sample4_roadAddress+"|"+sample4_detailAddress+"|"+sample4_jibunAddress+"|"+sample4_extraAddress);



//DAO객체 생성시 application내장객체를 인자로 전달
MemberDAO dao = new MemberDAO(application);

int affected = dao.insertJoin(dto);
if(affected==1){
	//회원가입 성공했을 때  
	String drv = application.getInitParameter("MariaJDBCDriver");
	String url = application.getInitParameter("MariaConnectURL");
	
	MemberDAO dao2 = new MemberDAO(application);
	
	
	Map<String, String> memberInfo  = dao2.getMemberMap(id, pass2);
	session.setAttribute("USER_ID", memberInfo.get("id"));
	session.setAttribute("USER_PW", memberInfo.get("pass2"));
	session.setAttribute("USER_NAME", memberInfo.get("name"));
	
	
	response.setContentType("text/html; charset=UTF-8");
	out.println("<script>alert('계정이 등록되었습니다'); location.href='../main/main.jsp';</script>");
	out.flush();


}
else{
	%><script>
	alert("실패");
	</script><%
	response.setContentType("text/html; charset=UTF-8");

	 
	out.println("<script>alert('계정 등록에 실패하였습니다.'); location.href='./join02.jsp';</script>");
	 
	out.flush();
}


%>