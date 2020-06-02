<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@page import="model.MemberDAO"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="../bootstrap4.4.1/jquery/jquery-3.5.1.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>




function test(obj){
    var a = $('#id').val().replace(/ /gi, '');
    $('#id').val(a);
}

$(function(){
	
	
	$('#email_1').keyup(function(){
		//email_1.value = email_1.value.replace(/[^a-z|^0-9]/gi, '');//영문 숫자만 입력
		email_1.value = email_1.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');//한글입력 막기
	});
	
	
	
	//ID 중복 체크
    $('#id').keyup(function(){
			
    	
    	//id.value = id.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');//한글입력 막기
    	//var a = $('#id').val().replace(/ /gi, ''); $('#id').val(a);//공백 입력 막기
    	
    	
    	id.value = id.value.replace(/[^a-z|^0-9]/gi, '');//영문 숫자만 입력
    	
    		
       
        	
        var content = $(this).val();
    	if (content.length < 4){
    		//alert("4글자 이상입력");
    		$('#result').html('<b style="color:blue;">4자 이상 입력하세요</b>');
    	}
    	if (content.length == 0){
    		//alert("4글자 이상입력");
    		$('#result').html('<b>아이디를 입력하세요</b>');
    	}
    	
    	if (content.length > 3){
    		$.ajax({
				
				url : "./idCheckProc.jsp", 
				type : "post", 
				contentType : "application/x-www-form-urlencoded;charset:utf-8;", 
				data : {
					id : $("#id").val()
				}, 
				dataType : "html", 
				success : function(d){
					//alert("성공Callback:"+d);
					$('#result').html(d).css("fontSize", "1em").css("color", "blue");;
				}, 
				error : function(e){
					alert("실패Callback:" + e.status+":"+e.statusText);
				}
			});
    		
    	}
	    	
    	
    });


	
	
	//비밀번호 일치 확인
    $('#pwd1').keyup(function(){
        //input태그의 value속성을 빈값으로 만들어준다. 
        $('#pwd2').val("");
        //암호를 재입력시에는 msg부분의 텍스트도 지워준다. 
        $('#msg').text('');


    });

    $('#pwd2').keyup(function(){
        //패스워드 입력란에 입력된 내용을 가져온다. 
        var compareStr1 = $('#pwd1').val();
        var compareStr2 = $(this).val();
       
       if(compareStr1==compareStr2){
           //암호가 일치하면 붉은색 텍스트
            $('#msg').html('<b style="color:blue;">암호가 일치합니다.</b>');
       }
       else{
           //일치하지 않으면 검은색 텍스트
            $('#msg').html('<b>암호가 다릅니다.</b>').css('color', 'red');
       }
                
    });
	
    $('#open_email').change(function(){
    	if($("input:checkbox[name=open_email]").is(":checked") == true) {
    		open_email.value="Y";
    	}
    	else{
    		open_email.value="N";
    	}
    });
    
    
    
    
    
	$('#last_email_check2').change(function(){
           //alert("이메일 선택됨");
           //option태그 사이의 텍스트를 읽어온다. 
           var text = $('#last_email_check2 option:selected').text();

           //value속성에 지정된 값을 읽어온다. 
           var value = $('#last_email_check2 option:selected').val();
           //alert("선택한 항목의 text:"+text+", value:"+value);

           if(value==''){//선택하세요를 선택
               $('#email_2').attr('readonly', true);//readonly 활성화
               $('#email_2').val('');
           }
           else if(value=='direct'){//직접 입력을 선택
               $('#email_2').attr('readonly', false); //readonly 비활성화
               $('#email_2').val('');
           }
           else{//그외 포털 도메인 선택
               $('#email_2').attr('readonly', true); //readonly 활성화
               //위에서 읽어온 값을 도메인 부분에 입력한다. 
               $('#email_2').val(value);
           }
	});
	
	
	
});//제이쿼리



	//숫자만 입력가능
	function NumObj(){
		if (event.keyCode >= 48 && event.keyCode <= 57) { 
		}
		else{
			event.returnValue = false;
		}
	}

	//한글만 입력 가능
	function hangul(){
	    if((event.keyCode < 12592) || (event.keyCode > 12687))
	    event.returnValue = false
	    
	}
	
	


    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
    
    function join2Validate(fn){
    	//alert (open_email.value);
		if(!fn.name.value){
			alert("이름을 입력하세요");
			fn.name.focus();
			return false;
		}
		if(fn.id.value==""){
			alert("아이디를 입력하세요");
			fn.id.focus();
			return false;
		}
		if(fn.pwd1.value==""){
			alert("패스워드를 입력하세요");
			fn.pwd1.focus();
			return false;
		}
		if(fn.pwd2.value==""){
			alert("패스워드를 입력하세요");
			fn.pwd2.focus();
			return false;
		}
		if(fn.mobile1.value==""){
			alert("휴대폰 번호를 입력하세요");
			fn.mobile1.focus();
			return false;
		}
		if(fn.mobile2.value==""){
			alert("휴대폰 번호를 입력하세요");
			fn.mobile2.focus();
			return false;
		}
		if(fn.mobile3.value==""){
			alert("휴대폰 번호를 입력하세요");
			fn.mobile3.focus();
			return false;
		}
		if(fn.email_1.value==""){
			alert("이메일을 입력하세요");
			fn.email_1.focus();
			return false;
		}
		if(fn.email_2.value==""){
			alert("이메일을 입력하세요");
			fn.email_2.focus();
			return false;
		}
		if(fn.open_email.value==""){
			alert("이메일 수신동의를 선택하세요");
			fn.open_email.focus();
			return false;
		}
		if(fn.sample4_postcode.value==""){
			alert("우편번호를 입력하세요");
			fn.sample4_postcode.focus();
			return false;
		}
		if(fn.sample4_roadAddress.value==""){
			alert("주소를 입력하세요");
			fn.sample4_roadAddress.focus();
			return false;
		}
		if(fn.sample4_detailAddress.value==""){
			alert("상세주소를 입력하세요");
			fn.sample4_detailAddress.focus();
			return false;
		}

	}
    
    
    
    
    
    
