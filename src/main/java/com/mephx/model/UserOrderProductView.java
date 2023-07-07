package com.mephx.model;

import java.io.Serializable;

public class UserOrderProductView implements Serializable {
    private Integer orderId;
    private Integer cart_id;
    private Integer user_id;
    private Integer totalItems;
    private Double totalPrice;
    private String colors;
    private String sizes;
    private String quantities;
    private String prices;
    private String firstName;
    private String lastName;
    private String products;
    private Boolean isDelivered;

    public UserOrderProductView() {
    }

    public UserOrderProductView(Integer orderId, Integer cart_id, Integer user_id, Integer totalItems, Double totalPrice, String colors, String sizes, String quantities, String prices, String firstName, String lastName, String products, Boolean isDelivered) {
        this.orderId = orderId;
        this.cart_id = cart_id;
        this.user_id = user_id;
        this.totalItems = totalItems;
        this.totalPrice = totalPrice;
        this.colors = colors;
        this.sizes = sizes;
        this.quantities = quantities;
        this.prices = prices;
        this.firstName = firstName;
        this.lastName = lastName;
        this.products = products;
        this.isDelivered = isDelivered;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getCart_id() {
        return cart_id;
    }

    public void setCart_id(Integer cart_id) {
        this.cart_id = cart_id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Integer getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(Integer totalItems) {
        this.totalItems = totalItems;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getColors() {
        return colors;
    }

    public void setColors(String colors) {
        this.colors = colors;
    }

    public String getSizes() {
        return sizes;
    }

    public void setSizes(String sizes) {
        this.sizes = sizes;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getProducts() {
        return products;
    }

    public void setProducts(String products) {
        this.products = products;
    }

    public Boolean getIsDelivered() {
        return isDelivered;
    }

    public void setIsDelivered(Boolean isDelivered) {
        this.isDelivered = isDelivered;
    }

    public void setQuantities(String quantities) {
        this.quantities = quantities;
    }

    public String getQuantities() {
        return quantities;
    }

    public void setPrices(String prices) {
        this.prices = prices;
    }

    public String getPrices() {
        return prices;
    }
}
