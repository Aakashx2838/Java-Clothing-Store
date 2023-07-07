package com.mephx.model;

import java.io.Serializable;

public class Cart implements Serializable {
    private Integer cartId;
    private Integer user_id;
    private String created_at;
    private String modified_at;
    private Boolean isCartCheckedOut;

    public Cart() {
    }

    public Cart(Integer cartId, Integer user_id, Boolean isCartCheckedOut, String created_at, String modified_at) {
        this.cartId = cartId;
        this.user_id = user_id;
        this.isCartCheckedOut = isCartCheckedOut;
        this.created_at = created_at;
        this.modified_at = modified_at;
    }

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getModified_at() {
        return modified_at;
    }

    public void setModified_at(String modified_at) {
        this.modified_at = modified_at;
    }

    public Boolean getIsCartCheckedOut() {
        return isCartCheckedOut;
    }

    public void setIsCartCheckedOut(Boolean isCartCheckedOut) {
        this.isCartCheckedOut = isCartCheckedOut;
    }

}
