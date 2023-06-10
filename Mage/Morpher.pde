class Morpher {
    
    void unfoldLayer(Node node) {
        // Get the WorldModifier from the node
        WorldModifier baseModifier = node.enitySlot;
        
        // If the node has no WorldModifier, we can't unfold the layer
        if(baseModifier == null) {
            return;
        }
        
        // For each child of the node
        for(Node child : node.child) {
            // Create a new WorldModifier for the child
            Entity childModifier = new Entity(baseModifier.manaCost, baseModifier.emojiTag, baseModifier, 1.0);
            
            // Add the new WorldModifier to the child
            child.enitySlot = childModifier;
            
            // Unfold the layer for the child
            unfoldLayer(child);
        }
    }
    
    boolean isRelated(Object entity1, Object entity2) {
        // Define trivial morphism that always returns true
        return true;
    }
    /* here is a list of morphisms we might need to model the interaction between different entities in the game:
    "isMemberOf" between Faction and NPC
    "hasQuestFrom" between NPC and SpecialNPC
    "encounteredAt" between Player and GameLocation
    "owns" between Player and GameItem
    "locatedAt" between GameItem and GameLocation
    "isEnemyOf" between Faction and Faction
    "isAllyOf" between Faction and Faction
    "isHostileTo" between NPC and Player
    "isFriendlyTo" between NPC and Player
    "isNeutralTo" between NPC and Player
    "isGuarding" between NPC and GameLocation
    "isPursuing" between NPC and Player
    "isFleeingFrom" between NPC and Player
    "isTalkingTo" between NPC and Player
    "isShopkeeperOf" between NPC and GameLocation
    */
}