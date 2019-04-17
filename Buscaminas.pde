//Buscaminas
 import java.util.Random;
int gridX=8, gridY=8;
int size,bombas=10;
int defX, defY;
int mapa [][]= new int  [gridX][gridY];
boolean tapados [][] = new boolean [gridX][gridY];
PImage bomba;
void setup() {
  size(640, 480);
  size = ((width/gridX)>(height/gridY)) ? (height/gridY) : (width/gridX);
  defX = (width-(gridX*size))/2;
  defY = (height-(gridY*size))/2;
  IniciarBombas();
  IniciarNumeros();
  bomba = loadImage ("minesweeper.png");
  bomba.resize (32,32);
      System.out.print("\n");
  ImprimeMapa();
  stroke(0);
  color(255);
  background(0);
  for (int i =0;i<gridX;i++) 
    for (int j= 0;j<gridY;j++)
      if (i==j)
        Click (i,j);
  
}

void draw() { 
  int auxColor;
  for(int i = 0; i < gridX; i++){
    for(int j = 0; j < gridY; j++){
      textSize(32);
      fill (150,150,150);
      rect(defX + (i*size), defY + (j*size), size, size);
      auxColor = mapa [i][j];
      switch (auxColor){
        case -1: fill(0,0,0);
        case 1: fill (0,0,255); break;
        case 2: fill (0,255,0); break;
        case 3: fill (255,0,0); break;
        default: fill (135,0,0); break;
      }
      if (auxColor !=-1){
        if (auxColor != 0)
          text (mapa[i][j],defX+15 + (i*size),defY + (j*size)+50);
      }else {   
        image(bomba, defX + 10+(i*size),defY + (j*size)+10);
      }
      if (tapados [i][j] == true){
        fill (100,100,100);
        rect(defX + (i*size), defY + (j*size), size, size);
      }
        
    }
  }
  
}
