<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<%-- Authenticating User to block entry if user is already logged in --%>
<%
  Cookie[] authCookie = request.getCookies(); // Getting user cookies
  User user;
  ValidateCredentials vc = new ValidateCredentials();

  try {
    user = vc.checkCookie(authCookie); // Checking if the cookie is valid or not
    if (user != null) {
      response.sendRedirect("home.jsp"); // Redirecting to home.jsp if user exists
    }
  } catch (SQLException | ClassNotFoundException e) {
    throw new RuntimeException(e);
  }
%>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MEPHX | Register</title>
  <link rel="stylesheet" type="text/css" href="../css/globals.css" />
  <script
    src="https://kit.fontawesome.com/86f6b8ce70.js"
    crossorigin="anonymous"
  ></script>
</head>
<body>
<div class="w-screen h-screen flex overflow-hidden bg-bg font-urbanist">
  <div class="w-full">
    <img src="../assets/images/login-page.jpg" alt="Login Page Image" class="w-full h-full" loading="lazy" />
  </div>
  <div
    class="w-full h-full bg-black/25 text-white flex flex-col justify-center items-center"
  >
    <div class="space-y-[48px]">
      <div class="space-y-[32px]">
        <div class="space-y-[12px]">
          <h1 class="text-3xl text-[32px] font-bold">Create an account</h1>
          <div class="text-text-dim font-semibold text-base">
            <p>
              Please fill in the below information to start buying products
              on MEPHX.
            </p>
          </div>
        </div>
        <div>
          <form
            class="space-y-[16px]"
            method="post"
            action="<%=request.getContextPath()%>/register-user"
            enctype="multipart/form-data"
          >
            <!--Image input for user-->
            <div class="space-y-[8px] text-white font-semibold text-xl">
              <label for="profile_picture">
                Profile Picture:
                <span class="text-red-500"> * </span>
              </label>
              <br />
              <div class="relative flex items-center">
                <div
                  class="w-[50px] aspect-square rounded-full bg-black flex items-center justify-center"
                >
                  <i
                    class="fa fa-user-circle-o text-3xl"
                    aria-hidden="true"
                  ></i>
                </div>
                <span class="ml-4">Select an image</span>
                <input
                  type="file"
                  name="profile_picture"
                  id="profile_picture"
                  class="form-input !max-w-full absolute inset-0 opacity-0"
                  accept="image/*"
                  required
                />
              </div>
            </div>
            <!--First name and last name input-->
            <div class="flex justify-between gap-8">
              <div class="space-y-[8px] text-white font-semibold text-xl">
                <label for="first_name">
                  First Name:
                  <span class="text-red-500"> * </span>
                </label>
                <input
                  type="text"
                  name="first_name"
                  id="first_name"
                  class="form-input"
                  placeholder="First Name"
                  required
                />
              </div>
              <div class="space-y-[8px] text-white font-semibold text-xl">
                <label for="last_name">
                  Last Name:
                  <span class="text-red-500"> * </span>
                </label>
                <input
                  type="text"
                  name="last_name"
                  id="last_name"
                  class="form-input"
                  placeholder="Last Name"
                  required
                />
              </div>
            </div>
            <!--Address and Sex input-->
            <div class="flex gap-8">
              <div
                class="space-y-[8px] text-white font-semibold text-xl w-full"
              >
                <label for="address">
                  Address:
                  <span class="text-red-500"> * </span>
                </label>
                <input
                  type="text"
                  name="address"
                  id="address"
                  class="form-input"
                  placeholder="Address"
                  required
                />
              </div>
              <div
                class="space-y-[8px] text-white font-semibold text-xl w-full"
              >
                <label>
                  Sex:
                  <span class="text-red-500"> * </span>
                </label>
                <br />
                <div class="flex justify-between">
                  <div class="space-x-[16px] flex items-center">
                    <input
                      type="radio"
                      name="sex"
                      id="male"
                      value="male"
                      class="accent-brand h-5 aspect-square"
                      required
                    />
                    <span class="font-normal text-lg">Male</span>
                  </div>
                  <div class="space-x-[16px] flex items-center">
                    <input
                      type="radio"
                      name="sex"
                      id="female"
                      value="female"
                      class="accent-brand h-5 aspect-square"
                      required
                    />
                    <span class="font-normal text-lg">Female</span>
                  </div>
                  <div class="space-x-[16px] flex items-center">
                    <input
                      type="radio"
                      name="sex"
                      id="other"
                      value="other"
                      class="accent-brand h-5 aspect-square"
                      required
                    />
                    <span class="font-normal text-lg">None</span>
                  </div>
                </div>
              </div>
            </div>
            <!--Date of birth input-->
            <div class="space-y-[8px] text-white font-semibold text-xl">
              <label for="date_of_birth">
                Date Of Birth:
                <span class="text-red-500"> * </span>
              </label>
              <br />
              <input
                type="date"
                name="date_of_birth"
                id="date_of_birth"
                class="form-input !max-w-full"
                required
              />
            </div>
            <!--Phone number input-->
            <div class="space-y-[8px] text-white font-semibold text-xl">
              <label for="phone_number">
                Phone Number:
                <span class="text-red-500"> * </span>
              </label>
              <br />
              <input
                type="number"
                name="phone_number"
                id="phone_number"
                class="form-input !max-w-full"
                placeholder="98XXXXXXXX"
                required
              />
            </div>
            <!--Email input-->
            <div class="space-y-[8px] text-white font-semibold text-xl">
              <label for="email">
                Email:
                <span class="text-red-500"> * </span>
              </label>
              <br />
              <input
                type="email"
                name="email"
                id="email"
                class="form-input !max-w-full"
                placeholder="Email"
                required
              />
            </div>
            <!--Password input-->
            <div class="space-y-[8px] text-white font-semibold text-xl">
              <label for="password">
                Password:
                <span class="text-red-500"> * </span>
              </label>
              <br />
              <input
                type="password"
                name="password"
                id="password"
                class="form-input !max-w-full"
                placeholder="Password"
                required
              />
            </div>
            <!--Submit-->
            <div class="py-5 flex justify-between items-center" >
              <a href="../index.jsp" class="text-brand font-semibold"> Already Have an account? Log In </a>
              <button type="submit" class="btn-primary">Submit</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
