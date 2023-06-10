class World{
    int seed;
    int age;
    PImage[] screen;
    PImage[] maps;
    //{biome map, cost map, resource map, walk map, ride map, water map, fly map}
    PVector worldMap;        //size of the entire world image in pixels
    PVector worldScreen;     //position of the screen in world coordinates
    PVector clickWorld;
    Cell[][] grid;
    Cell[][] subgrid;
    Cell selectedCell;
    int screenIndex;
    int subgridSq = 250;
    float cellRez = 3.75;
    
    World() {
        seed = 0;
        age = 0;
        fillMaps();
        createGrids();
    }
    
    void update() {
        //get the current world map surrounding the player
        worldScreen.x = manager.caravan.currentCell.loc.x - (int)subgridSq / 2;
        worldScreen.y = manager.caravan.currentCell.loc.y - (int)subgridSq / 2;   
        updateSubgrid();
        for(int i = 0; i < maps.length; i++)  screen[i] = getScreen(maps[i], worldScreen);
    }
    
    PImage getScreen(PImage I, PVector V) {  
        //gets the subimage of I with the top left corner at V
        PImage img = I.get(int(V.x), int(V.y), subgridSq, subgridSq);
        return img;
    }
    
    void fillMaps() {
        maps = new PImage[7];
        screen = new PImage[7];
        maps[1] = requestImage("data/" + seed + "/" + age + "/cost map.png"); 
        maps[2] = requestImage("data/" + seed + "/" + age + "/resource map.png"); 
        maps[3] = requestImage("data/" + seed + "/" + age + "/walk map.png");
        maps[4] = requestImage("data/" + seed + "/" + age + "/ride map.png"); 
        maps[5] = requestImage("data/" + seed + "/" + age + "/water map.png");
        maps[6] = requestImage("data/" + seed + "/" + age + "/fly map.png"); 
        maps[0] = loadImage("data/" + seed + "/" + age + "/texture map.png");
        worldMap = new PVector(maps[0].width, maps[0].height);
        println("worldMap: " + worldMap);
        //worldScreen = new PVector(worldMap.x/2- (int)subgridSq/2, worldMap.y/2- (int)subgridSq/2);      //spawn at map center
        worldScreen = new PVector(int(random(worldMap.x / cellRez)), int(random(worldMap.y / cellRez)));  //random spawn point
        int constraint = 500;
        constrain(worldScreen.x, constraint, worldMap.x - constraint);
        constrain(worldScreen.y, constraint, worldMap.y - constraint);
        println("worldScreen:  " + worldScreen);
        screenIndex = 0;
    }
    
    void createGrids() {
        grid = new Cell[(int)worldMap.x][(int)worldMap.y];
        for(int i = 0; i < grid.length; i++)  for(int j = 0; j < grid[0].length; j++) {
                grid[i][j] = new Cell(i, j);
            }
        subgrid = new Cell[subgridSq][subgridSq];
        updateSubgrid();
    }
    
    void updateSubgrid() {
        for(int i = 0; i < subgrid.length; i++)  for(int j = 0; j < subgrid[0].length; j++) {
                int x = i + (int)worldScreen.x;
                int y = j + (int)worldScreen.y;
            subgrid[i][j] = grid[x][y];
        }
    }
    
    void selectCell(Cell T) {
        selectedCell = T;
    }
    
    void selectCell(int U, int V) {
        selectedCell = grid[U][V];
    }
    
    void selectCell(float U, float V) {
        selectedCell = grid[(int)U][(int)V];
    }
    
    void selectCell(Cell[][] G, int X, int Y) {
        selectedCell = G[X][Y];
    }
    
    boolean screenConditions(int X, int Y) {
        if(((X > 0) && (X < subgrid.length - 1)) && ((Y > 0) && (Y < subgrid[0].length - 1)))  return true;  
        return false;
    }
}

/*
class World {
int seed;
int age;
PImage[] screen;
PImage[] maps;
PVector worldMap;
PVector worldScreen;
PVector clickWorld;
Cell[][] grid;
Cell[][] subgrid;
Cell selectedCell;
int screenIndex;
int subgridSq;
float cellRez;

World();
void update();
PImage getScreen(PImage I, PVector V);
void fillMaps();
void createGrids();
void updateSubgrid();
void selectCell(Cell T);
void selectCell(int U, int V);
void selectCell(float U, float V);
void selectCell(Cell[][] G, int X, int Y);
boolean screenConditions(int X, int Y);
}
*/