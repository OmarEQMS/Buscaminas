//Buscaminas

Tablero tablero;
Jugador jugador;
void setup() {
  stroke(0); color(255); background(0);
  size(1300, 900);
  tablero = new Tablero(50,50,375);
  jugador = new Jugador(tablero);
}

void draw() { 
  tablero.drawTablero();
}

void mouseClicked() {
  if(mouseButton == LEFT){
    tablero.ClickMouse(mouseY, mouseX);
  }else{
    tablero.ClickMouseDerecho(mouseY, mouseX);
  }
  jugador.LoopTiradas();
}