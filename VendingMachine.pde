class VendingMachine {
  ArrayList<Item> inventory;
  ArrayList<Button> buttons;
  float balance;
  String currentCode;
  String message;
  int messageTimer;
  int messageAlpha;
  int codeAlpha;
  PImage logo;
  PFont font;
  PFont digitalFont;
  boolean messageFadingOut;
  
  VendingMachine(ArrayList<Item> inv, float funds) {
    inventory = inv;
    buttons = new ArrayList<Button>();
    balance = funds;
    currentCode = "";
    message = "Insert money and select item";
    messageTimer = 0;
    messageAlpha = 255;
    codeAlpha = 0;
    messageFadingOut = true;
    initializeItems();
    initializeButtons();
  }
  
  void initializeButtons() {
    float buttonWidth = 40;  // 120/3 for 3 columns
    float buttonHeight = 45; // 180/4 for 4 rows
    float startX = 750;      // Fixed X position
    float startY = 235;      // Fixed Y position
    
    String[] labels = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "0", "1", "2"};
    int index = 0;
    
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 3; col++) {
        float x = startX + (col * buttonWidth);
        float y = startY + (row * buttonHeight);
        buttons.add(new Button(x, y, buttonWidth, buttonHeight, labels[index]));
        index++;
      }
    }
  }
  
  void handleClick(float x, float y) {
    for (Button button : buttons) {
      if (button.isMouseOver(x, y)) {
        button.press();
        String input = button.label;
        
        if (currentCode.length() < 3) {
          currentCode += input;
          codeAlpha = 255; // Make code visible immediately
          
          if (currentCode.length() == 3) {
            processVending();
          }
        }
      }
    }
  }
  
  void handleRelease(float x, float y) {
    for (Button button : buttons) {
      button.release();
    }
  }
  
  void processVending() {
    Item selectedItem = null;
    for (Item item : inventory) {
      if (item.code.equals(currentCode)) {
        selectedItem = item;
        break;
      }
    }
    
    if (selectedItem == null) {
      message = "Invalid code";
    } else if (!selectedItem.isAvailable()) {
      message = "Item out of stock";
    } else if (balance < selectedItem.price) {
      message = "Insufficient funds";
    } else {
      balance -= selectedItem.price;
      selectedItem.vend();
      message = "Vended: " + selectedItem.name + 
                " + $" + String.format("%.2f", balance) + " change";
    }
    messageAlpha = 255; // Reset message alpha when new message is set
    messageFadingOut = true;
  }
  
  void update() {
    // Update code alpha
    if (currentCode.length() == 3 && codeAlpha > 0) {
      codeAlpha = max(0, codeAlpha - 1);
      if (codeAlpha == 0) {
        currentCode = ""; // Clear code when fully faded
        message = "Insert money and select item";
      }
    }
    
    // Update message alpha
    if (messageFadingOut) {
      messageAlpha = max(0, int(messageAlpha - 8.5)); // 255/30 frames for smooth fade
      if (messageAlpha == 0) {
        messageFadingOut = false;
      }
    } else {
      messageAlpha = min(255, int(messageAlpha + 8.5));
      if (messageAlpha == 255) {
        messageFadingOut = true;
      }
    }
  }
  
  void display() {
    // Display keypad
    for (Button button : buttons) {
      button.display();
    }
    
    // Display current code and balance below keypad
    textFont(digitalFont);
    textAlign(LEFT);
    textSize(24);
    
    // Display code with fade effect
    fill(255, 165, 0, codeAlpha); // Orange color with alpha
    text("Code: " + currentCode, 750, 435);
    
    // Always display balance at full opacity
    fill(255, 165, 0); // Orange color
    text("Balance: $" + String.format("%.2f", balance), 750, 465);
    
    // Display message with cyclic fade
    textFont(digitalFont);
    textSize(32);
    textAlign(CENTER);
    fill(220, 0, 0, messageAlpha);
    text(message, 10, 730, 620, 80);
    
    // Display items
    displayItems();
  }
  
  void displayItems() {
    int startX = 60;
    int startY = 170;
    int itemsPerRow = 8;  // 8 columns
    int totalRows = 6;    // 6 rows
    float itemWidth = 535.0 / itemsPerRow;  // 535 pixels divided by 8 columns
    float itemHeight = 535.0 / totalRows;   // 535 pixels divided by 6 rows
    
    fill(255); // Set text color to white
    textFont(font); // Use regular font for items
    textAlign(LEFT);
    
    for (int i = 0; i < inventory.size(); i++) {
      int row = i / itemsPerRow;
      int col = i % itemsPerRow;
      int x = startX + (int)(col * itemWidth);
      int y = startY + (int)(row * itemHeight);
      Item item = inventory.get(i);
      item.setSize(itemWidth, itemHeight);
      item.display(x, y);
    }
  }
}
