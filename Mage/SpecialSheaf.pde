class SpecialKnowledgeSheaf extends LocalSection {
    ArrayList<Factoid> secretFactoids;
    
    SpecialKnowledgeSheaf() {
        super();
        secretFactoids = new ArrayList<Factoid>();
    }
    
    void addSecretFactoid(Factoid secretFact) {
        secretFactoids.add(secretFact);
    }
    
    void removeSecretFactoid(Factoid secretFact) {
        secretFactoids.remove(secretFact);
    }
    
    ArrayList<Factoid> getSecretFactoids() {
        return secretFactoids;
    }
    
    boolean hasSecretFactoid(Factoid secretFact) {
        return secretFactoids.contains(secretFact);
    }
    
    ArrayList<Factoid> findHiddenFactoids() {
        ArrayList<Factoid> hiddenFactoids = new ArrayList<Factoid>();
        
        for(Factoid fact : secretFactoids) {
            if(!factoids.contains(fact)) {
                hiddenFactoids.add(fact);
            }
        }
        
        return hiddenFactoids;
    }
}