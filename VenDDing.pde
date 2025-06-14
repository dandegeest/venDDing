VendingMachine vendingMachine;
PImage backgroundImage;
PImage logoImage;
PFont font;
PFont digitalFont;

void setup() {
  size(900, 1024);
  
  // Load fonts first
  try {
    font = createFont("Arial", 16);
    digitalFont = createFont("data/digital_7/digital-7.ttf", 32);
    if (font == null) font = createFont("Arial", 16);
    if (digitalFont == null) digitalFont = createFont("Arial", 32);
    textFont(font);
  } catch (Exception e) {
    println("Error loading fonts: " + e.getMessage());
    font = createFont("Arial", 16);
    digitalFont = createFont("Arial", 32);
  }
  
  // Load background image
  backgroundImage = loadImage("data/venddo.png");
  // Load logo
  logoImage = loadImage("data/source-allies-logo.png");
  
  vendingMachine = new VendingMachine(initializeItems(), 5.00);
  vendingMachine.font = font;
  vendingMachine.digitalFont = digitalFont;
}

void draw() {
  // Draw background image
  if (backgroundImage != null) {
    image(backgroundImage, 0, 0);
  } else {
    background(240);
  }
  
  // Display logo at the top
  if (logoImage != null) {
    image(logoImage, 10, 10);
  }
  
  vendingMachine.display();
  vendingMachine.update();
}

void mousePressed() {
  vendingMachine.handleClick(mouseX, mouseY);
}

void mouseReleased() {
  vendingMachine.handleRelease(mouseX, mouseY);
}

ArrayList<Item> initializeItems() {
  String[] productNames = {
    "Water", "Soda", "Chips", "Candy", "Cookies",
    "Granola", "Pretzels", "Nuts", "Gum", "Mints"
  };
  ArrayList<Item> inventory = new ArrayList<Item>();
  String[] letters = {"A", "B", "C", "D", "E", "F", "G", "H"};
  String[] numbers = {"0", "1", "2"};
  String[] doubleLetters = {"AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH", "II"};
  
  // Create 48 items (8×6 grid)
  int codeIndex = 0;
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 6; col++) {
      String code;
      if (codeIndex < 24) {
        // First 24 items: A00-H00, A01-H01, A02-H02
        code = letters[codeIndex % 8] + numbers[codeIndex / 8] + numbers[codeIndex / 8];
      } else {
        // Last 24 items: AA0-HI0, AA1-HI1
        code = doubleLetters[codeIndex % 8] + numbers[(codeIndex - 24) / 8];
      }
      
      String name = productNames[int(random(productNames.length))];
      float price = random(0.50, 2.50);
      inventory.add(new Item(code, name, price));
      codeIndex++;
    }
  }
  
  return inventory;
}
