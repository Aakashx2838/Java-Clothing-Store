package com.mephx.model;

import java.io.Serializable;

public class Product implements Serializable {
    private Integer id;
    private String name;
    private Double price;
    private Integer rating;
    private String color;
    private String size;
    private Integer quantity;
    private String images;
    private String description;
    private Integer reviews;
    private Brand brand;
    private Category category;
    private Boolean visibility;

    public Product() {
    }

    public Product(Integer id, String name, Double price, Integer rating, String color, String size, Integer quantity, String images, String description, Integer reviews, Brand brand, Category category, Boolean visibility) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.rating = rating;
        this.color = color;
        this.size = size;
        this.quantity = quantity;
        this.images = images;
        this.description = description;
        this.reviews = reviews;
        this.brand = brand;
        this.category = category;
        this.visibility = visibility;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getColor() {
        return color;
    }

    public String[] getColorArray() {
        if (color == null) return new String[0];
        return color.replace("[", "").replace("]", "").replace("\"", "").split(",");
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }
    public String[] getSizeArray() {
        if (size == null) return new String[0];
        return size.replace("[", "").replace("]", "").replace("\"", "").split(",");
    }

    public void setSize(String size) {
        this.size = size;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String[] getImagesArray() {
        if (images == null) return new String[0];
        return images.replace("[", "").replace("]", "").replace("\"", "").split(", ");
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getReviews() {
        return reviews;
    }

    public void setReviews(Integer reviews) {
        this.reviews = reviews;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Category getCategory() { return category; }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Boolean getVisibility() {
        return visibility;
    }

    public void setVisibility(Boolean visibility) {
        this.visibility = visibility;
    }
}
