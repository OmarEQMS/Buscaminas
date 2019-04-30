class Punto{
  int x; int y;
  Punto(int y, int x){
   this.x = x;
   this.y = y;
  }
}

class Jugador{
  int gridX, gridY;
  int bombas;
  int mapa[][];
  Tablero tablero;
  
  Jugador(Tablero t){
    tablero = t;
    gridY = tablero.GetGridY();
    gridX = tablero.GetGridX();
    bombas = tablero.GetBombas();
    mapa= new int  [gridY][gridX];
    GetTablero();    
    print("Dame un empujoncito\n"); 
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
    boolean cambiosBIG;  
    do{
      //Primer Intento, para cada celda, veo si la cantidad de tarjetas cerradas es la cantidad de minas esperadas
      do{
        GetTablero(); //Por cuestion de los ceros
        cambios = false;        
        for(int i = 0; i < gridY; i++){
          for(int j = 0; j < gridX; j++){
            if(mapa[i][j]>=0){
              ArrayList<Punto> puntos = CerradasAlrededor(i,j);
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
      
      //Segundo intento, para cada celda, veo la posibilidad de una bomba, tomo la mayor
      cambiosBIG = false;
      if(CartasCerradas()!=0){
        Punto mejor = new Punto(0,0); double posibilidad=0; boolean repetido = false;
        for(int i = 0; i < gridY; i++){
          for(int j = 0; j < gridX; j++){
            if(mapa[i][j]==-2){ //Las tapadas, posibilidad de ser mina
              double pos = MinasNecesariasAlrededor(i,j);
              if(pos>0) print("(" + i + "," + j + "):" + pos + "\n");
              if(pos==posibilidad){
                repetido=true;
              }else if(pos>posibilidad){
                posibilidad = pos;
                mejor.y =i; mejor.x = j;
                repetido = false;
              }
            }
          }
        }
        if(posibilidad>0 && repetido==false){
          print("Tomando mejor posibilidad de ser mina(" + mejor.y + "," + mejor.x + ")\n");
          mapa[mejor.y][mejor.x] = -1;
          if(tablero.ClickDerecho(mejor.y,mejor.x)) cambiosBIG = true;
        }
      }
      if(CartasCerradas()==bombas-MinasDescubiertas() && CartasCerradas()!=0){
        print("Ya solo quedan bombas");
        for(int i = 0; i < gridY; i++){
          for(int j = 0; j < gridX; j++){
            AsigmanrMina(i,j);
          }
        }
      }
    }while(cambiosBIG==true);
    
    if(CartasCerradas()==0){
      print("Acabe\n"); 
    }else{
      print("Echame la Mano\n"); 
    }
  }
  
  //Chequeo
  ArrayList<Punto> CerradasAlrededor(int i, int j){
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
  double MinasNecesariasAlrededor(int i, int j){
    double posibilidadDeMina = 0;
    if (ValidarCelda(i-1,j,gridX,gridY) && mapa [i-1][j]>0 ) posibilidadDeMina += (double)(mapa [i-1][j]-MinasAlrededor(i-1,j)) / mapa [i-1][j];
    if (ValidarCelda(i+1,j,gridX,gridY) && mapa [i+1][j]>0 ) posibilidadDeMina += (double)(mapa [i+1][j]-MinasAlrededor(i+1,j)) / mapa [i+1][j];
    if (ValidarCelda(i,j-1,gridX,gridY) && mapa [i][j-1]>0 ) posibilidadDeMina += (double)(mapa [i][j-1]-MinasAlrededor(i,j-1)) / mapa [i][j-1];
    if (ValidarCelda(i,j+1,gridX,gridY) && mapa [i][j+1]>0 ) posibilidadDeMina += (double)(mapa [i][j+1]-MinasAlrededor(i,j+1)) / mapa [i][j+1];
    if (ValidarCelda(i-1,j-1,gridX,gridY) && mapa [i-1][j-1]>0 ) posibilidadDeMina += (double)(mapa [i-1][j-1]-MinasAlrededor(i-1,j-1)) / mapa [i-1][j-1];
    if (ValidarCelda(i+1,j+1,gridX,gridY) && mapa [i+1][j+1]>0 ) posibilidadDeMina += (double)(mapa [i+1][j+1]-MinasAlrededor(i+1,j+1)) / mapa [i+1][j+1];
    if (ValidarCelda(i+1,j-1,gridX,gridY) && mapa [i+1][j-1]>0 ) posibilidadDeMina += (double)(mapa [i+1][j-1]-MinasAlrededor(i+1,j-1)) / mapa [i+1][j-1];
    if (ValidarCelda(i-1,j+1,gridX,gridY) && mapa [i-1][j+1]>0 ) posibilidadDeMina += (double)(mapa [i-1][j+1]-MinasAlrededor(i-1,j+1)) / mapa [i-1][j+1];
    return posibilidadDeMina;
  }
  int MinasDescubiertas(){
    int count = 0;
    for(int i = 0; i < gridY; i++){
          for(int j = 0; j < gridX; j++){
            if(mapa[i][j]==-1) count++;
          }          
    }
    return count;
  }
  int CartasCerradas(){
    int count = 0;
    for(int i = 0; i < gridY; i++){
          for(int j = 0; j < gridX; j++){
            if(mapa[i][j]==-2) count++;
          }          
    }
    return count;
  }
  
  //ACCIONES
  boolean AsigmanrMina(int i, int j){
    boolean cambios = false;
     mapa[i][j] = -1;
     if(tablero.ClickDerecho(i,j)) cambios = true;
    return cambios;
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
    if (ValidarCelda(i-1,j,gridX,gridY) &&   mapa [i-1][j] != -1) if(tablero.Click(i-1,j)) { mapa[i-1][j] = tablero.GetCelda(i-1, j); cambios = true; }
    if (ValidarCelda(i+1,j,gridX,gridY) &&   mapa [i+1][j] != -1) if(tablero.Click(i+1,j)) { mapa[i+1][j] = tablero.GetCelda(i+1, j); cambios = true; }
    if (ValidarCelda(i,j-1,gridX,gridY) &&   mapa [i][j-1] != -1) if(tablero.Click(i,j-1)) { mapa[i][j-1] = tablero.GetCelda(i, j-1); cambios = true; }
    if (ValidarCelda(i,j+1,gridX,gridY) &&   mapa [i][j+1] != -1) if(tablero.Click(i,j+1)) { mapa[i][j+1] = tablero.GetCelda(i, j+1); cambios = true; }
    if (ValidarCelda(i-1,j-1,gridX,gridY) && mapa [i-1][j-1] != -1) if(tablero.Click(i-1,j-1)) { mapa[i-1][j-1] = tablero.GetCelda(i-1, j-1); cambios = true; }
    if (ValidarCelda(i+1,j+1,gridX,gridY) && mapa [i+1][j+1] != -1) if(tablero.Click(i+1,j+1)) { mapa[i+1][j+1] = tablero.GetCelda(i+1, j+1); cambios = true; }
    if (ValidarCelda(i+1,j-1,gridX,gridY) && mapa [i+1][j-1] != -1) if(tablero.Click(i+1,j-1)) { mapa[i+1][j-1] = tablero.GetCelda(i+1, j-1); cambios = true; }
    if (ValidarCelda(i-1,j+1,gridX,gridY) && mapa [i-1][j+1] != -1) if(tablero.Click(i-1,j+1)) { mapa[i-1][j+1] = tablero.GetCelda(i-1, j+1); cambios = true; }
    return cambios;
  }
  
  
  //Util
  boolean ValidarCelda(int pY, int pX, int sizeX, int sizeY){
    return (pX<sizeX && pX>=0 && pY<sizeY && pY>=0);
  }
  
};