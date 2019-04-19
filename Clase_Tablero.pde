class Tablero {
  int gridX, gridY;
  int size,bombas;
  int defX, defY;
  int mapa [][];
  boolean tapados [][];
  PImage bomba;
  Tablero (){
     gridX=8;
     gridY=8;
     size=((width/gridX)>(height/gridY)) ? (height/gridY) : (width/gridX);
     bombas=10;
     defX = (width-(gridX*size))/2;
     defY = (height-(gridY*size))/2;
     mapa= new int  [gridX][gridY];
     tapados = new boolean [gridX][gridY];
  }
  
  void setupTablero() {    
    IniciarBombas();
    IniciarNumeros();
    bomba = loadImage ("minesweeper.png");
    bomba.resize (32,32);
    System.out.print("\n");
    ImprimeMapa();
  }
  void drawTablero () {
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
  void IniciarBombas() {
   
    Random rand = new Random ();
    for(int i = 0; i < gridX; i++){
      for(int j = 0; j < gridY; j++){
        mapa [i][j]= 0;
        tapados [i][j] = true;
      }
    }
    int x,y;
    for (int i =0;i<bombas;i++) {
      x= rand.nextInt(gridX);
      y= rand.nextInt(gridY);
      while (mapa [x][y] == -1) {
        x= rand.nextInt(gridX);
        y= rand.nextInt(gridY);
      }
      mapa [x][y]= -1;
    }
  }
  void IniciarNumeros() {
    int vecinos;
    for(int i = 0; i < gridX; i++){
      for(int j = 0; j < gridY; j++){
        if (mapa[i][j] == 0 ) {
          vecinos = 0;
          if (i>0 && mapa [i-1][j] ==-1) 
            vecinos++;
          if (i<gridX-1 && mapa [i+1][j] ==-1) 
            vecinos++;
          if (j>0 && mapa [i][j-1] ==-1) 
            vecinos++;
          if (j<gridY-1 && mapa [i][j+1] ==-1) 
            vecinos++;
          if (i>0 && j>0 && mapa [i-1][j-1] ==-1) 
            vecinos++;
          if (i<gridX-1 && j<gridX-1&& mapa [i+1][j+1] ==-1) 
            vecinos++;
          if (j>0 && i<gridX-1 &&  mapa [i+1][j-1] ==-1) 
            vecinos++;
          if (i>0 && j<gridY-1 && mapa [i-1][j+1] ==-1) 
            vecinos++;
          mapa [i][j]= vecinos;
        }
      }
    }
  }
  void ImprimeMapa(){
    for(int i = 0; i < gridX; i++){
      for(int j = 0; j < gridY; j++){
         System.out.print( mapa[i][j] + " ");
      }
      System.out.print("\n");
    }
  }
  void descubreCeros (int i,int j) {
                                                                            //DESCUBRIR CEROS
  }
  public boolean Click (int x, int y){
    if (x<gridX && y<gridY){
      tapados [x][y] = false;
      if (mapa [x][y]==-1) 
        return false;
        else 
          return true;
    } 
    return false;                                                                  //Falta implementar que cuando sea 0 se quiten todos los adyacentes
  }
  public boolean [][] getTapados  (){
    return tapados;
  }
}
