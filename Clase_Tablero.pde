class Tablero {
  //Mapa
  int mapa [][];
  boolean tapados [][];
  //Setup
  int gridX, gridY;
  int size, bombas, defX, defY;
  boolean finished; float transparency = 0;
  //Images
  PImage bomba, gameOver;
  
  Tablero (int x, int y, int b){
    //Setup
    gridX=x; gridY=y; bombas=b; finished = false;
    //Size
    size=((width/gridX)>(height/gridY)) ? (height/gridY) : (width/gridX);
    defX = (width-(gridX*size))/2;
    defY = (height-(gridY*size))/2;
    //Mapa
    mapa= new int  [gridX][gridY];
    tapados = new boolean [gridX][gridY];
    //Images
    bomba = loadImage ("minesweeper.png");
    gameOver= loadImage( "GO.jpg");
    bomba.resize (32,32);
    //Init
    setupTablero();
  }
  
  //INIT
  void setupTablero() {   
    InicirTablero();
    IniciarBombas();
    IniciarNumeros();
    ImprimeMapa();
  }
  void InicirTablero(){
    for(int i = 0; i < gridY; i++){
      for(int j = 0; j < gridX; j++){
        mapa [i][j]= 0;
        tapados [i][j] = true;
      }
    }
  }
  void IniciarBombas() {
    int x,y;
    for (int i =0;i<bombas;i++) {
      do {
        x= floor(random(gridX));
        y= floor(random(gridY));
      }while(mapa [x][y] == -1);
      mapa [x][y] = -1;
    }
  }
  void IniciarNumeros() {
    int vecinos;
    for(int i = 0; i < gridY; i++){
      for(int j = 0; j < gridX; j++){
        if (mapa[i][j] == 0 ) {
          vecinos = 0;
          if (ValidarCelda(i-1,j,gridX,gridY) &&   mapa [i-1][j] ==-1) vecinos++;
          if (ValidarCelda(i+1,j,gridX,gridY) &&   mapa [i+1][j] ==-1) vecinos++;
          if (ValidarCelda(i,j-1,gridX,gridY) &&   mapa [i][j-1] ==-1) vecinos++;
          if (ValidarCelda(i,j+1,gridX,gridY) &&   mapa [i][j+1] ==-1) vecinos++;
          if (ValidarCelda(i-1,j-1,gridX,gridY) && mapa [i-1][j-1] ==-1) vecinos++;
          if (ValidarCelda(i+1,j+1,gridX,gridY) && mapa [i+1][j+1] ==-1) vecinos++;
          if (ValidarCelda(i+1,j-1,gridX,gridY) && mapa [i+1][j-1] ==-1) vecinos++;
          if (ValidarCelda(i-1,j+1,gridX,gridY) && mapa [i-1][j+1] ==-1) vecinos++;
          mapa [i][j]= vecinos;
        }
      }
    }
  }
  void ImprimeMapa(){
    print("\n");
    for(int i = 0; i < gridY; i++){
      for(int j = 0; j < gridX; j++){
         print( mapa[i][j] + " ");
      }
      print("\n");
    }
  }
  
  //Draw
  void drawTablero () {     
    int celda;
    for(int i = 0; i < gridY; i++){
      for(int j = 0; j < gridX; j++){
        if (tapados [i][j] == true){
          fill (100,100,100);
          rect(defX + (i*size), defY + (j*size), size, size);
        }else{
          celda = mapa [i][j];          
          if (celda > 0){  //Numero
            fill (150,150,150);
            rect(defX + (i*size), defY + (j*size), size, size);
            switch (celda){            
              case 1: fill (0,0,255); break;
              case 2: fill (0,255,0); break;
              case 3: fill (255,0,0); break;
              default: fill (135,0,0); break;
            }
            text (mapa[i][j], defX+15 + (i*size),defY + (j*size)+50);
          }else if(celda==0) { //Cero
            fill (150,150,150);
            rect(defX + (i*size), defY + (j*size), size, size);
          }else if(celda==-1) {  //Bomca
            fill(0,0,0);
            image(bomba, defX + 10+(i*size),defY + (j*size)+10);
          }            
        }   
      }
    }
    
    if (finished==true) {
      tint(255, transparency);
      if(transparency < 255) transparency += 1;
      image(gameOver, 0,0,width,height);      
    } 
  }
  
  //Click
  public void ClickMouse (int x, int y){
    x = x - defX; y = y - defY;
    x = x/size; y = y/size;
    Click(x,y);
  }
  public boolean Click (int x, int y){
    if (finished==true) return false;
    if (!ValidarCelda(x,y,gridX,gridY)) return false;
    if (tapados [x][y] == false) return false;
    
    tapados [x][y] = false;
    if (mapa [x][y]==-1) {      
      finished = true; //Game OVer
      return false;
    }else{
      if (mapa[x][y] == 0) descubreCeros(x,y);
      return true;
    }
  }
  void descubreCeros (int i,int j) {
    if (mapa [i][j]==0) {
      tapados [i][j] = false;      
    } 
    if (ValidarCelda(i+1,j,gridX, gridY) && tapados [i+1][j]==true && mapa [i+1][j] ==0) descubreCeros (i+1,j);
    if (ValidarCelda(i,j+1,gridX, gridY) && tapados [i][j+1]==true && mapa [i][j+1]==0) descubreCeros (i,j+1);
    if (ValidarCelda(i,j-1,gridX, gridY) && tapados [i][j-1]==true && mapa [i][j-1]==0) descubreCeros (i,j-1);
    if (ValidarCelda(i-1,j,gridX, gridY) && tapados [i-1][j]==true && mapa [i-1][j]==0) descubreCeros (i-1, j);
  }

  boolean ValidarCelda(int pX, int pY, int sizeX, int sizeY){
    return (pX<sizeX && pX>=0 && pY<sizeY && pY>=0);
  }
  
}