package com.qfedu.esys.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(urlPatterns="/code")
public class VerificationCodeServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int charNum = 4;
		int width = 30*4;
		int height = 30;
		
		BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		Graphics graphics = bufferedImage.getGraphics();
		graphics.setColor(Color.YELLOW);
		graphics.fillRect(0, 0, width, height);
		
		graphics.setColor(Color.WHITE);
		graphics.fillRect(0, 0, width-1, height-1);
		
		graphics.setColor(Color.RED);
		graphics.setFont(new Font("宋体", Font.BOLD, 20));
		
		Graphics2D graphics2d = (Graphics2D) graphics;
		String s = "ABCDEFGHGKLMNPQRSTUVWXYZ23456789";
		
		Random random = new Random();
		String msg = "";
		int x = 5;
		for(int i=0; i<4; i++) {
			int index = random.nextInt(32);
			String content = String.valueOf(s.charAt(index));
			msg+=content;
			double theta = random.nextInt(45)*Math.PI/180;
			graphics2d.rotate(theta, x, 18);
			graphics2d.drawString(content, x, 18);
			graphics2d.rotate(-theta, x, 18);
			x+=30;
		}
		
		graphics.setColor(Color.GRAY);
		for (int i = 0; i < 5; i++) {
			int x1 = random.nextInt(width);
			int x2 = random.nextInt(width);
	
			int y1 = random.nextInt(height);
			int y2 = random.nextInt(height);
			graphics.drawLine(x1, y1, x2, y2);
		}
		Cookie cookie = new Cookie("code", msg); 
		resp.addCookie(cookie);
		graphics.dispose();
		ImageIO.write(bufferedImage, "jpg", resp.getOutputStream());
        req.getSession().setAttribute("code", msg);  
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
