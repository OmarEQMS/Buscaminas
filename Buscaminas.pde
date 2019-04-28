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
  for (int i =0;i<8;i++) {
    
      tablero.Click (i,i);
  }
}

void draw() { 
  tablero.drawTablero();
  
}
