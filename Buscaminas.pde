//Buscaminas

Tablero tablero;
void setup() {
  stroke(0); color(255); background(0); textSize(32);
  size(640, 480);
  tablero = new Tablero(8,8,10);
}

void draw() { 
  tablero.drawTablero();
}

void mouseClicked() {
  tablero.ClickMouse(mouseX, mouseY);
}