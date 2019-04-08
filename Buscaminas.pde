//Buscaminas
int gridX=10, gridY=10;
int size;
int defX, defY;

void setup() {
  size(640, 480);
  size = ((width/gridX)>(height/gridY)) ? (height/gridY) : (width/gridX);
  defX = (width-(gridX*size))/2;
  defY = (height-(gridY*size))/2;
    
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