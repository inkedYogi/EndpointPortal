class Navigator { 
  int[][] navMap;  //holds the index of the order added to nodes in 2d array
  int[][] domain;  //binary one or zero for potential to move to
  int startIndex = -1;  //start Cell
  int endIndex = -1;    //goal Cell

  ArrayList openSet;
  ArrayList closedSet;
  ArrayList nodes;  //Cells
  ArrayList path;   //full path, no diagonal moves allowed
  ArrayList trimmedPath; //path with diagonal moves allowed

  Navigator() {
    openSet = new ArrayList();
    closedSet = new ArrayList();
    nodes = new ArrayList(); 
    path = new ArrayList();
    trimmedPath = new ArrayList();
  }

  void reset() {  
    openSet.clear();
    closedSet.clear();
    path.clear();
    makeDomain();
  }

  void trimPath() {
   trimmedPath.clear();
   int index = 0;
   trimmedPath.add(path.get(0));
   while (index < path.size()-1) {
     Node base = (Node)path.get(index);
     for (int j=path.size()-1; j>index; j--) {
       Node check = (Node)path.get(j);
       float dx = abs(base.pos.x - check.pos.x);
       float dy = abs(base.pos.y - check.pos.y);
       if ((dx==1) && (dy==1)) {
         index = j-1;
         break;
       }
     }
     index++;
     trimmedPath.add(path.get(index));
   }
  }

  void makeDomain() {
    domain = new int[manager.world.subgridSq][manager.world.subgridSq];
    for (int i=0; i<manager.world.subgridSq; i++)  for (int j=0; j<manager.world.subgridSq; j++ ) {
      domain[i][j] = 1;
    }
  }

  void filterDomain(PImage F, int W, int R, int G, int B) {
    F.loadPixels();    
    for (int i=0; i<domain.length; i++)  for (int j=0; j<domain[0].length; j++ ) {
      color c = F.get(i, j);
      if (c == color(255, 255, 255))     domain[i][j] *= W;
      if (c == color(255,   0,   0))     domain[i][j] *= R;
      if (c == color(  0, 255,   0))     domain[i][j] *= G;
      if (c == color(  0,   0, 255))     domain[i][j] *= B; 
      if (c == color(  0,   0,   0))     domain[i][j] *= 0;
    }
  }  

  void loadMap(PImage I) {                                                    //creates a navMap with nodes at cells only in the domain
    int cols = manager.world.subgridSq;                                                     //sets the size of the navgrid
    int rows = manager.world.subgridSq;                                                     //in this case, the small viewing window
    makeDomain();
    navMap = new int[cols][rows];                                                   //creates the matrix
    I.loadPixels();                                                                 //loads the pixels from the image to pixels[]
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++ )  navMap[i][j] = -1;     //for every square in the subgrid set the default to -1
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++ ) {                       //for every square in the subgrid
      if (domain[i][j] == 1) {                                                      //if the domain of the cell is set to 1
        nodes.add(new Node(manager.world.subgrid[i][j]));                                   //include that cell in the navgrid
        navMap[i][j] = nodes.size()-1;                                              //save the index of the nodes array in the navgrid
      }
    }    
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++ ) {                       //for every square in the subgrid
      if (domain[i][j] == 1) {
        int k = i + j*cols;                                                         //find the index of the cell in pixels[]
        float cost = brightness(I.pixels[k]);                                       //determine travel cost to nbr based on pixel brightness
        if (i>0) {                                                                  //with the exception of the first column
          if (navMap[i-1][j]!=-1) {                                                 //if the left adjacent cell in navMap is valid
            Node n2 = (Node)nodes.get(navMap[i][j]);                                //set n2 to be the cell we just included
            n2.addNbor((Node)nodes.get(navMap[i-1][j]), cost);                      //we add the valid cell as a neighbor with a cost
            ((Node)nodes.get(navMap[i-1][j])).addNbor(n2, cost);                    //and we add the reciprocal connection onto that cell
          }
        }    
        if (j>0) {                                                                  //with the exception of the first row
          if (navMap[i][j-1]!=-1) {                                                 //if the up adjacent cell in navMap is valid
            Node n2 = (Node)nodes.get(navMap[i][j]);                                //set n2 to be the cell we just included
            n2.addNbor((Node)nodes.get(navMap[i][j-1]), cost);                      //we add the valid cell as a neighbor with a cost
            ((Node)nodes.get(navMap[i][j-1])).addNbor(n2, cost);                    //and we add the reciprocal connection onto that cell
          }
        }
      }
    }
  }

  float distance(float x1, float y1, float x2, float y2) {
    return sqrt(abs(y2-y1)+abs(x2-x1));
  }

  boolean astar(Cell S, Cell E) {    
    //unwraps iStart and iEnd in terms of screen coordinates
    int s = navMap[(int)S.screenCoordinates().x][(int)S.screenCoordinates().y];
    int e = navMap[(int)E.screenCoordinates().x][(int)E.screenCoordinates().y];
    return astar(s, e);
  }

  boolean astar(int iStart, int iEnd) {       
    //returns true if a path from iStart to iEnd is found, 
    //returns false if there is no path in the navMap
    float endX = ((Node)nodes.get(iEnd)).pos.x;
    float endY = ((Node)nodes.get(iEnd)).pos.y;
    reset();
    //add initial node to openSet
    openSet.add( ((Node)nodes.get(iStart)) );
    ((Node)openSet.get(0)).parentAddress  = -1;
    ((Node)openSet.get(0)).goalAddress  = 0;
    ((Node)openSet.get(0)).heuristicScore = distance( ((Node)openSet.get(0)).pos.x, ((Node)openSet.get(0)).pos.y, endX, endY );

    Node current;
    float tentativeGScore;
    boolean tentativeIsBetter;
    float lowest = 999999999;
    int lowId = -1;

    while ( openSet.size()>0 ) {
      //find the node in openSet with the lowest f (goalAddress +heuristicScore scores) and put its index in lowId
      lowest = 999999999;
      for ( int a = 0; a < openSet.size(); a++ ) {
        if ( ( ((Node)openSet.get(a)).goalAddress +((Node)openSet.get(a)).heuristicScore ) <= lowest ) {
          lowest = ( ((Node)openSet.get(a)).goalAddress +((Node)openSet.get(a)).heuristicScore );
          lowId = a;
        }
      }
      current = (Node)openSet.get(lowId);
      if ( (current.pos.x == endX) && (current.pos.y == endY) ) { //path found
        //follow parents backward from goal
        Node d = (Node)openSet.get(lowId);
        while ( d.parentAddress  != -1 ) {
          path.add( d );
          d = (Node)nodes.get(d.parentAddress );
        }
        return true;
      }
      closedSet.add( (Node)openSet.get(lowId) );
      openSet.remove( lowId );
      for ( int n = 0; n < current.nbors.size(); n++ ) {
        if ( closedSet.contains( (Node)current.nbors.get(n) ) )  continue;
        tentativeGScore = current.goalAddress  + distance( current.pos.x, current.pos.y, ((Node)current.nbors.get(n)).pos.x, ((Node)current.nbors.get(n)).pos.y )*((Float)current.nCost.get(n));
        if ( !openSet.contains( (Node)current.nbors.get(n) ) ) {
          openSet.add( (Node)current.nbors.get(n) );
          tentativeIsBetter = true;
        } else if ( tentativeGScore < ((Node)current.nbors.get(n)).goalAddress  )  tentativeIsBetter = true;
        else  tentativeIsBetter = false;
        if ( tentativeIsBetter ) {
          ((Node)current.nbors.get(n)).parentAddress  = nodes.indexOf( (Node)closedSet.get(closedSet.size()-1) ); //!!!!
          ((Node)current.nbors.get(n)).goalAddress  = tentativeGScore;
          ((Node)current.nbors.get(n)).heuristicScore = distance( ((Node)current.nbors.get(n)).pos.x, ((Node)current.nbors.get(n)).pos.y, endX, endY );
        }
      }
    }
    //no path found
    return false;
  }
}

//Cell {0} -> {selected} -> {targeted} -> {endCell} -> {goal} => {path endpoint}

/*
Fields:
Tile[] nbrhood
ArrayList<Tile> route
boolean navSet

Methods:
void update()
void disp()
void setTarget(Tile T)
boolean navSet()
void updateNbrhood()
*/
