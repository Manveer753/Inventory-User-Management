
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="css/manageCategories.css">
        <title>Manage Categories</title>
    </head>
    <body>

        <nav>
            <ul class="nav-bar">
                <li class="nav-bar-link"><a href="inventory">Inventory</a></li>
                <li class="nav-bar-link"><a href="user">Edit User Info</a></li>
                <li class="nav-bar-link"><a href="manage_users">Manage Users</a></li>
            </ul>
        </nav>

        <div class="heading">
            <h1>Manage Categories - ${firstName} ${lastName}</h1>

            <form method="get" action="login">
                <input class="logout-btn" type="submit" name="log_out" value="Log Out">
            </form>
        </div>         

        <div class="add-category-form">
            <h2 class="form-heading">Add Category</h2>
            <form method="POST" action="manage_categories">
                <ul class="form-outer">
                    <li class="form_field">
                        <label>Category Name: </label>
                        <input type="text" name="new_category_name">
                    </li>
                    <li class="form_field">
                        <input type="submit" name="add_category" value="Create Category">
                    </li>
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="component" value="category">
                </ul>
            </form>

            <h2 class="msg">${categoryCreateSuccessful}</h2>
            <h2 class="msg">${categoryCreateError}</h2>
        </div>

        <div class="edit-category-form" id="edit-category">
            <h2 class="form-heading">Edit Category</h2>
            <form method="POST" action="manage_categories">
                <ul class="form-outer">
                    <li class="form_field">
                        <label>Category Name: </label>
                        <input type="text" name="edit_category_name" value="${newCategoryName}">
                    </li>
                    <li class="form_field">
                        <input type="submit" name="add_category" value="Edit Category">
                    </li>
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="component" value="category">
                </ul>
            </form>

            <h2 class="msg">${categoryFetchSuccessful}</h2>
            <h2 class="msg">${categoryEditSuccessful}</h2>
            <h2 class="msg">${categoryEditError}</h2>
        </div>

        <div class="manage-catagories"> 
            <div class="form-headings">
                <span>Category</span>
                <span>Edit</span>
            </div>
            <c:forEach var="category" items="${categories}">
                <form action="manage_categories" method="POST">
                    <ul class="category-edits">
                        <li>${category.categoryName}</li>
                        <li><a href="#edit-category"><input class="category-edit-btn" type="submit" name="manage_value" value="Edit"></a></li>
                        <input type="hidden" name="edit_category_id" value="${category.categoryId}">
                        <input type="hidden" name="action" value="manage">
                        <input type="hidden" name="component" value="category">
                    </ul>
                </form>
            </c:forEach>  
        </div>

    </body>
</html>