</script>

	<style>
	.login_btn01{
	 	background-image: url('../images/btn01.gif');
	    background-position:  0px 0px;
	    background-repeat: no-repeat;
	    width: 91px;
	    height: 21px;
	    border: 0px;
	 cursor:pointer;
	 outline: 0;
	}
	</style>

 <body>
	<center>
	<form action="JoinProcess.jsp" method="post" name="join2Frm" onsubmit="return join2Validate(this);">
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>





				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" onKeyPress="hangul();" placeholder="한글만 입력 가능" maxlength="6"/></td>
					</tr>
					
					
					
					
					
					
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td>
							<input type="text" id="id" name="id"  keyup = "idCheck()" value="" class="join_input" maxlength="12"/>&nbsp;
						
						
						<!-- 	<a onclick="idCheck();" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인" /></a> -->
							<span id="result">* 4자 이상 12자 이내의 영문/숫자 공백 없이 기입</span>
						</td>
					</tr>
					
					
					
					
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" id="pwd1" name="pass" value="" class="join_input" maxlength="12" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" id="pwd2" name="pass2" value="" class="join_input" maxlength="12" />&nbsp;&nbsp;<span id="msg"></span></td>
					</tr>
					

					<!-- <tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr> -->
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" onKeyPress="NumObj();"/>&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" onKeyPress="NumObj();"/>&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" onKeyPress="NumObj();"/></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
							<input type="text" id="email_1" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" />
							 @ 
							<input type="text" id="email_2" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
							<select id="last_email_check2">
								<option value="">선택해주세요</option>
								<option value="direct" >직접입력</option>
								<option value="hanmail.net" >hanmail.net</option>
								<option value="nate.com" >nate.com</option>
								<option value="naver.com" >naver.com</option>
								<option value="yahoo.com" >yahoo.com</option>
								<option value="google.com" >google.com</option>
							</select>
	 
						<input type="checkbox" id="open_email" name="open_email" value="N">
						<script>
							
						</script>
						
						<span>이메일 수신동의</span></td>
					</tr>
					
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" id="sample4_postcode" name="sample4_postcode" placeholder="우편번호" onclick="sample4_execDaumPostcode()" class="join_input" readonly="readonly" style="width:100px;">
						
						
						<input type="button" onclick="sample4_execDaumPostcode()" value="[우편번호 찾기]">
						<br>
						<input type="text" id="sample4_roadAddress" name="sample4_roadAddress" placeholder="도로명주소" onclick="sample4_execDaumPostcode()" class="join_input" readonly="readonly"  > 
						<input type="text" id="sample4_jibunAddress" name="sample4_jibunAddress" onclick="sample4_execDaumPostcode()" placeholder="지번주소" class="join_input" readonly="readonly" >
						<span id="guide" style="color:#999;display:none"></span>
						<br/>
						<input type="text" id="sample4_detailAddress" name="sample4_detailAddress" placeholder="상세주소" class="join_input">
						<input type="text" id="sample4_extraAddress" name="sample4_extraAddress" placeholder="참고항목" class="join_input">
						
						</td>
					</tr>
				</table>

				<p style="text-align:center; margin-bottom:20px">
				
				
				<!-- <a href=""><img src="../images/btn01.gif" /></a> -->
				<!-- <input type="submit" value="" class="login_btn01" /> -->
				
				
				<input type="image" src="../images/btn01.gif" />
				&nbsp;&nbsp;<a href="javascript:history.back();"><img src="../images/btn02.gif" /></a></p>
				
			</div>
		</div>
		
		<%@ include file="../include/quick.jsp" %>
	</div>
	</form>

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
