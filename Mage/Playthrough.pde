abstract class Playthrough implements GameMode {
    protected ArrayList<String> unlockedAbilities;
    protected String playerName;
    protected int playerLevel;
    protected int playerExperience;
    protected PlayerSheaf playerKnowledge;
    protected HashMap<String, Object> gameFlags;
    
    Playthrough() {
        unlockedAbilities = new ArrayList<String>();
        playerName = "Unknown";
        playerLevel = 1;
        playerExperience = 0;
        playerKnowledge = new PlayerSheaf();
        gameFlags = new HashMap<String, Object>();
    }
    
    void unlockAbility(String ability) {
        if(!unlockedAbilities.contains(ability)) {
            unlockedAbilities.add(ability);
        }
    }
    
    void addVisitedLocationFactoid(Factoid locationFact) {
        playerKnowledge.addFactoid(locationFact);
    }
    
    void setGameFlag(String flag, Object value) {
        gameFlags.put(flag, value);
    }
    
    Object getGameFlag(String flag) {
        return gameFlags.get(flag);
    }
    
    void updateLocation(POI newLocation) {
        // Update the player's current location
    }
    
    
}