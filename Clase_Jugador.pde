class Punto{
  int x; int y;
  Punto(int y, int x){
   this.x = x;
   this.y = y;
  }
}

class Jugador{
  int gridX, gridY;
  int mapa[][];
  Tablero tablero;
  
  Jugador(int h, int w, Tablero t){
    gridX = w; gridY = h; 
    mapa= new int  [gridY][gridX];
    tablero = t;
    GetTablero();    
  }
  
  void GetTablero(){
    for(int i = 0; i < gridY; i++){
      for(int j = 0; j < gridX; j++){
        mapa[i][j] = tablero.GetCelda(i, j); // -3 Outof Range, -2 Tapado, -1 Bomba, >0 numero 
      }
    }  
  }
  
  void LoopTiradas(){
    boolean cambios;
    do{
      cambios = false;
      GetTablero(); 
      for(int i = 0; i < gridY; i++){
        for(int j = 0; j < gridX; j++){
          if(mapa[i][j]>=0){
            ArrayList<Punto> puntos = CeldaCerradas(i,j);
            if((puntos.size()+MinasAlrededor(i,j))==mapa[i][j]){ //Es Seguro Abrir
              if(AsigmanrMinas(puntos)) cambios = true;
            }
            if(MinasAlrededor(i,j)==mapa[i][j]){ //Es Seguro Abrir
              if(AbrirDisponibles(i,j)) cambios = true;
            }
          }
        }
      }
    }while(cambios==true);
  }
  
  ArrayList<Punto> CeldaCerradas(int i, int j){
    ArrayList<Punto> puntos = new ArrayList<Punto>();
    if (ValidarCelda(i-1,j,gridX,gridY) &&   mapa [i-1][j] == -2) puntos.add(new Punto(i-1,j));
    if (ValidarCelda(i+1,j,gridX,gridY) &&   mapa [i+1][j] == -2) puntos.add(new Punto(i+1,j));
    if (ValidarCelda(i,j-1,gridX,gridY) &&   mapa [i][j-1] == -2) puntos.add(new Punto(i,j-1));
    if (ValidarCelda(i,j+1,gridX,gridY) &&   mapa [i][j+1] == -2) puntos.add(new Punto(i,j+1));
    if (ValidarCelda(i-1,j-1,gridX,gridY) && mapa [i-1][j-1] == -2) puntos.add(new Punto(i-1,j-1));
    if (ValidarCelda(i+1,j+1,gridX,gridY) && mapa [i+1][j+1] == -2) puntos.add(new Punto(i+1,j+1));
    if (ValidarCelda(i+1,j-1,gridX,gridY) && mapa [i+1][j-1] == -2) puntos.add(new Punto(i+1,j-1));
    if (ValidarCelda(i-1,j+1,gridX,gridY) && mapa [i-1][j+1] == -2) puntos.add(new Punto(i-1,j+1));
    return puntos;
  }
  
  int MinasAlrededor(int i, int j){
    int minas = 0;
    if (ValidarCelda(i-1,j,gridX,gridY) &&   mapa [i-1][j] == -1) minas++;
    if (ValidarCelda(i+1,j,gridX,gridY) &&   mapa [i+1][j] == -1) minas++;
    if (ValidarCelda(i,j-1,gridX,gridY) &&   mapa [i][j-1] == -1) minas++;
    if (ValidarCelda(i,j+1,gridX,gridY) &&   mapa [i][j+1] == -1) minas++;
    if (ValidarCelda(i-1,j-1,gridX,gridY) && mapa [i-1][j-1] == -1) minas++;
    if (ValidarCelda(i+1,j+1,gridX,gridY) && mapa [i+1][j+1] == -1) minas++;
    if (ValidarCelda(i+1,j-1,gridX,gridY) && mapa [i+1][j-1] == -1) minas++;
    if (ValidarCelda(i-1,j+1,gridX,gridY) && mapa [i-1][j+1] == -1) minas++;
    return minas;
  }
  
  boolean AsigmanrMinas(ArrayList<Punto> puntos){
    boolean cambios = false;
    for(int i = 0; i < puntos.size(); i++){
      mapa[puntos.get(i).y][puntos.get(i).x] = -1;
      if(tablero.ClickDerecho(puntos.get(i).y,puntos.get(i).x)) cambios = true;
    }
    return cambios;
  }
  
  boolean AbrirDisponibles(int i, int j){
    boolean cambios = false;
    if (ValidarCelda(i-1,j,gridX,gridY) &&   mapa [i-1][j] != -1) if(tablero.Click(i-1,j)) cambios = true;
    if (ValidarCelda(i+1,j,gridX,gridY) &&   mapa [i+1][j] != -1) if(tablero.Click(i+1,j)) cambios = true;
    if (ValidarCelda(i,j-1,gridX,gridY) &&   mapa [i][j-1] != -1) if(tablero.Click(i,j-1)) cambios = true;
    if (ValidarCelda(i,j+1,gridX,gridY) &&   mapa [i][j+1] != -1) if(tablero.Click(i,j+1)) cambios = true;
    if (ValidarCelda(i-1,j-1,gridX,gridY) && mapa [i-1][j-1] != -1) if(tablero.Click(i-1,j-1)) cambios = true;
    if (ValidarCelda(i+1,j+1,gridX,gridY) && mapa [i+1][j+1] != -1) if(tablero.Click(i+1,j+1)) cambios = true;
    if (ValidarCelda(i+1,j-1,gridX,gridY) && mapa [i+1][j-1] != -1) if(tablero.Click(i+1,j-1)) cambios = true;
    if (ValidarCelda(i-1,j+1,gridX,gridY) && mapa [i-1][j+1] != -1) if(tablero.Click(i-1,j+1)) cambios = true;
    return cambios;
  }
  
  boolean ValidarCelda(int pY, int pX, int sizeX, int sizeY){
    return (pX<sizeX && pX>=0 && pY<sizeY && pY>=0);
  }
  
};