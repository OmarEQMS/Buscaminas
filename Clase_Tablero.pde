class Tablero {
  //Mapa
  int mapa [][];
  boolean tapados [][];
  boolean banderines [][];
  //Setup
  int gridX, gridY;
  int size, bombas, defX, defY;
  boolean finished; float transparency = 0;
  //Images
  PImage bomba, gameOver, banderin;
  
  Tablero (int y, int x, int b){
    //Setup
    gridX=x; gridY=y; bombas=b; finished = false;
    //Size
    size=((width/gridX)>(height/gridY)) ? (height/gridY) : (width/gridX);
    defX = (width-(gridX*size))/2;
    defY = (height-(gridY*size))/2;
    //Mapa
    mapa= new int  [gridY][gridX]; //-1 bomba, -2 banderin
    tapados = new boolean [gridY][gridX];
    banderines = new boolean [gridY][gridX];
    //Images
    bomba = loadImage ("minesweeper.png");
    gameOver= loadImage( "GO.jpg");
    banderin= loadImage( "banderin.png");
    //Size
    textAlign(CENTER);
    imageMode(CENTER);
    textSize(size);    
    bomba.resize (size,size);
    banderin.resize (size,size);
    //Init
    setupTablero();
  }
  
  //Params to Jugador
  public int GetCelda(int y, int x){
    if(banderines[y][x]==true) return -1;
    if(tapados[y][x]==true) return -2;
    if (!ValidarCelda(y,x,gridX,gridY)) return -2;
    return mapa[y][x];
  }
  public int GetGridX(){ return gridX; }
  public int GetGridY(){ return gridY; }
  public int GetBombas(){ return bombas; }
  
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
        banderines [i][j] = false;
      }
    }
  }
  void IniciarBombas() {
    int x,y;
    for (int i =0;i<bombas;i++) {
      do {
        x= floor(random(gridX));
        y= floor(random(gridY));
      }while(mapa [y][x] == -1);
      mapa [y][x] = -1;
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
    tint(255, 255);
    
    int celda;
    for(int i = 0; i < gridY; i++){
      for(int j = 0; j < gridX; j++){
        if (tapados [i][j] == true){
          if(banderines[i][j]==true) {  //Banderin
            fill (150,150,150);
            rect(defX + (j*size), defY + (i*size), size, size);
            fill(0,0,0);
            image(banderin, defX+(j*size) + size/2,defY + (i*size) + size/2);
          }else{
            fill (100,100,100);
            rect(defX + (j*size), defY + (i*size), size, size);
          }
        }else{
          celda = mapa [i][j];          
          if (celda > 0){  //Numero
            fill (150,150,150);
            rect(defX + (j*size), defY + (i*size), size, size);
            switch (celda){            
              case 1: fill (0,0,255); break;
              case 2: fill (0,255,0); break;
              case 3: fill (255,0,0); break;
              default: fill (135,0,0); break;
            }
            text (mapa[i][j], defX + (j*size) + size/2,defY + (i*size) + size);
          }else if(celda==0) { //Cero
            fill (150,150,150);
            rect(defX + (j*size), defY + (i*size), size, size);
          }else if(celda==-1) {  //Bomca
            fill(0,0,0);
            image(bomba, defX + (j*size) + size/2,defY + (i*size) + size/2);
          }  
        }   
      }
    }
    
    if (finished==true) {
      tint(255, transparency);
      if(transparency < 100) transparency += 1;
      image(gameOver, width/2,height/2,width,height);      
    } 
  }
  
  //Click
  public void ClickMouse (int y, int x){
    x = x - defX; y = y - defY;
    x = x/size; y = y/size;
    Click(y,x);
  }
  public void ClickMouseDerecho (int y, int x){
    x = x - defX; y = y - defY;
    x = x/size; y = y/size;
    ClickDerecho(y,x);
  }
  public boolean Click (int y, int x){
    if (finished==true) return false;
    if (!ValidarCelda(y,x,gridX,gridY)) return false;
    if (tapados [y][x] == false) return false;
    
    tapados [y][x] = false;
    if (mapa [y][x]==-1) {      
      finished = true; //Game OVer
      return false;
    }else{
      if (mapa[y][x] == 0) descubreCeros(y,x);
      return true;
    }
  }
  public boolean ClickDerecho (int y, int x){
    if (finished==true) return false;
    if (!ValidarCelda(y,x,gridX,gridY)) return false;
    if (tapados [y][x] == false) return false;
    if (banderines[y][x]==true) return false;
    
    banderines[y][x] = true;
    return true;
  }
  void descubreCeros (int i,int j) {
    if (mapa [i][j]==0) {
      tapados [i][j] = false;        
      if (ValidarCelda(i+1,j,gridX, gridY) && tapados [i+1][j]==true && mapa [i+1][j] ==0) descubreCeros (i+1,j);
      if (ValidarCelda(i,j+1,gridX, gridY) && tapados [i][j+1]==true && mapa [i][j+1]==0) descubreCeros (i,j+1);
      if (ValidarCelda(i,j-1,gridX, gridY) && tapados [i][j-1]==true && mapa [i][j-1]==0) descubreCeros (i,j-1);
      if (ValidarCelda(i-1,j,gridX, gridY) && tapados [i-1][j]==true && mapa [i-1][j]==0) descubreCeros (i-1, j);
    }
  }

  boolean ValidarCelda(int pY, int pX, int sizeX, int sizeY){
    return (pX<sizeX && pX>=0 && pY<sizeY && pY>=0);
  }

}