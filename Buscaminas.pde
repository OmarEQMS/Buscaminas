//Buscaminas

Tablero tablero;
Jugador jugador;
void setup() {
  stroke(0); color(255); background(0); textSize(32);
  size(640, 480);
  tablero = new Tablero(8,10,10);
  jugador = new Jugador(tablero.GetGridY(), tablero.GetGridX(), tablero);
}

void draw() { 
  tablero.drawTablero();
}

void mouseClicked() {
  if(mouseButton == LEFT){
    tablero.ClickMouse(mouseY, mouseX);
    jugador.LoopTiradas();
  }else{
    tablero.ClickMouseDerecho(mouseY, mouseX);
  }
}