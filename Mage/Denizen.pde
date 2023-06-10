class Denizen {
    PVector position;
    PVector velocity;
    PVector acceleration;
    PVector attributes; // (HP, MP, XP)
    
    Denizen() {
        position = new PVector(0, 0, 0);
        velocity = new PVector(0, 0, 0);
        acceleration = new PVector(0, 0, 0);
        attributes = new PVector(100, 100, 0); // Initial HP, MP, and XP values
    }
    
    ArrayList<Boolean> checkStatus() {
        ArrayList<Boolean> status = new ArrayList<Boolean>();
        
        boolean isDead = attributes.x <= 0;
        boolean isParalyzed = attributes.y <= 0;
        boolean hasLeveledUp = attributes.z >= 100; // Assuming level up occurs at 100 XP
        
        status.add(isDead);
        status.add(isParalyzed);
        status.add(hasLeveledUp);
        
        return status;
    }
}