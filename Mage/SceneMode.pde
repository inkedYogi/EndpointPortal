class SceneMode extends GameMode {
    Playthrough currentPlaythrough;
    POI currentLocation;
    boolean sceneComplete;

    SceneMode(){
    }
    
    SceneMode(Playthrough playthrough, POI location) {
        currentPlaythrough = playthrough;
        currentLocation = location;
    }
    
    void initialize() {
        currentPlaythrough.initialize();
        currentLocation.initialize();
        sceneComplete = false;
    }
    
    void update() {
        currentPlaythrough.update();
        currentLocation.update();
        if(sceneComplete) {
            prepareNextMode();
        }
    }
    
    void draw() {
        currentPlaythrough.draw();
        currentLocation.draw();
    }
    
    void prepareNextMode() {
        // Add code here to prepare the next game mode
    }
}
