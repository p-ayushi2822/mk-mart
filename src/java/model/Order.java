package model;

import java.util.Date;

public class Order {
    private int id;
    private int userId;
    private Date orderDate;
    private double totalAmount;
    private String status; // New field
    private String customerName; // For display purposes

    public Order(int id, int userId, Date orderDate, double totalAmount, String status) { // Updated constructor
        this.id = id;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status; // Initialize new field
    }

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public Date getOrderDate() { return orderDate; }
    public double getTotalAmount() { return totalAmount; }
    public String getStatus() { return status; } // New getter
    public String getCustomerName() { return customerName; }

    // Setters
    public void setStatus(String status) { this.status = status; } // New setter
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
}