/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Category;
import models.Role;
import models.User;
import services.AccountService;
import services.InventoryService;

public class ManageUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService as = new AccountService();
        InventoryService is = new InventoryService();

        // returns a list contaning all users
        try {
            List<User> users = as.getAllUsers();
            request.setAttribute("users", users);
        } catch (Exception e) {
            request.setAttribute("usersError", "Something went wrong while getting users...");
        }

        try {
            List<Category> categories = is.getAllCategories();
            request.setAttribute("categories", categories);
        } catch (Exception e) {
            request.setAttribute("categoriesError", "Something went wrong while getting categories...");
        }

        // loads JSP
        getServletContext().getRequestDispatcher("/WEB-INF/manageUsers.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountService as = new AccountService();
        InventoryService is = new InventoryService();

        String action = request.getParameter("action");
        String component = request.getParameter("component");
        String manageValue = request.getParameter("manage_value");
        String emailValue = request.getParameter("email_value");

        if (component.equals("user")) {
            if (action.equals("manage")) {
                if (manageValue.equals("Delete")) {
                    String loggedInUser = (String) session.getAttribute("validUser");
                    if (loggedInUser.equals(emailValue)) {
                        request.setAttribute("selfDeleteError", "You cannot delete yourself!");
                    } else {
                        try {
                            as.deleteUser(emailValue);
                            request.setAttribute("userDeleteSuccessful", "User was successfully deleted!");
                        } catch (Exception e) {
                            request.setAttribute("userDeleteError", "User could not be deleted...");
                        }
                    }
                } else if (manageValue.equals("Edit")) {
                    try {
                        User user = as.getUser(emailValue);
                        Role role = user.getRole();
                        int roleInt = role.getRoleId();
                        request.setAttribute("edit_email_value", user.getEmail());
                        request.setAttribute("edit_password_value", user.getPassword());
                        request.setAttribute("edit_firstname_value", user.getFirstName());
                        request.setAttribute("edit_lastname_value", user.getLastName());
                        request.setAttribute("edit_role_value", roleInt);
                    } catch (Exception ex) {
                        request.setAttribute("userFindError", "User could not be found...");
                    }
                }
            } else if (action.equals("create")) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String firstName = request.getParameter("first_name");
                String lastName = request.getParameter("last_name");
                boolean active = Boolean.valueOf(request.getParameter("active"));
                int role = Integer.parseInt(request.getParameter("role"));

                try {
                    System.out.println("Creating user...");
                    System.out.println(email + ", " + active + ", " + firstName + ", " + lastName
                            + ", " + password + ", " + role);
                    as.addUser(email, active, firstName, lastName, password, role);
                    request.setAttribute("userCreateSuccessful", "User was successfully created!");
                } catch (Exception e) {
                    request.setAttribute("userCreateError", "User could not be created...");
                }
            } else if (action.equals("edit")){
                String oldEmail = (String) session.getAttribute("validUser");
                String email = request.getParameter("edit_email");
                String password = request.getParameter("edit_password");
                String firstName = request.getParameter("edit_first_name");
                String lastName = request.getParameter("edit_last_name");
                boolean active = Boolean.valueOf(request.getParameter("edit_active"));
                int role = Integer.parseInt(request.getParameter("edit_role"));
                try {
                    as.editUsers(oldEmail, email, active, password, firstName, lastName, role);
                    request.setAttribute("userEditSuccessful", "User was successfully edited!");
                } catch (Exception ex) {
                    request.setAttribute("userEditError", "User could not be edited...");
                }
            }
        }
        // returns a list contaning all users
        try {
            List<User> users = as.getAllUsers();
            request.setAttribute("users", users);
        } catch (Exception e) {
            request.setAttribute("usersError", "Something went wrong...");
        }

        try {
            List<Category> categories = is.getAllCategories();
            request.setAttribute("categories", categories);
        } catch (Exception e) {
            request.setAttribute("categoriesError", "Something went wrong while getting categories...");
        }

        // loads JSP
        getServletContext().getRequestDispatcher("/WEB-INF/manageUsers.jsp").forward(request, response);
        return; 
    }

}
