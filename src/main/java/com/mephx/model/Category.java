package com.mephx.model;

public class Category {
    private Integer id;
    private String name;
    private String description;
    private Boolean visibility;

    public Category() {
    }

    public Category(Integer id, String name, String description, Boolean visibility) {
        this.id = id;
        this.name = name;
        this.description = description;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getVisibility() {
        return visibility;
    }

    public void setVisibility(Boolean visibility) {
        this.visibility = visibility;
    }
}
