package com.mephx.model;

import java.io.Serializable;

public class Brand implements Serializable {
    private Integer id;
    private String name;
    private String image;
    private Boolean visibility;

    public Brand() {
    }

    public Brand(Integer id, String name, String image, Boolean visibility) {
        this.id = id;
        this.name = name;
        this.image = image;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Boolean getVisibility() {
        return visibility;
    }

    public void setVisibility(Boolean visibility) {
        this.visibility = visibility;
    }
}
