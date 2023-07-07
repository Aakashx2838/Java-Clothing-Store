package com.mephx.model;

import java.io.Serializable;

public class User implements Serializable {
    private Integer userId;
    private String image;
    private String first_name;
    private String last_name;
    private String address;
    private String sex;
    private String date_of_birth;
    private String email;
    private String password;
    private String role;
    private Long phone;

    public User() {
    }

    public User(Integer userId, String first_name, String last_name, String date_of_birth, String sex, String email, String password, String address, String image, String role, Long phone) {
        super();
        this.userId = userId;
        this.first_name = first_name;
        this.last_name = last_name;
        this.date_of_birth = date_of_birth;
        this.sex = sex;
        this.email = email;
        this.password = password;
        this.address = address;
        this.image = image;
        this.role = role;
        this.phone = phone;
    }

    //    Getters
    public Integer getUserId() {
        return userId;
    }

    public String getFirst_name() {
        return first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public String getDateOfBirth() {
        return date_of_birth;
    }

    public String getSex() {
        return sex;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getAddress() {
        return address;
    }

    public String getImage() {
        return image;
    }

    public String getRole() {
        return role;
    }

    public Long getPhone() {
        return phone;
    }

    //    Setters

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public void setAge(String String_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setPhone(Long phone) {
        this.phone = phone;
    }
}
