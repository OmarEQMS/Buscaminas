void IniciarBombas() {
 
  Random rand = new Random ();
  for(int i = 0; i < gridX; i++){
    for(int j = 0; j < gridY; j++){
      mapa [i][j]= 0;
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
