class LocalSection implements KnowledgeSheaf {
    ArrayList<Factoid> factoids;  // Stores the factoids within the local section
    
    LocalSection() {
        factoids = new ArrayList<Factoid>();
    }
    
    public ArrayList<Factoid> getFactoids() {
        return factoids;
    }
    
    void addFactoid(Factoid factoid) {
        factoids.add(factoid);
    }
    
    void removeFactoid(Factoid factoid) {
        factoids.remove(factoid);
    }
    
    boolean containsFactoid(String factoidAddress) {
        for (Factoid factoid : factoids) {
            if (factoid.getAddress().equals(factoidAddress)) {
                return true;
            }
        }
        return false;
    }
    
    void shareFactoid(LocalSection targetSheaf, String factoidAddress) {
        if (containsFactoid(factoidAddress) && !targetSheaf.containsFactoid(factoidAddress)) {
            for (Factoid factoid : factoids) {
                if (factoid.getAddress().equals(factoidAddress)) {
                    targetSheaf.addFactoid(factoid);
                    break;
                }
            }
        }
    }
    
    void shareFactoids(LocalSection targetSheaf) {
        for (Factoid factoid : factoids) {
            targetSheaf.addFactoid(factoid);
        }
    }
    
    ArrayList<String> filterFactoidAddresses(ArrayList<String> inputFactoidAddresses) {
        ArrayList<String> filteredFactoidAddresses = new ArrayList<String>();
        for (String factoidAddress : inputFactoidAddresses) {
            if (containsFactoid(factoidAddress)) {
                filteredFactoidAddresses.add(factoidAddress);
            }
        }
        return filteredFactoidAddresses;
    }
    
    ArrayList<String> findUniqueFactoidAddresses(ArrayList<String> inputFactoidAddresses) {
        ArrayList<String> uniqueFactoidAddresses = new ArrayList<String>();
        
        for (String factoidAddress : inputFactoidAddresses) {
            if (!containsFactoid(factoidAddress)) {
                uniqueFactoidAddresses.add(factoidAddress);
            }
        }
        
        return uniqueFactoidAddresses;
    }
    
    void merge(LocalSection otherSheaf) {
        ArrayList<String> otherSheafAddresses = new ArrayList<String>();
        for (Factoid factoid : otherSheaf.factoids) {
            otherSheafAddresses.add(factoid.getAddress());
        }

        ArrayList<String> uniqueFactoidAddresses = findUniqueFactoidAddresses(otherSheafAddresses);

        for (String factoidAddress : uniqueFactoidAddresses) {
            for (Factoid factoid : otherSheaf.factoids) {
                if (factoid.getAddress().equals(factoidAddress)) {
                    addFactoid(factoid);
                    break;
                }
            }
        }
    }
}
