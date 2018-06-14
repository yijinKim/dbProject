<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ include file="top.jsp"%>
<link rel="stylesheet" type="text/css" href="style/table_style.css">
<%
	if (session_id == null)
		response.sendRedirect("login.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head></head>
<title>수강신청 조회</title>
<body>
	<table border="1" width="600" align="center" class="type08">

		<tr class="label">

			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
			<th>학점</th>
			<th>년도</th>
			<th>학기</th>
			<th>수업시간</th>
		</tr>
		<%
			Connection myConn = null;
			PreparedStatement pstmt = null;
			PreparedStatement prof_pstmt = null;
			ResultSet rs = null;
			ResultSet prs = null;
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			
			String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "c##db";
			String passwd = "db";

			String userID = session_id;
			
			String courseID = "";
			int courseNo = 0;
			
			int courseUnit = 0;
			
			String courseName = "";
			int courseYear = 0;
		
			int courseSemester = 0;
	
			int courseTime = 0;
		
			
			
			try {
				Class.forName(dbdriver);
				myConn = DriverManager.getConnection(dburl, user, passwd);
				String ssql = "select c_id, c_id_no, c_name, c_unit, c_year, c_semester, c_time from enroll where s_id=?";
				
				pstmt = myConn.prepareStatement(ssql);
				pstmt.setString(1, session_id);

				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					courseID = rs.getString("c_id");
					courseNo = rs.getInt("c_id_no");
					courseName = rs.getString("c_name");
					courseUnit =  rs.getInt("c_unit");
					courseYear =  rs.getInt("c_year");
					courseSemester = rs.getInt("c_semester");
					courseTime =  rs.getInt("c_time");
					
		%>
		<tr>

			<td align="center"><%=courseID%></td>
			<td align="center"><%=courseNo%></td>
			<td align="center"><%=courseName%></td>
			<td align="center"><%=courseUnit%></td>
			<td align="center"><%=courseYear%></td>
			<td align="center"><%=courseSemester%></td>
			<td align="center"><%=courseTime%></td>
		</tr>

		<%
			}
			} catch (SQLException se) {
				System.out.println(se.getMessage());
			} finally {
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException sqle) {
					}
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException sqle) {
					}
				if (myConn != null)
					try {
						myConn.close();
					} catch (SQLException sqle) {
					}

			}
		%>
	</table>
</body>
</html>