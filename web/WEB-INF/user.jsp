<%-- 
    Document   : user
    Created on : Dec 1, 2021, 6:50:37 PM
    Author     : manve
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="css/user.css">
        <title>User Account</title>
    </head>
    <body>

        <nav>
            <ul class="nav-bar">
                <li class="nav-bar-link"><a href="inventory">Inventory</a></li>
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

        <div class="edit-user-form">
            <form action="user" method="POST">
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
                    <li>
                        <input class="form-btn" type="submit" name="action" value="Edit">
                    </li>
                </ul>
            </form>
        </div>

        <h2 class="msg">${userEditSuccessful}</h2>
        <h2 class="msg">${userEditError}</h2>

        <div class="deactivate-form">
            <form method="get" action="login">
                <input class="deactivate-btn" type="submit" name="deactivate" value="Deactivate">
            </form>
        </div>

    </body>
</html>
