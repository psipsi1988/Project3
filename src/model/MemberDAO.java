package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

public class MemberDAO {

	//멤버변수(클래스 전체 멤버메소드에서 접근 가능)
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//기본 생성자
	public MemberDAO() {
		System.out.println("MemberDAO생성자 호출");
	}
	
	public MemberDAO(String driver, String url) {
		try {
			Class.forName(driver);
			String id= "suamil_user";
			String pw = "1234";
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB 연결 성공");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//인자생성자2
		/*
		JSP에서는 application내장객체를 파라미터로 전달하고 
		생성자에서 web.xml에 직접 접근한다. application내장객체는 
		javax.servlet.ServletContext타입으로 정의되었으므로 메소드에서 
		사용시에는 해당 타입으로 받아야 한다. 
		※각 내장객체의 타입은 JSP교안 "내장객체" 참조할 것. 
		 */
		public MemberDAO(ServletContext ctx) {
			try {
				Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
				String id= "suamil_user";
				String pw = "1234";
				con = DriverManager.getConnection(
						ctx.getInitParameter("MariaConnectURL"), id, pw);
				System.out.println("DB 연결 성공");
			}
			catch (Exception e) {
				System.out.println("DB 연결 실패");
				e.printStackTrace();
			}
		}
	
	
	
	//방법1 : 회원의 존재 유무만 판단한다. 
	public boolean isMember(String id, String pass) {
		
		String sql = "select COUNT(*) FROM membership "
				+ " WHERE id=? AND pass=?";
		int isMember = 0;
		boolean isFlag = false;
		
		try {
			//prepare를 객체로 쿼리문 전송
			psmt = con.prepareStatement(sql);
			//인파라미터 설정
			psmt.setString(1, id);
			psmt.setString(2, pass);
			//쿼리실행
			rs = psmt.executeQuery();
			//실행결과를 가져오기 위해 next() 호출
			rs.next();
			
			isMember = rs.getInt(1);
			System.out.println("affected:"+isMember);
			if(isMember==0)
				isFlag = false;
			else
				isFlag = true;
			
		}
		catch(Exception e) {
			isFlag=false;
			e.printStackTrace();
		}
		return isFlag;
		
	}
	
	
		//방법2 : 회원 인증 후 MemberDTO객체로 회원정보를 반환한다. 
		public MemberDTO getMemberDTO(String uid, String upass) {
			//DTO객체를 생성한다. 
			MemberDTO dto = new MemberDTO();
			//쿼리문을 작성
			String query = "SELECT id, pass, name FROM "
					+ " membership WHERE id=? AND pass=?";
			
			try {
				//prepared 객체 생성
				psmt = con.prepareStatement(query);
				//쿼리문의 인파라미터설정
				psmt.setString(1, uid);
				psmt.setString(2, upass);
				//오라클로 쿼리문 전송 및 결과셋(ResultSet) 반환받음
				rs = psmt.executeQuery();
				//오라클이 반환해준 ResultSet이 있는지 확인
				if(rs.next()) {
					//true를 반환했다면 결과셋 있음
					//DTO객체에 회원 레코드의 값을 저장한다. 
					dto.setId(rs.getString("id"));
					dto.setPass(rs.getString("pass"));
					dto.setName(rs.getString(3));
				}
				else {
					//false를 반환했다면 결과셋 없음
					System.out.println("결과셋이 없습니다. ");
				}
				
			}
			catch (Exception e) {
				System.out.println("getMemberDTO 오류");
			}
			
			//DTO객체를 반환한다. 
			return dto;
		}
		
		
		public Map<String, String> getMemberMap(String id, String pwd){
			Map<String, String> maps = new HashMap<String, String>();
			
			String query =  "SELECT id, pass, name FROM "
					+ " membership WHERE id=? AND pass=?";
			
			
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, id);
				psmt.setString(2, pwd);
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					maps.put("id", rs.getString(1));
					maps.put("pass", rs.getString("pass"));
					maps.put("name", rs.getString("name"));
				}
				else {
					System.out.println("결과셋이 없습니다. ");
				}
			}
			catch (Exception e) {
				System.out.println("getMemberDTO 오류");
			}
			return maps;
			
		}
		
		
		public Map<String, String> getIdMap(String name, String email){
			Map<String, String> maps = new HashMap<String, String>();
			
			String query =  "SELECT id FROM membership WHERE name=? AND EMAIL=? ";
			
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, name);
				psmt.setString(2, email);
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					maps.put("id", rs.getString(1));
					System.out.println();
				}
				else {
					System.out.println("결과셋이 없습니다. ");
				}
			}
			catch (Exception e) {
				System.out.println("getMemberDTO 오류");
			}
			return maps;
			
		}
		
		
		
		
		
		
		
		//아이디 중복체크
		public boolean idCheck(String id) {
			
			
			String sql = " select COUNT(*) FROM membership WHERE id=? ";
				int idCheck = 0;
				boolean isFlag = false;
			
			try {
				
				psmt = con.prepareStatement(sql);//prepare를 객체로 쿼리문 전송
				psmt.setString(1, id); //인파라미터 설정
				rs = psmt.executeQuery();	//쿼리실행
				rs.next();//실행결과를 가져오기 위해 next() 호출
				
				idCheck = rs.getInt(1);
				System.out.println("affected:"+idCheck);
				if(idCheck==0) {
					isFlag = false;
					//System.out.println("중복된 아이디입니다.");
				}
				else {
					isFlag = true;
					//System.out.println("사용 가능한 아이디입니다.");
				}
			}
			catch(Exception e) {
				isFlag=false;
				e.printStackTrace();
			}
			return isFlag;
		}
		
		
		//이름, 이메일로 아이디 찾기
		public boolean id_help(String name, String email) {
			
			
			String sql = " SELECT id FROM membership WHERE name=? AND EMAIL=? ";
				String id_help = "";
				boolean isFlag = false;
				
			try {
				
				psmt = con.prepareStatement(sql);//prepare를 객체로 쿼리문 전송
				psmt.setString(1, name); //인파라미터 설정
				psmt.setString(2, email); //인파라미터 설정
				rs = psmt.executeQuery();	//쿼리실행
				rs.next();//실행결과를 가져오기 위해 next() 호출
				id_help = rs.getString(1);
				System.out.println("affected:"+id_help);
				if(id_help==null) {
					isFlag = false;
					//System.out.println("중복된 아이디입니다.");
				}
				else {
					isFlag = true;
					System.out.println("아이디는 "+id_help+"입니다.");
					//System.out.println("사용 가능한 아이디입니다.");
				}
			}
			catch(Exception e) {
				isFlag=false;
				e.printStackTrace();
			}
			return isFlag;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//회원가입
			public int insertJoin(MemberDTO dto) {
				//실제 입력된 행의 개수를 저장하기 위한 변수 
				int affected = 0;
				try {

					String query = "INSERT INTO membership "
							+ " (NAME, id, pass, phone, email, open_email, address, regidate) "
							+ " VALUES(?, ?, ?, ?, ?, ?, ?, now())";
					
					psmt = con.prepareStatement(query);
					psmt.setString(1, dto.getName());
					psmt.setString(2, dto.getId());
					psmt.setString(3, dto.getPass());
					psmt.setString(4, dto.getPhone());
					psmt.setString(5, dto.getEmail());
					psmt.setString(6, dto.getOpen_email());					
					psmt.setString(7, dto.getAddress());
					

					
					affected = psmt.executeUpdate();
				}
				catch (Exception e) {
					System.out.println("insert 중 예외 발생");
					e.printStackTrace();
				}
				
				return affected;
			}
				
}











