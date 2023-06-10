class GameManager{ 
    int seed; // World Seed value from World Generator
    NTree gameTree;
    Morpher morpher; 
    World gameWorld;
    // Party caravan;    
    ModeManager modeManager;
    // GameMode currentMode;   //town, trade, travel, camp, dungeon
    
    // Data tables
    // Table itemData;
    String[] worldLog;
    Table names;
    Table mounts;
    Table vehicles;
    Table emotions;
    Table DRM;
    Table FRM;
    Table LCM;
    Table RLM;
    Table biomes;
    Table Portal_Map;
    Table resources;
    Table resourceData;
    Table resourceRarity;
    Table places;
    Table townData;
    Table BookReqs;
    Table POIs;
    
    GameManager(int S) {
        seed = S;  
        modeManager = new ModeManager();  
        gameTree = new NTree();
        morpher = new Morpher();
        gameWorld = new World();
        // caravan = new Caravan();   
    }
    
    void init() {    
        // caravan.makeRandom((int)random(5,10),(int)random(1,5));  //makesRandomCaravan(npcs, vehicles)
        // caravan.spawn(world.selectedTile);                                  //spawn in the player
        modeManager.setMode("scene");
        // loadLists(); 
        if(debug) println("woo_hoo load a bunch of lists!");
        // follow worldlog instructions.
        morpher.unfoldLayer(gameTree.root);
        // world.update();
    }
    
    void loadLists() {
        // Load data from the SocialMaps subfolder
        names = loadTable("data/SocialMaps/names.csv", "header");
        mounts = loadTable("data/SocialMaps/mounts.csv", "header");
        vehicles = loadTable("data/SocialMaps/vehicles.csv", "header");
        emotions = loadTable("data/SocialMaps/emotions.csv", "header");
        DRM = loadTable("data/SocialMaps/DRM.csv", "header");
        FRM = loadTable("data/SocialMaps/FRM.csv", "header");
        LCM = loadTable("data/SocialMaps/LCM.csv", "header");
        RLM = loadTable("data/SocialMaps/RLM.csv", "header");
        
        // Load data from the WorldMaps subfolder
        biomes = loadTable("data/WorldMaps/biomes.csv", "header");
        Portal_Map = loadTable("data/WorldMaps/Portal_Map.csv", "header");
        worldLog = loadStrings("data/WorldMaps/" + seed + "/common/worldLog.txt");
        POIs = loadTable("data/WorldMaps/" + seed + "/common/poi.txt");
        
        // Load data from the TradeMaps subfolder
        resources = loadTable("data/TradeMaps/resources.csv", "header");
        resourceData = loadTable("data/TradeMaps/resourceData.csv", "header");
        resourceRarity = loadTable("data/TradeMaps/resourceRarity.csv", "header");
        // itemData = loadTable("ItemData.csv","header");
        
        // Load data from the TownMaps subfolder
        places = loadTable("data/TownMaps/places.csv", "header");
        String[] places = loadStrings("places.txt");
        townData = loadTable("data/TownMaps/townData.csv", "header");
        
        // Load data from the SpellBook subfolder
        BookReqs = loadTable("data/SpellBook/BookReqs.csv", "header");

    }
    
    void gameLoop() {// Main game loop
        update();
        disp();
        readyNext();        
    }
    
    void update() {
        // Call methods on the gameTree and morpher to update the game world
        gameTree.update();
    }  
    
    void disp() {
        // Call methods on the gameTree to display the game world
        gameTree.disp();
    }
    
    void readyNext() {
        // TableRow dest = townData.findRow(caravan.destination,"townName");
        // float aspect = dest.getFloat("W:H");
        // println("found " + caravan.destination + " with aspect ratio " + aspect + ".");
        // nextImage = loadImage("towns/" + caravan.destination + ".jpg");
        // nextImage.resize(int(width * aspect),height);
        // towns.add(new Town(caravan.destination));        
    }
    
   // void generateMainNarrative(ArrayList<POI> pois) {
        // Generate the factoid links necessary for the main narrative
        // This could involve iterating over the list of POIs and adding factoids to each one
        // The factoids could be pre-defined, or they could be generated based on the properties of the POI
   // }
    
    void unfoldLayerAtAddress(int[] nodeAddress) {
        // Get the node at the given address
        Node node = helper.getNodeByAddress(gameTree, nodeAddress);
        // If the node exists, unfold the layer
        if(node != null) {
            morpher.unfoldLayer(node);
        }
    }
    
    // void generateMainNarrative(ArrayList<POI> pois) {
    //     // The first POI in the list is the special high point of the world
    //     POI highPoint = pois.get(0);
        
    //     // Create a Node for the high point
    //     Node highPointNode = new Node();
    //     morpher.addNode(highPointNode);
        
    //     // Create Nodes for each other POI
    //     for(int i = 1; i < pois.size(); i++) {
    //         POI poi = pois.get(i);
    //         Nodenode = new Node(poi);
    //         gameTree.addNode(node);
            
    //         // Create a Link from the high point to this Node
    //         Linklink = new Link(highPointNode, node);
            
    //         // Add a Factoid to the Link
    //         Factoid factoid = generateFactoid(highPointNode, node);
    //         link.addFactoid(factoid);
            
    //         gameTree.addLink(link);
    //     }
        
    //     // Create additional Links based on narrative structure
    //     for(Node node : gameTree.getNodes()) {
    //         // Skip the high point, since we've already created its Links
    //         if(node.equals(highPointNode)) continue;
            
    //         // Get the POIs that this Node is connected to in the narrative
    //         ArrayList<POI> connectedPois = getConnectedPois(node.getPoi());
            
    //         // Create a Link to each connected POI
    //         for(POI connectedPoi : connectedPois) {
    //             NodeconnectedNode = gameTree.getNodeByPoi(connectedPoi);
                
    //             // Skip if we've already created this Link
    //             if(gameTree.hasLink(node, connectedNode)) continue;
                
    //             Linklink = new Link(node, connectedNode);
                
    //             // Add a Factoid to the Link
    //             Factoid factoid = generateFactoid(node, connectedNode);
    //             link.addFactoid(factoid);
                
    //             gameTree.addLink(link);
    //         }
    //     }
    // }
    
    void useMorpher(Object entity1, Object entity2) {
        if(morpher.isRelated(entity1, entity2)) {
            // Do something with the related entities
        } else{
            // Do something else if not related
        }
    }   
    
    
    void changeMode(GameMode mode) {
        // Change the game mode with a scene in between
    }
    
    void mousePressed() {
        modeManager.mousePressed(mouseX, mouseY);
    }   
    
    void mouseDragged() {
        modeManager.mouseDragged(mouseX, mouseY);
    }
    
    void mouseReleased() {
        modeManager.mouseReleased();
    }
    
    void keyPressed() {
        modeManager.keyPressed();
    }
    
    void keyReleased() {
        // caravan.keyReleased();
    }
}
// ArrayList<Town> towns;  //added in the order visited
// ArrayList<Trader> traders; //added in the order visited
// ArrayList<QuestGiver> questGivers; //added in the order visited
// String[] resources, names, biomes, vehicles, mounts, places;
// PImage currentImage, nextImage;

// world.selectTile(world.subgridSq / 2, world.subgridSq / 2);            //selectedTile starts in screen coordinates
// world.selectedTile.loc = world.selectedTile.worldCoordinates();    //selectedTile changing its own coordinate system into worldCoordinates
// println("selectedTile: " + world.selectedTile.loc);        

// towns = new ArrayList<Town>();
// traders = new ArrayList<Trader>();
// questGivers = new ArrayList<QuestGiver>();

// towns.add(new Town("Unnamed"));
// // towns.get(0).dispDeets();
// // currentImage.resize(width, height);   

// if(caravan.walking)  if(frameCount % 6 ==  0) { 
//         caravan.takeStep();
//         world.update();
// }
// 

/*
class GameManager {
World world;
Party caravan;
ModeManager modeManager;
Table biomeData;
Table townData;
Morpher morph;

GameManager();
void init();
void loadLists();
void readyNext();
void disp();
void generateMainNarrative(ArrayList<POI> pois);
void useMorpher(Object entity1, Object entity2);
void mousePressed();
void mouseDragged();
void mouseReleased();
void keyPressed();
void keyReleased();
}
*/