package com.wuye.mobile.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.wuye.common.util.SpringUtil;
import com.wuye.entity.User;
import com.wuye.services.UserServiceManager;


public class BusinessControlServlet extends HttpServlet{
	private static Logger log = Logger.getLogger(BusinessControlServlet.class);
	private UserServiceManager userServiceManager = SpringUtil.getBean("userServiceManager");
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BusinessControlServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入GET");
		doPost(request, response);
	
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		String type = request.getParameter("type");
		String wxid = request.getParameter("wxid");
		String account = request.getParameter("account");
		log.info("请求类型："+type);
		if ("paymentQuery".equals(type)) {	
			
			request.getRequestDispatcher("/jsp/mobile/businessPaymentQuery.jsp").forward(request, response);
			
		} 
	}
}
