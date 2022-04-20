
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="css/login.css">
        <title>Login Page</title>
    </head>
    <body>

        <div class="forms-container">
            <h1>Log In</h1>

            <form class="login-form" action="login" method="POST">
                <div class="form-field">
                    <label>Email: </label>
                    <input type="text" name="email" value="${email}">
                </div>
                <div class="form-field">
                    <label>Password: </label>
                    <input type="password" name="password" value="${password}">
                </div>
                <input class="form-btn" type="submit" name="loginButton" value="Log In">
                <input type="hidden" name="action" value="login">
            </form>

            <h4>${invalidLogin}</h4>
            <h4>${loggedOut}</h4>
            <h4>${userDeactivateSuccessful}</h4>
            <h4>${userDeactivateError}</h4>
            <h4>${accountDeactivate}</h4>
        </div>

        <div class="forms-container">
            <h1>Don't have an account?</h1>
            <form class="register-form" action="login" method="POST">
                <div class="form-field">
                    <label>Email: </label>
                    <input type="email" name="email">
                </div>
                <div class="form-field">
                    <label>Password: </label>
                    <input type="text" name="password">
                </div>
                <div class="form-field">
                    <label>First Name: </label>
                    <input type="text" name="first_name">
                </div>
                <div class="form-field">
                    <label>Last Name: </label>
                    <input type="text" name="last_name">
                </div>
                <input class="form-btn" type="submit" name="createButton" value="Register">
                <input type="hidden" name="action" value="register">
            </form>

            <h4>${userRegisterError}</h4>
            <h4>${userRegisterSuccessful}</h4>
        </div>

    </body>
</html>
