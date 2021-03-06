package com.forumMsg.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ForumMsgJNDIDAO implements ForumMsgDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CookGodDB");
		}catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT =
			"INSERT INTO FORUM_MSG (FORUM_MSG_ID,FORUM_MSG_CON,FORUM_MSG_STATUS,FORUM_ART_ID,CUST_ID) VALUES ('MS'||LPAD((FORUM_ART_SEQ.NEXTVAL),4,'0'),?,?,?,?)";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM FORUM_MSG order by FORUM_MSG_ID";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM FORUM_MSG where FORUM_MSG_ID = ?";
	private static final String DELETE =
			"DELETE FROM FORUM_MSG where FORUM_MSG_ID = ?";
	private static final String UPDATE = 
			"UPDATE FORUM_MSG set FORUM_MSG_CON=? ,FORUM_MSG_STATUS = ?,FORUM_ART_ID = ?,CUST_ID= ? where FORUM_MSG_ID = ?";

	@Override
	public void insert(ForumMsgVO ForumMsgVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, ForumMsgVO.getForum_msg_con());
			pstmt.setString(2, ForumMsgVO.getForum_msg_status());
			pstmt.setString(3, ForumMsgVO.getForum_art_ID());
			pstmt.setString(4, ForumMsgVO.getCust_ID());

			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+ se.getMessage());
		}finally {	
			if (pstmt != null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		if (con != null) {
			try {
			con.close();
		}catch (Exception e) {
			e.printStackTrace(System.err);
				}
			}			
		}
	}
	

	@Override
	public void update(ForumMsgVO ForumMsgVO) {
		
		Connection con = null;
		PreparedStatement pstmt =null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,ForumMsgVO.getForum_msg_con());
			pstmt.setString(2, ForumMsgVO.getForum_msg_status());
			pstmt.setString(3, ForumMsgVO.getForum_art_ID());
			pstmt.setString(4, ForumMsgVO.getCust_ID());
			pstmt.setString(5, ForumMsgVO.getForum_msg_ID());
		
			pstmt.executeUpdate();
			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+ se.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
			}catch (SQLException se) {
				se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				}catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(String forum_msg_ID) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, forum_msg_ID);
			
			pstmt.executeUpdate();
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+se.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				}catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	@Override
	public ForumMsgVO findByPrimaryKey(String forum_msg_ID) {
		
		ForumMsgVO ForumMsgVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, forum_msg_ID);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ForumMsgVO = new ForumMsgVO();
				ForumMsgVO.setForum_msg_ID(rs.getString("forum_msg_ID"));
				ForumMsgVO.setForum_msg_con(rs.getString("forum_msg_con"));
				ForumMsgVO.setForum_msg_status(rs.getString("forum_msg_status"));
				ForumMsgVO.setForum_art_ID(rs.getString("forum_art_ID"));
				ForumMsgVO.setCust_ID(rs.getString("cust_ID"));
				
				
			}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+ se.getMessage());
			
		}finally {
			if (rs != null) {
				try {
					rs.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				}catch (Exception e) {
					e.printStackTrace(System.err);
					}
				}
			}
		return ForumMsgVO;
	}


	@Override
	public List<ForumMsgVO> getAll() {
		
		List<ForumMsgVO> list = new ArrayList<ForumMsgVO>();
		ForumMsgVO ForumMsgVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ForumMsgVO = new ForumMsgVO();
				ForumMsgVO.setForum_msg_ID(rs.getString("forum_msg_ID"));
				ForumMsgVO.setForum_msg_con(rs.getString("forum_msg_con"));
				ForumMsgVO.setForum_msg_start(rs.getTimestamp("forum_msg_start"));
				ForumMsgVO.setForum_msg_status(rs.getString("forum_msg_status"));
				ForumMsgVO.setForum_art_ID(rs.getString("forum_art_ID"));
				ForumMsgVO.setCust_ID(rs.getString("cust_ID"));
				list.add(ForumMsgVO);
				
			}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured."
					+ se.getMessage());
		}finally {
			if (rs !=null) {
					try {
						rs.close();
					}catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			if (pstmt != null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				}catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

		return list;
	}
}


