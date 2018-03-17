/*
 * Logic servlet for transfer
 */

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/TransferLogic")
public class TransferLogic extends HttpServlet {
    public TransferLogic() {
     }

	
	protected void doGet(HttpServletRequest requestlogic, HttpServletResponse responselogic) throws ServletException, IOException {
		String transstr=requestlogic.getParameter("creditamount");
		int transamt=Integer.parseInt(transstr);
		
		HttpSession hs=requestlogic.getSession();
		int mycredit= (int) hs.getAttribute("CurrentCredit");
		String to_id=requestlogic.getParameter("to_id");
		int to_id_int=Integer.parseInt(to_id);
		String from_id= (String) hs.getAttribute("UserId");
		int from_id_int=Integer.parseInt(from_id);
		System.out.println(to_id_int);
		System.out.println(from_id_int);
		//Testing if valid credits
		if(mycredit-transamt<0){
			hs.setAttribute("status","FAILED!Not enough credits");
		}
		else{
			int to_currentcredits;
			int to_finalcredits;
			int from_finalcredits;
			Connection connection = null; 
			try {
			    String connectionURL = "jdbc:mysql://localhost/credit_management";
			    
			    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			    connection = DriverManager.getConnection(connectionURL, "root", "");
			    if(!connection.isClosed())
			    {
			    	Statement st=connection.createStatement();
			    	ResultSet rs=st.executeQuery("SELECT user_id,name,current_credit FROM user WHERE user_id ='"+to_id+"'");
			    	rs.next();
			    	to_currentcredits=rs.getInt("current_credit");
			    	to_finalcredits=to_currentcredits+transamt;
			    	
			    	from_finalcredits=mycredit-transamt;
			    	
			    	
			    	/*
			    	 * Updating the database
			    	*/
			    	connection.setAutoCommit(false);
			    	
			    	
			    	
			    	
			    	
			    		
			    	 // create the java mysql update preparedstatement
			        String query1 = "update user set current_credit = ? where user_id = ?";
			        PreparedStatement preparedStmt = connection.prepareStatement(query1);
			        //For from user
			        preparedStmt.setInt   (1, to_finalcredits);
			        preparedStmt.setInt(2, to_id_int);

			        // execute the java preparedstatement
			        preparedStmt.executeUpdate();
			        
			        
			        //For to user
			        preparedStmt.setInt   (1, from_finalcredits);
			        preparedStmt.setInt(2, from_id_int);
			        preparedStmt.executeUpdate();
			    	
			        
			      //Inserting into Transaction table
			        
			        PreparedStatement pstmt = connection.prepareStatement("INSERT INTO `transaction`(`trans_id`, `from_user_id`, `to_user_id`, `amount`) VALUES (?, ?, ?, ?)");
			        pstmt.setString(1, null);
			        pstmt.setInt(2, from_id_int);
			        pstmt.setInt(3, to_id_int);
			        pstmt.setInt(4, transamt);
			        
			        pstmt.executeUpdate();
			       // st.executeUpdate("INSERT INTO `transaction` (`trans_id`, `from_user_id`, `to_user_id`, `amount`) VALUES ("+null+"', "+from_id_int+", "+to_id_int+", "+transamt+"')");
			        
			        connection.commit(); 
			    	System.out.println("Done!");
			    	
			    	
			    }
			    
			    }
			
			catch (SQLException e) {

	            System.out.println(e.getMessage());
	            try {
					connection.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			
		} catch (Exception e) {	}
		
					hs.setAttribute("status","successful");
	}
		RequestDispatcher rd = requestlogic.getRequestDispatcher("/TransStatus.jsp");
		
		rd.forward(requestlogic, responselogic);

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
