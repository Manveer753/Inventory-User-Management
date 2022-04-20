
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import services.AccountService;
import services.InventoryService;

public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService as = new AccountService();
        HttpSession session = request.getSession();
        
        String email = (String) session.getAttribute("validUser");
        
        try {
            User user = as.getUser(email);
            session.setAttribute("firstName", user.getFirstName());
            session.setAttribute("lastName", user.getLastName());
        } catch (Exception e) {
            request.setAttribute("noUserFound", "No user was found...");
        }
        
        getServletContext().getRequestDispatcher("/WEB-INF/user.jsp").forward(request, response);
        return; 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("validUser");
        AccountService as = new AccountService();
        InventoryService is = new InventoryService();
        
        String action = request.getParameter("action");
        
        if(action.equals("Edit")){
            String newEmail = request.getParameter("email");
            String newPassword = request.getParameter("password");
            String newFirstName = request.getParameter("first_name");
            String newLastName = request.getParameter("last_name");
            try {
                as.editUser(email, newEmail, newPassword, newFirstName, newLastName);
                request.setAttribute("userEditSuccessful", "User was successfully edited!");
            } catch (Exception e) {
                request.setAttribute("userEditError", "User was not edited...");
            }
        }
        
        try {
            User user = as.getUser(email);
            session.setAttribute("firstName", user.getFirstName());
            session.setAttribute("lastName", user.getLastName());
        } catch (Exception e) {
            request.setAttribute("noUserFound", "No user was found...");
        }
        
        getServletContext().getRequestDispatcher("/WEB-INF/user.jsp").forward(request, response);
        return;
        
    }

}
