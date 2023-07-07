package com.mephx.controller.auth;

import com.mephx.DAO.implementations.UserDAOImpl;
import com.mephx.DAO.interfaces.UserDAO;
import com.mephx.model.User;
import jakarta.servlet.http.Cookie;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.SQLException;

public class ValidateCredentials {
    User user;
    public String encryptPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    public boolean verifyCredentials(String password, String hashedPassword) {
        return BCrypt.checkpw(password, hashedPassword); //Creates hashed password,checks it and returns it
    }

    //Takes email, password and boolean isAlreadyHashed checks if it matches and return user, else if user doesnot match returns null
    public User login(String email, String password, boolean isAlreadyHashed ) throws SQLException, ClassNotFoundException {
        UserDAO userDAO = new UserDAOImpl();
        user = userDAO.getUserByEmail(email); //Fetch user details by using email
        if (user == null) {
            return null;
        }
        if (isAlreadyHashed && password.equals(user.getPassword())) { //Checks if the password from cookie matches with the entered password which is already hashed and returns user if matched
            return user;
        }
        if (verifyCredentials(password, user.getPassword())) { //Gets entered password into hashed password and checks it with the DB password and returns user if matched
            return user;
        }
        return null; //Return null if the none of the password matches with the fetched user detail's password
    }

    //Creating cookie of the current user
    public Cookie createCookie(String email,String password) {
        Cookie authCookie = new Cookie("MEPHXud", email + "///" + password); //Creating cookie named "MEPHXud" and value as merged email and password seperating by "///"
        authCookie.setMaxAge(2592000); //Setting the age of cookie to 30 Days
        return authCookie;
    }

    /**
     * @param authCookie
     * @return user
     * @throws SQLException
     * @throws ClassNotFoundException
     * @implNote This method checks if the user has a cookie stored in their browser.
     */
    public User checkCookie(Cookie[] authCookie) throws SQLException, ClassNotFoundException {
        if (authCookie == null) {
            return null; //Returning null if the cookie is empty

        }
        for (Cookie cookie : authCookie) {
            String name = cookie.getName(); //fetching name from the cookie
            if (name.equals("MEPHXud")) {
                String userDetails = cookie.getValue();
                String[] details = userDetails.split("///");
                user = login(details[0], details[1], true);
                break;
            }
        }
        return user;
    }
}
