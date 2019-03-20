package com.menu.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.chef.model.ChefService;
import com.chef.model.ChefVO;
import com.menu.model.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MenuServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("image/gif");
		
		ServletOutputStream out = response.getOutputStream();		
		List<String> errorMsgs = new LinkedList<String>();
		
		String showMenuPic = request.getParameter("showMenuPic");
		
		if("showMenuPic".equals(showMenuPic)) {
			try {
				String menu_ID = request.getParameter("menu_ID");
				MenuService menuSvc = new MenuService();
				MenuVO menuVO = (MenuVO) menuSvc.getOneMenu(menu_ID);
				byte[] menu_pic = menuVO.getMenu_pic();	
				System.out.println(menu_pic);
				out.write(menu_pic);
				request.setAttribute("menu_pic", menu_pic);
			}catch(NullPointerException e){
				errorMsgs.add("Not Found:"+e.getMessage());			
			}
		}else {
			doPost(request,response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		
		if("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);

			try {
				// 1.接收參數
				String menu_name = request.getParameter("menu_name");
				Integer menu_price = null;
				try {
					menu_price = Integer.parseInt(request.getParameter("menu_price"));
				}catch(Exception e) {
					errorMsgs.add("請輸入數字");
				}
				Part part= request.getPart("menu_pic");
				InputStream in = part.getInputStream();
				byte[] menu_pic = new byte[in.available()];
				in.read(menu_pic);
				in.close();

				String menu_resume = request.getParameter("menu_resume");
				
				//2.設定
				MenuVO menuVO = new MenuVO();
				menuVO.setMenu_name(menu_name);
				menuVO.setMenu_price(menu_price);
				menuVO.setMenu_pic(menu_pic);
				menuVO.setMenu_resume(menu_resume);
				
				// 如果以上格式有錯
				if (!errorMsgs.isEmpty()) {
					request.setAttribute("menuVO", menuVO);
					RequestDispatcher failureView = request.getRequestDispatcher("/front-end/menu/addMenu.jsp");
					failureView.forward(request, response);
					return;
				}
				//將資料加入資料庫
				MenuService menuSvc = new MenuService();
				menuVO = menuSvc.addMenu(menu_name, menu_resume, menu_pic, menu_price);
				RequestDispatcher successView = request.getRequestDispatcher("/front-end/menu/listAllMenu.jsp");
				successView.forward(request, response);
				//除錯
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = request.getRequestDispatcher("/front-end/menu/addMenu.jsp");
				failureView.forward(request, response);
			}
		}		
		
		if ("getOneForDisplay".equals(action)) { // 來自select_page.jsp的請求

			try {
				/*************************** 1.接收請求參數  **********************/
				String menu_ID = request.getParameter("menu_ID");

				/*************************** 2.開始查詢資料  *****************************************/
				MenuService menuSvc = new MenuService();
				MenuVO menuVO = menuSvc.getOneMenu(menu_ID);
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				session.setAttribute("menuVO", menuVO); // 資料庫取出的menuVO物件,存入request
				RequestDispatcher successView = request.getRequestDispatcher("/front-end/menu/listOneMenu.jsp"); // 成功轉交 listOneMenu.jsp
				successView.forward(request, response);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				RequestDispatcher failureView = request.getRequestDispatcher("/front-end/menu/listAllMenu.jsp");
				failureView.forward(request, response);
			}
		}
		if ("buyThisMenu".equals(action)) { // 來自select_page.jsp的請求

			try {
				/*************************** 1.接收請求參數  **********************/
				String menu_ID = request.getParameter("menu_ID");
				/*************************** 2.開始查詢資料  *****************************************/
				MenuService menuSvc = new MenuService();
				MenuVO menuVO = menuSvc.getOneMenu(menu_ID);
				ChefService chefSvc = new ChefService();
				List<ChefVO> listChefByMenuID = chefSvc.getAllByMenuID(menu_ID);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				session.setAttribute("listChefByMenuID", listChefByMenuID);
				session.setAttribute("menu_ID", menu_ID); 
				session.setAttribute("menuVO", menuVO); // 資料庫取出的menuVO物件,存入request
				
				session.setAttribute("listChefSchByChefID", null);
				session.setAttribute("order_chef_sch_date", null);
				
				RequestDispatcher successView = request.getRequestDispatcher("/front-end/menu/orderMenu.jsp"); // 成功轉交 listOneMenu.jsp
				successView.forward(request, response);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				RequestDispatcher failureView = request.getRequestDispatcher("/front-end/menu/listOneMenu.jsp");
				failureView.forward(request, response);
			}
		}
	}
}
