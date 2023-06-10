class Quest {
    String name;
    LocalSection questSection;
    
    Quest(String name) {
        this.name = name;
        this.questSection = new LocalSection();
    }
    
    void addQuestFactoid(Factoid fact) {
        questSection.addFactoid(fact);
    }
    
    void updateQuestFactoid(String factoidId, boolean completed) {
        Factoid fact = questSection.getFactoidById(factoidId);
        if(fact != null) {
            fact.setCompleted(completed);
        }
    }
    
    float calculateProgress() {
        int completedFactoids = 0;
        for(Factoid fact : questSection.getFactoids()) {
            if(fact.isCompleted()) {
                completedFactoids++;
            }
        }
        
        return(float) completedFactoids / questSection.getFactoids().size();
    }
    
    void printProgress() {
        float progress = calculateProgress();
        System.out.println("Quest " + name + " progress: " + (progress * 100) + "%");
    }
}