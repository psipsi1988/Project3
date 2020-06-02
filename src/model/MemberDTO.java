package model;

import java.sql.Date;
/*
DTO객체(Data Transfer Object)
	: 데이터를 저장하기 위한 객체로 멤버변수, 생성자, getter/setter
	메소드를 가지고 있는 클래스로 일반적인 자바빈(Bean)규약을 따른다. 
 */

public class MemberDTO {
	
	//멤버변수 : 정보은닉을 위해 private으로 선언함.
	private String id; //아이디
	private String pass; //비밀번호
	private String name; //이름
	private String phone; //핸드폰 번호
	private String email; //이메일
	private String open_email; //이메일 동의 여부
	private String address; // 주소
	private java.sql.Date regidate; //가입일
	private int grade; //회원 등급
	private String gender; //성별
	
	//기본생성자
	public MemberDTO() {}
	
	//인자생성자
	public MemberDTO(String id, String pass, String name, Date regidate) {
		super();
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.regidate = regidate;
	}


	//getter/setter

	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getOpen_email() {
		return open_email;
	}

	public void setOpen_email(String open_email) {
		this.open_email = open_email;
	}
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public java.sql.Date getRegidate() {
		return regidate;
	}

	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	
	/*
	Object클래스에서 제공하는 메소드로 객체를 문자열형태로 변형해서 
	반환해주는 역할을 한다. toString()메소드를 오버라이딩하면 
	객체 자체를 그대로 print()하는 것이 가능하다. 
	*/
	
	@Override
	public String toString() {
		return String.format("아이디:%s, 비밀번호:%s, 이름:%s", 
				id, pass, name);
	}

	
	
	
	
	
	
}
