class ModeManager {
    HUD[] headsUpDisplay;  
    HUD currentHud;
    //enum GameMode {COMBAT, TRAVEL, SOCIAL, TRADE, SPELL, SCENE}
    
    CombatMode combatMode;
    TravelMode travelMode;
    TradeMode tradeMode;
    SocialMode socialMode;
    SpellbookMode spellbookMode;
    SceneMode sceneMode;    
    GameMode currentMode;
    
    ModeManager() {
        currentHud = new HUD();
        combatMode = new CombatMode();
        travelMode = new TravelMode();
        tradeMode = new TradeMode();
        socialMode = new SocialMode();
        spellbookMode = new SpellbookMode();
        sceneMode = new SceneMode();  
    }
    
    void setMode(String M) {
        if(M ==  currentMode.modeName)  return; //already there
        else  currentMode.cleanup();
        if(M.equals("scene"))  {
            currentMode.modeName = "scene";
            sceneMode.initialize();
        }
        if(M.equals("combat")) {
            currentMode.modeName = "combat";
            combatMode.initialize();
        }
        if(M.equals("travel")) {
            currentMode.modeName = "travel";
            travelMode.initialize();
        }
        if(M.equals("trade")) {
            currentMode.modeName = "trade";
            tradeMode.initialize();
        }
        if(M.equals("social")) {
            currentMode.modeName = "social";
            socialMode.initialize();
        }
        if(M.equals("spell")) {
            currentMode.modeName = "spell";
            spellbookMode.initialize();
        }
        if(M.equals("scene")) {
            currentMode.modeName = "scene";
            sceneMode.initialize();
        }
    }
    
    void update() {
        if(currentMode != null) {
            currentMode.update();
        }
    }
    
    void draw() {
        if(currentMode != null) {
            currentMode.draw();
        }
    }
    
    void keyPressed() {
        if(key == '`') {
            currentHud.toggleLock();
        }
    }
    
    void mouseReleased() {
        
    }
    
    void mousePressed(float X, float Y) {
        
    }
    
    void mouseDragged(float X, float Y) {
        
    }
}