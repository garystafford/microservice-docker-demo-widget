package com.example;

import org.springframework.data.annotation.Id;

import java.math.BigDecimal;

public class Widget {
    @Id
    private String id;

    private String product_id;
    private String name;
    private String color;
    private String size;
    private BigDecimal price;
    private Integer inventory;

    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public Widget() {
    }

    public Widget(String product_id, String name, String color,
                  String size, BigDecimal price, Integer inventory) {
        this.product_id = product_id;
        this.name = name;
        this.color = color;
        this.size = size;
        this.price = price;
        this.inventory = inventory;
    }
}
