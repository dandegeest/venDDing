class Button {
  float x, y, w, h;
  String label;
  boolean isHovered;
  boolean isPressed;
  
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.isHovered = false;
    this.isPressed = false;
  }
  
  void display() {
    // Button background
    if (isPressed) {
      fill(180);
    } else {
      fill(220);
    }
    
    stroke(100);
    rect(x, y, w, h, 10);
    
    // Button label
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }
  
  boolean isMouseOver(float mx, float my) {
    return mx >= x && mx <= x + w && my >= y && my <= y + h;
  }
  
  void update(float mx, float my) {
    isHovered = isMouseOver(mx, my);
  }
  
  void press() {
    isPressed = true;
  }
  
  void release() {
    isPressed = false;
  }
} 