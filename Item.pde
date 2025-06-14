class Item {
  String code;
  String name;
  float price;
  int quantity;
  PImage image;
  float width;
  float height;
  
  Item(String code, String name, float price) {
    this.code = code;
    this.name = name;
    this.price = price;
    this.quantity = 5;
    // TODO: Load image based on item name
  }
  
  void setSize(float w, float h) {
    this.width = w;
    this.height = h;
  }
  
  boolean isAvailable() {
    return quantity > 0;
  }
  
  void vend() {
    if (isAvailable()) {
      quantity--;
    }
  }
  
  void display(int x, int y) {
    // Display item information
    fill(255); // White text
    textAlign(CENTER);
    textSize(12);
    
    // Center text in the item's space
    float centerX = x + width/2;
    float centerY = y + height/2;
    
    // Display name
    text(name, centerX, centerY - 15);
    
    // Display price
    text("$" + String.format("%.2f", price), centerX, centerY);
    
    // Display code
    text(code, centerX, centerY + 15);
    
    // Display item image if available
    if (image != null) {
      image(image, centerX - 20, centerY + 30, 40, 40);
    }
  }
} 