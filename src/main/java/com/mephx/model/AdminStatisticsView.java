package com.mephx.model;

import java.io.Serializable;

public class AdminStatisticsView implements Serializable {

    private Integer totalUsers;
    private Integer totalSales;
    private Integer totalProducts;
    private Integer totalCategories;
    private Integer totalBrands;

    public AdminStatisticsView(Integer totalUsers, Integer totalSales, Integer totalProducts, Integer totalCategories, Integer totalBrands) {
        this.totalUsers = totalUsers;
        this.totalSales = totalSales;
        this.totalProducts = totalProducts;
        this.totalCategories = totalCategories;
        this.totalBrands = totalBrands;
    }

    public AdminStatisticsView(){

    }

    public Integer getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(Integer totalUsers) {
        this.totalUsers = totalUsers;
    }

    public Integer getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(Integer totalSales) {
        this.totalSales = totalSales;
    }

    public Integer getTotalProducts() {
        return totalProducts;
    }

    public void setTotalProducts(Integer totalProducts) {
        this.totalProducts = totalProducts;
    }

    public Integer getTotalCategories() {
        return totalCategories;
    }

    public void setTotalCategories(Integer totalCategories) {
        this.totalCategories = totalCategories;
    }

    public Integer getTotalBrands() {
        return totalBrands;
    }

    public void setTotalBrands(Integer totalBrands) {
        this.totalBrands = totalBrands;
    }
}
