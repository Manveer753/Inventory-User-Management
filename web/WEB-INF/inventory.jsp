
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="css/inventory.css">
        <title>Home Inventory</title>
    </head>
    <body>

        <nav>
            <ul class="nav-bar">
                <li class="nav-bar-link"><a href="users">Edit User Info</a></li>
                <li class="nav-bar-link"><a href="manage_users">Manage Users</a></li>
                <li class="nav-bar-link"><a href="manage_categories">Manage Categories</a></li>
            </ul>
        </nav>


        <div class="heading">
            <h1>Edit User Info - ${firstName} ${lastName}</h1>

            <form method="get" action="login">
                <input class="logout-btn" type="submit" name="log_out" value="Log Out">
            </form>
        </div>

        <div class="item-forms">

            <div class="add-item-form">
                <h2 class="form-heading">Add Item</h2>
                <!-- showing from to add items -->
                <form method="POST" action="inventory">
                    <ul class="form-outer">
                        <li class="form_field">
                            <!-- selecting category -->
                            <label>Category: </label>
                            <select name="category">                       
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                        </li>
                        <li class="form_field">
                            <!-- inputting item name -->
                            <label>Item Name: </label>
                            <!-- if item name/price are invalid, it keeps the fields filled with previous entries -->
                            <input type="text" name="itemname" value="${itemName}">
                        </li>
                        <li class="form_field">
                            <!-- entering price -->
                            <label>Price: </label>
                            <input type="text" name="price" value="${price}">
                        </li>
                        <li>
                            <input class="form-btn" type="submit" class="form-btn" name="action" value="Add">
                        </li>
                    </ul>
                </form>
                <h2 class="msg">${insertSuccessful}</h2>
                <h2 class="msg">${createError}</h2>
            </div>

            <div class="edit-item-form">
                <h2 class="form-heading">Edit Item</h2>
                <form method="POST" action="inventory">
                    <ul class="form-outer">
                        <li class="form_field">
                            <!-- selecting category -->
                            <label>Category: </label>
                            <select name="newCategory">                       
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                        </li>
                        <li class="form_field">
                            <!-- inputting item name -->
                            <label>Item Name: </label>
                            <!-- if item name/price are invalid, it keeps the fields filled with previous entries -->
                            <input type="text" name="newItemName" value="${editItemName}">
                        </li>
                        <li class="form_field">
                            <!-- entering price -->
                            <label>Price: </label>
                            <input type="text" name="newPrice" value="${editPrice}">
                        </li>
                        <li>
                            <input class="form-btn" type="submit" class="form-btn" name="action" value="Edit Item">
                        </li>
                    </ul>
                    <h2 class="msg">${itemEditSuccessful}</h2>
                    <h2 class="msg">${itemEditError}</h2>
                    <h2 class="msg">${deleteSuccessful}</h2>
                    <h2 class="msg">${deleteError}</h2>
                </form>
            </div>
        </div>

        <div class="info-table">
            <div class="form-headings">
                <span>Category</span>
                <span>Item</span>
                <span>Price</span>
                <span>Delete</span>
                <span>Edit</span>
            </div>
            <c:forEach var="item" items="${items}"> 
                <form action="inventory" method="POST">        
                    <ul class="item-edits">
                        <li>${item.category.categoryName}</li>
                        <li>${item.itemName}</li>
                        <li>${item.price}</li>
                        <li><input type="submit" class="edit-item-btn" name="action" value="Delete"></li>
                        <li><input type="submit" class="edit-item-btn" name="action" value="Edit"></li>
                        <input type="hidden" name="itemID" value="${item.itemId}">
                    </ul>
                </form>
            </c:forEach>

            <h2 class="msg">${noItemFetched}</h2>
        </div>
    </body>
</html>
