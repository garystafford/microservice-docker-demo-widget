package com.widget.domain;

import com.widget.domain.Widget;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class WidgetTest {
    private String product_id, name, color, size, preview;
    private Integer price, inventory;
    private Widget getWidget, setWidget;

    @Before
    public void setUp() throws Exception {
        product_id = "TEST_ID_00";
        name = "name_test";
        color = "color_test";
        size = "size_test";
        price = 10;
        inventory = 100;
        preview = "http://www.preview.foo/name_test.png";

        getWidget = new Widget(product_id, name, color, size, price, inventory, preview);

        setWidget = new Widget();
    }

    @Test
    public void testGetId() throws Exception {
        Assert.assertNull(getWidget.getId());
    }

    @Test
    public void testGetProduct_id() throws Exception {
        Assert.assertEquals(product_id, getWidget.getProduct_id());
    }

    @Test
    public void testSetProduct_id() throws Exception {
        setWidget.setProduct_id(product_id);
        Assert.assertEquals(product_id, setWidget.getProduct_id());
    }

    @Test
    public void testGetName() throws Exception {
        Assert.assertEquals(name, getWidget.getName());
    }

    @Test
    public void testSetName() throws Exception {
        setWidget.setName(name);
        Assert.assertEquals(name, setWidget.getName());
    }

    @Test
    public void testGetColor() throws Exception {
        Assert.assertEquals(color, getWidget.getColor());
    }

    @Test
    public void testSetColor() throws Exception {
        setWidget.setColor(color);
        Assert.assertEquals(color, setWidget.getColor());

    }

    @Test
    public void testGetSize() throws Exception {
        Assert.assertEquals(size, getWidget.getSize());
    }

    @Test
    public void testSetSize() throws Exception {
        setWidget.setSize(size);
        Assert.assertEquals(size, setWidget.getSize());
    }

    @Test
    public void testGetPrice() throws Exception {
        Assert.assertEquals(Long.valueOf(price), Long.valueOf(getWidget.getPrice()));
    }

    @Test
    public void testSetPrice() throws Exception {
        setWidget.setPrice(price);
        Assert.assertEquals(Long.valueOf(price), Long.valueOf(setWidget.getPrice()));
    }

    @Test
    public void testGetInventory() throws Exception {
        Assert.assertEquals(Long.valueOf(inventory), Long.valueOf(getWidget.getInventory()));
    }

    @Test
    public void testSetInventory() throws Exception {
        setWidget.setInventory(inventory);
        Assert.assertEquals(Long.valueOf(inventory), Long.valueOf(setWidget.getInventory()));
    }

    @Test
    public void testGetPreview() throws Exception {
        Assert.assertEquals(preview, getWidget.getPreview());
    }

    @Test
    public void testSetPreview() throws Exception {
        setWidget.setPreview(preview);
        Assert.assertEquals(preview, setWidget.getPreview());

    }
}