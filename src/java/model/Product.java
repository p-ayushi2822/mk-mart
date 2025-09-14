package model;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private int categoryId;
    private byte[] image;

    public Product() {
    }

    public Product(int id, String name, String description, double price, int categoryId, byte[] image) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.image = image;
    }
    
    public int getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
    public int getCategoryId() { return categoryId; }
    public byte[] getImage() { return image; }
}
