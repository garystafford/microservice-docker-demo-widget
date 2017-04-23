package com.widget.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Widget {

    @Id
    private String id;

    private String product_id;
    private String name;
    private String color;
    private String size;
    private Integer price;
    private Integer inventory;
    private String preview;

    public Widget() {
    }

    public Widget(String product_id, String name, String color, String size,
                  Integer price, Integer inventory, String preview) {
        this.product_id = product_id;
        this.name = name;
        this.color = color;
        this.size = size;
        this.price = price;
        this.inventory = inventory;
        this.preview = preview;
    }

    public String getId() {
        return id;
    }

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

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public String getPreview() {
        return preview;
    }

    public void setPreview(String preview) {
        this.preview = preview;
    }
}
