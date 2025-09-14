package model;

public class WishlistItem {
    private int id;
    private int wishlistId;
    private int productId;

    public WishlistItem(int id, int wishlistId, int productId) {
        this.id = id;
        this.wishlistId = wishlistId;
        this.productId = productId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getWishlistId() {
        return wishlistId;
    }

    public void setWishlistId(int wishlistId) {
        this.wishlistId = wishlistId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}
