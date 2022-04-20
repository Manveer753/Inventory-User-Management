
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="css/manageUsers.css">
        <title>Manage Users</title>
    </head>
    <body>

        <nav>
            <ul class="nav-bar">
                <li class="nav-bar-link"><a href="inventory">Inventory</a></li>
                <li class="nav-bar-link"><a href="user">Edit User Info</a></li>
                <li class="nav-bar-link"><a href="manage_categories">Manage Categories</a></li>
            </ul>
        </nav>

        <div class="heading">
            <h1>Manage Users - ${firstName} ${lastName}</h1>

            <form method="get" action="login">
                <input class="logout-btn" type="submit" name="log_out" value="Log Out">
            </form>
        </div>

        <div class="add-user-form">
            <h2 class="form-heading">Add User</h2>
            <form method="POST" action="manage_users">
                <ul class="form-outer">
                    <li class="form_field">
                        <label>Email: </label>
                        <input type="email" name="email">
                    </li>
                    <li class="form_field">
                        <label>Password: </label>
                        <input type="text" name="password">
                    </li>
                    <li class="form_field">
                        <label>First Name: </label>
                        <input type="text" name="first_name">
                    </li>
                    <li class="form_field">
                        <label>Last Name: </label>
                        <input type="text" name="last_name">
                    </li>
                    <li class="form_field">
                        <label>Active: </label>
                        <select name="active">
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </select>
                    </li>
                    <li class="form_field">
                        <label>Role: </label>
                        <input type="number" name="role" min="1" max="3">
                    </li>
                    <li>
                        <input class="form-btn" type="submit" name="addbutton" value="Create User">
                    </li>
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="component" value="user">
                </ul>
            </form>
            <h2 class="msg">${userCreateSuccessful}</h2>
            <h2 class="msg">${userCreateError}</h2>
        </div>

        <div class="edit-user-form">
            <h2 class="form-heading">Edit User</h2>
            <form method="POST" action="manage_users">
                <ul class="form-outer">
                    <li class="form_field">
                        <label>Email: </label>
                        <input type="email" name="edit_email" value="${edit_email_value}">
                    </li>
                    <li class="form_field">
                        <label>Password: </label>
                        <input type="text" name="edit_password" value="${edit_password_value}">
                    </li>
                    <li class="form_field">
                        <label>First Name: </label>
                        <input type="text" name="edit_first_name" value="${edit_firstname_value}">
                    </li>
                    <li class="form_field">
                        <label>Last Name: </label>
                        <input type="text" name="edit_last_name" value="${edit_lastname_value}">
                    </li>
                    <li class="form_field">
                        <label>Active: </label>
                        <select name="edit_active">
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </select>
                    </li>
                    <li class="form_field">
                        <label>Role: </label>
                        <input type="number" name="edit_role" min="1" max="3" value="${edit_role_value}">
                    </li>
                    <li>
                        <input id="edit-user" type="submit" name="addbutton" value="Edit User">
                    </li>
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="component" value="user">
                </ul>
            </form> 
            <h2 class="msg">${userFindError}</h2>
            <h2 class="msg">${userEditSuccessful}</h2>
            <h2 class="msg">${userEditError}</h2>
        </div>

        <div class="user-edits">
            <div class="form-headings">
                <span>Email</span>
                <span>First Name</span>
                <span>Last Name</span>
                <span>Delete</span>
                <span>Edit</span>
            </div>
            <c:forEach var="user" items="${users}">
                <form action="manage_users" method="POST">
                    <ul class="user-info">
                        <li>${user.email}</li>
                        <li>${user.firstName}</li>
                        <li>${user.lastName}</li>
                        <li><input class="user-btn" type="submit" name="manage_value" value="Delete"></li>
                        <li><a href="#edit-user"><input class="user-btn" type="submit" name="manage_value" value="Edit"></a></li>
                        <input type="hidden" name="email_value" value="${user.email}">
                        <input type="hidden" name="action" value="manage">
                        <input type="hidden" name="component" value="user">
                    </ul>
                </form>
            </c:forEach>    

            <h2 class="msg">${userDeleteSuccessful}</h2>
            <h2 class="msg">${userDeleteError}</h2>
            <h2 class="msg">${selfDeleteError}</h2>
        </div>
    </body>
</html>
