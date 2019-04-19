//Buscaminas
import java.util.Random;
import java.util.Stack;
Tablero tablero;
void setup() {
  stroke(0);
  color(255);
  background(0);
  tablero = new Tablero();
  size(640, 480);
  tablero.setupTablero();
}

void draw() { 
  tablero.drawTablero();
  
}
