
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Category;
import models.Item;
import models.User;
import services.AccountService;
import services.InventoryService;

@WebServlet(name = "InventoryServlet", urlPatterns = {"/inventory"})
public class InventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        AccountService as = new AccountService();
        InventoryService is = new InventoryService();
        
        // get the username of the user logged in
        String email = (String) session.getAttribute("validUser");
        
        try {
            User user = as.getUser(email);
            session.setAttribute("firstName", user.getFirstName());
            session.setAttribute("lastName", user.getLastName());
        } catch (Exception e) {
            request.setAttribute("noUserFound", "No user was found...");
        }
        
        try {
            List<Category> categories = is.getAllCategories();
            request.setAttribute("categories", categories);
        } catch (Exception e) {
            request.setAttribute("categoriesError", "No categories found...");
        }
        
        try{
            List<Item> items = is.getItemsOfOwner(email);
            request.setAttribute("items", items);
        } catch(Exception e){
            request.setAttribute("noItemsFound", "No items were found...");
        }
        
        getServletContext().getRequestDispatcher("/WEB-INF/inventory.jsp").forward(request, response);
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
        
        // if the value of the hidden attribute action is "Delete"
        if(action.equals("Delete")) {
            try {
                int itemID = Integer.parseInt(request.getParameter("itemID"));
                // delete item
                is.deleteItem(itemID);
                request.setAttribute("deleteSuccessful", "Item was successfully deleted!");
            } catch (Exception e) {
                request.setAttribute("deleteError", "An error occured while trying to delete item...");
            }
        }
        else if(action.equals("Edit")){
            String itemIdString = request.getParameter("itemID");
            int itemID = Integer.parseInt(itemIdString);
            session.setAttribute("itemId", itemIdString);
            try {
                Item item = is.getItem(itemID);
                request.setAttribute("editItemName", item.getItemName());
                request.setAttribute("editPrice", item.getPrice());
                System.out.println("Item being edited...");
                System.out.println(itemID);
                System.out.println(item.getItemName());
                System.out.println(item.getPrice());
            } catch (Exception e) {
                request.setAttribute("noItemFetched", "No item was fetched...");
            }
        }      
        // if the value of the hidden attribute action is "Save"
        else if(action.equals("Add")) {
            try {
                // add item
                List<Item> items = is.getAllItems();
                // get the size of list and add one to get the new itemID
                int itemID = items.size() + 1;
                int categoryID = Integer.parseInt(request.getParameter("category"));
                String itemName = request.getParameter("itemname");
                double price = Double.parseDouble(request.getParameter("price"));
                // insertItem()
                is.insertItem(itemID, itemName, price, email, categoryID);
                request.setAttribute("insertSuccessful", "Item was successfully added!");
            } catch (Exception e) {
                request.setAttribute("createError", "An error occured while trying to create item...");
            }
        }
        else if(action.equals("Edit Item")){
            String itemIdString = (String) session.getAttribute("itemId");
            int itemId = Integer.parseInt(itemIdString);
                System.out.println("This is after getting the item id");
                System.out.println(itemId);
            int newCategoryId = Integer.parseInt(request.getParameter("newCategory"));
                System.out.println("This is after getting the category id");
                System.out.println(newCategoryId);
            String newItemName = request.getParameter("newItemName");
                System.out.println("This is after getting the item name");
                System.out.println(newItemName);
            double newPrice = Double.parseDouble(request.getParameter("newPrice"));
                System.out.println("This is after getting the item name");
                System.out.println(newPrice);
            System.out.println("Printed contents of new item...");
           
            try{
                is.editItem(itemId, newCategoryId, newItemName, newPrice);
                request.setAttribute("itemEditSuccessful", "Item was successfully edited!");
            } catch(Exception e){
                request.setAttribute("itemEditError", "Item could not be edited...");
            }
        }
        
        
        // get a list of all categories
        try {
            List<Category> categories = is.getAllCategories();
            request.setAttribute("categories", categories);
        } catch (Exception e) {
            request.setAttribute("categoriesError", "Something went wrong!");
        }
        
        // get a list of all items that belong to the user currently logged in
        try {
            List<Item> items = is.getItemsOfOwner(email);
            request.setAttribute("items", items);
        } catch (Exception e) {
            request.setAttribute("itemsError", "Something went wrong!");
        }
        
        
        getServletContext().getRequestDispatcher("/WEB-INF/inventory.jsp").forward(request, response);
        return;
        
    }

}
