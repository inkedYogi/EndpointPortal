class Factoid {
    private String address;        // Address to uniquely identify the factoid within the WorldModifier structure
    private String type;           // Type of factoid (e.g. "Location", "Goal", "Side-Quest")
    private String description;    // Description of the factoid
    private int timeStamp;         // Carries the cycle number of when this factoid was last updated, in case changes are made
    private boolean discovered;    // Whether the factoid has been discovered by the player or not
    private boolean completed;     // Whether the factoid has been completed or not
    private ArrayList<String> relatedFactoidAddresses;  // A list of addresses of related factoids that may provide additional information
    private String priority;       // Priority of factoid (e.g., "CRITICAL", "MODERATE", "LOW", "DECORATIVE")
    
    Factoid(String address, String type, String description, int currentCycle) {
        this.address = address;
        this.type = type;
        this.description = description;
        this.timeStamp = currentCycle;
        this.discovered = false;
        this.completed = false;
        this.relatedFactoidAddresses = new ArrayList<String>();
        this.priority = "MODERATE"; // Default priority, can be changed based on requirements
    }
    
    void discover() {
        discovered = true;
    }
    
    boolean isCompleted() {
        return completed;
    }
    
    void setCompleted(boolean completed) {
        this.completed = completed;
    }
    
    void addRelatedFactoidAddress(String relatedFactoidAddress) {
        relatedFactoidAddresses.add(relatedFactoidAddress);
    }
    
    ArrayList<String> getRelatedFactoidAddresses() {
        return relatedFactoidAddresses;
    }
    
    String getPriority() {
        return priority;
    }
    
    void setPriority(String priority) {
        this.priority = priority;
    }
    
    String getAddress() {
        return address;
    }
}