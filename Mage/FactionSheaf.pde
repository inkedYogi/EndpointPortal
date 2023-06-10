class FactionSheaf extends LocalSection {
    ArrayList<Denizen> members;
    HashMap<String, Object> sharedResources;    //safehouses, private markets, warehouses, etc. shared only by members of the faction
    
    FactionSheaf() {
        super();
        members = new ArrayList<Denizen>();
        sharedResources = new HashMap<String, Object>();
    }
    
    void addMember(Denizen denizen) {
        members.add(denizen);
    }
    
    void removeMember(Denizen denizen) {
        members.remove(denizen);
    }
    
    boolean isMember(Denizen denizen) {
        return members.contains(denizen);
    }
    
    void addSharedResource(String resourceName, Object resource) {
        sharedResources.put(resourceName, resource);
    }
    
    Object getSharedResource(String resourceName) {
        return sharedResources.get(resourceName);
    }
}