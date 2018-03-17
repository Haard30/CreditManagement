import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
/*
 * --------Intermmediate servlet betweeen viewAll and viewProfile---------
 */
public class viewInter extends HttpServlet{
	public static HttpSession hs; 
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException , ServletException{
		String uid=req.getParameter("userid");
		try {
		    String connectionURL = "jdbc:mysql://localhost/credit_management";
		    Connection connection = null; 
		    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
		    connection = DriverManager.getConnection(connectionURL, "root", "");
		    if(!connection.isClosed())
		    {
		    	Statement st=connection.createStatement();
				ResultSet rs=st.executeQuery("SELECT * FROM user where user_id='"+uid+"'");
				HttpSession hs=req.getSession();
				rs.next();
				
				//Setting sessions of user
						hs.setAttribute("UserId", uid);
				hs.setAttribute("UserName", rs.getString("name"));
				hs.setAttribute("EmailId",rs.getString("email_id") );
				hs.setAttribute("CurrentCredit", rs.getInt("current_credit"));
				
				/*
				 * Forwarding request to viewProfile JSP
				 */
				RequestDispatcher rd = req.getRequestDispatcher("/viewProfile.jsp");
			
				rd.forward(req, res);
			    }
		}
		catch(Exception e){}
		
		
	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException , ServletException{
		
		this.doGet(req, res);
		
	}
}
