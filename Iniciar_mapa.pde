void IniciarBombas() {
 
  Random rand = new Random ();
  for(int i = 0; i < gridX; i++){
    for(int j = 0; j < gridY; j++){
      mapaBombas [i][j]= false;
    }
  }
  int x,y;
  for (int i =0;i<bombas;i++) {
    x= rand.nextInt(gridX);
    y= rand.nextInt(gridY);
    while (mapaBombas [x][y] == true) {
      x= rand.nextInt(gridX);
      y= rand.nextInt(gridY);
    }
    mapaBombas [x][y]= true;
  }
}
void IniciarNumeros() {
  int vecinos;
  for(int i = 0; i < gridX-1; i++){
    for(int j = 0; j < gridY-1; j++){
      if (mapaBombas[i][j] == false ) {
        vecinos = 0;
        if (i>0 && mapaBombas [i-1][j] ==true) 
          vecinos++;
        if (i<gridX && mapaBombas [i+1][j] ==true) 
          vecinos++;
        if (j>0 && mapaBombas [i][j-1] ==true) 
          vecinos++;
        if (j<gridY && mapaBombas [i][j+1] ==true) 
          vecinos++;
        mapa [i][j]= vecinos;
      }
    }
  }
}
void ImprimeBombas(){
   for(int i = 0; i < gridX; i++){
    for(int j = 0; j < gridY; j++){
       if (mapaBombas [i][j] == false)
         System.out.print(0 + " ");
       else 
         System.out.print(1 + " ");
    }
     System.out.print("\n");
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
