class TravelMode extends GameMode {
    // Other attributes and methods specific to Travel mode
    
    void initialize() {
        modeName = "Travel";
        currentHud = new HUD();
        currentHud.travelElements();
    }
    
    void update() {
        // Update Travel mode logic
    }
    
    void draw() {
        // Draw Travel mode visuals
    }
}