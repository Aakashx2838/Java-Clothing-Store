<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="com.mephx.model.User" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<%-- Authenticating User --%>
<%
    Cookie[] authCookie = request.getCookies(); // Getting user cookies
    User user;
    ValidateCredentials vc = new ValidateCredentials();

    try {
        user = vc.checkCookie(authCookie); // Checking if the cookie is valid or not
        if (user != null) {
            response.sendRedirect("client/home.jsp"); // Redirecting to home.jsp if user exists
        }
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>MEPHX | Login</title>
    <link rel="stylesheet" type="text/css" href="./css/globals.css"/>
</head>
<body>
<%-- Login page --%>
<div
    class="w-screen h-screen overflow-hidden bg-bg flex items-center justify-center text-white font-urbanist"
>
    <div class="space-y-[41px]">
        <div>
            <h1 class="text-[48px] font-bold">Welcome Back,</h1>
            <p class="text-[16px] font-semibold text-text-dim">
                Don't have an account?
                <a href="client/register.jsp" class="text-brand"> Sign up </a>
            </p>
        </div>
        <div>
            <%--Remaining Task: To show error message if user credentials are wrong or doesn't exist--%>
            <form class="space-y-[20px]" method="post" action="login-user">
                <%--Email Input--%>
                <div class="space-y-[8px] text-white font-semibold text-xl">
                    <label for="email">Email:</label>
                    <br/>
                    <input
                        type="email"
                        name="email"
                        id="email"
                        class="form-input !max-w-full"
                        placeholder="Email"
                        required
                    />
                </div>
                <%--Password Input--%>
                <div class="space-y-[8px] text-white font-semibold text-xl">
                    <label for="password">Password:</label>
                    <br/>
                    <input
                        type="password"
                        name="password"
                        id="password"
                        class="form-input !max-w-full"
                        placeholder="Password"
                        required
                    />
                </div>
                <%--Continue without logging in?--%>
                <div class="flex justify-end font-semibold">
                    <a href="./client/home.jsp" class="text-brand">
                        Continue without logging in?
                    </a>
                </div>
                <%--Login Button--%>
                <div class="py-5 flex justify-end">
                    <button type="submit" class="btn-primary !w-full !text-black">
                        Login
                    </button>
                </div>
            </form>
            <%--Footer--%>
            <hr class="border-neutral-700"/>
            <div class="text-neutral-400 text-sm py-5 font-medium">
                &copy; 2023 MEPHX. All Rights Reserved.
            </div>
        </div>
    </div>
</div>
</body>
</html>
