package com.mephx.model;

import java.io.Serializable;

public class Order implements Serializable {
    private Integer id;
    private Integer cart_id;
    private Double orderTotal;
    private Boolean isDelivered;

    public Order() {
    }

    public Order(Integer id, Integer cart_id, Double orderTotal, Boolean isDelivered) {
        this.id = id;
        this.cart_id = cart_id;
        this.isDelivered = isDelivered;
        this.orderTotal = orderTotal;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCartId() {
        return cart_id;
    }

    public void setCartId(Integer cart_id) {
        this.cart_id = cart_id;
    }

    public Boolean getIsDelivered() {
        return isDelivered;
    }

    public void setIsDelivered(Boolean isDelivered) {
        this.isDelivered = isDelivered;
    }

    public Double getOrderTotal() {
        return orderTotal;
    }

    public void setOrderTotal(Double orderTotal) {
        this.orderTotal = orderTotal;
    }
}
