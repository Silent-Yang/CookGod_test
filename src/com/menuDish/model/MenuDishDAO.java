package com.menuDish.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MenuDishDAO implements MenuDishDAO_interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CookGodDB");
		}catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT ="INSERT INTO MENU_DISH(MENU_ID,DISH_ID)VALUES(?,?)";
	private static final String GET_ALL_STMT ="SELECT * FROM MENU_DISH order by MENU_ID";
	private static final String GET_ALL_BY_MENU_ID ="SELECT * FROM MENU_DISH where menu_id=? order by MENU_ID";
	private static final String GET_ONE_STMT ="SELECT * FROM MENU_DISH where MENU_ID = ? AND DISH_ID = ? ";
	private static final String DELETE ="DELETE FROM MENU_DISH where MENU_ID=? AND DISH_ID=?";
	private static final String UPDATE ="UPDATE MENU_DISH set DISH_ID=? where MENU_ID=? AND DISH_ID=?";
	
	
	@Override
	public void insert(MenuDishVO menuDishVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, menuDishVO.getMenu_ID());
			pstmt.setString(2, menuDishVO.getDish_ID());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}
	
	@Override
	public void update(MenuDishVO menuDishVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(2, menuDishVO.getMenu_ID());
			pstmt.setString(3, menuDishVO.getDish_ID());

			pstmt.executeUpdate();

			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void delete(String menu_ID, String dish_ID) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, menu_ID);
			pstmt.setString(2, dish_ID);

			pstmt.executeUpdate();

			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}
		
	

	@Override
	public MenuDishVO findyByPrimaryKeys (String menu_ID) {
		MenuDishVO menuDishVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, menu_ID);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				menuDishVO = new MenuDishVO();
				menuDishVO.setMenu_ID(rs.getString("menu_ID"));
				menuDishVO.setDish_ID(rs.getString("dish_ID"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return menuDishVO ;
	}


	@Override
	public List<MenuDishVO> getAll() {
		List<MenuDishVO> list = new ArrayList<MenuDishVO>();
		MenuDishVO menuDishVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				menuDishVO = new MenuDishVO();
				
				menuDishVO.setMenu_ID(rs.getString("menu_ID"));
				menuDishVO.setDish_ID(rs.getString("dish_ID"));
				
				
				list.add(menuDishVO); 

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

	@Override
	public void insert2(MenuDishVO menuDishVO, Connection con) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<MenuDishVO> getAllByMenuID(String menu_ID) {
		List<MenuDishVO> list = new ArrayList<MenuDishVO>();
		MenuDishVO menuDishVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_MENU_ID);

			pstmt.setString(1, menu_ID);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				menuDishVO = new MenuDishVO();
				menuDishVO.setMenu_ID(rs.getString("menu_ID"));
				menuDishVO.setDish_ID(rs.getString("dish_ID"));
				list.add(menuDishVO); 
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

}

//	@Override
//	public void insert2(MenuDishVO menuDishVO, Connection con) {
//		
//			
//			PreparedStatement pstmt = null;
//			
//			try {
//				
//				pstmt = con.prepareStatement(INSERT_STMT);
//				
//				pstmt.setString(1, menuDishVO.getMenu_ID());
//				pstmt.setString(2, menuDishVO.getDish_ID());
//				
//				pstmt.executeUpdate();
//			
//			} catch (SQLException se) {
//				if (con != null) {
//					try {
//						
//						System.err.print("Transaction is being ");
//						System.err.println("rolled back-��-emp");
//						con.rollback();
//					} catch (SQLException excep) {
//						throw new RuntimeException("rollback error occured. "
//								+ excep.getMessage());
//					}
//				}
//				throw new RuntimeException("A database error occured. "
//						+ se.getMessage());
//				// Clean up JDBC resources
//			} finally {
//				if (pstmt != null) {
//					try {
//						pstmt.close();
//					} catch (SQLException se) {
//						se.printStackTrace(System.err);
//					}
//		
//				}
//			}
//	}
