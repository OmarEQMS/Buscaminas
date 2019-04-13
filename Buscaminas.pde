//Buscaminas
 import java.util.Random;
int gridX=8, gridY=8;
int size,bombas=10;
int defX, defY;
int mapa [][]= new int  [gridX][gridY];
void setup() {
  size(640, 480);
  size = ((width/gridX)>(height/gridY)) ? (height/gridY) : (width/gridX);
  defX = (width-(gridX*size))/2;
  defY = (height-(gridY*size))/2;
  IniciarBombas();
  IniciarNumeros();

      System.out.print("\n");
  ImprimeMapa();
  stroke(0);
  color(255);
  background(0);
}

void draw() { 
  for(int i = 0; i < gridX; i++){
    for(int j = 0; j < gridY; j++){
      rect(defX + (i*size), defY + (j*size), size, size);
    }
  }
}
