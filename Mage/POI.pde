class POI {
    String name;
    PVector location;
    String type;   // GreatTree, City, Ruin, Other
    String subType; // StandAlone, ForestGenerating, InvasiveGiant, etc
    ArrayList<Factoid> factoids;
    ArrayList<POI> connectedPOIs;
    
    POI() {
        name = "";
        location = new PVector();
        type = "";
        subType = "";
        factoids = new ArrayList<Factoid>();
        connectedPOIs = new ArrayList<POI>();
    }
    
    void update() {
        // Update the POI object
    }
    
    void disp() {
        // Display the POI object
    }
    
    void addConnection(POI poi) {
        // Connect a poi to it's long distance neighbor
    }
}
