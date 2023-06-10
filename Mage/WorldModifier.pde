abstract class WorldModifier {
    int manaCost;
    PVector emojiTag;
    ArrayList<WorldModifier> children;
    WorldModifier parent;
    LocalSection localSheaf;
    String address;
    NTree subQuests;
    Ability unlockedAbility;
    boolean questCompleted;
    ArrayList<String> availableActions;
    
    WorldModifier(int manaCost, PVector emojiTag, WorldModifier parent) {
        this.manaCost = manaCost;
        this.emojiTag = emojiTag;
        this.children = new ArrayList<WorldModifier>();
        this.parent = parent;
        this.subQuests = new NTree(); //needs parameters set, otherwise intitiallizes to just 1 node
        this.questCompleted = false;
        this.MainQuest();
        this.localSheaf = new LocalSection();
        this.availableActions = new ArrayList<String>();
        this.address = (parent == null) ? "1" : parent.address + "." + (parent.children.size() + 1);
        if(this.parent != null) {
            this.parent.children.add(this);
            this.parent.manaCost -= this.manaCost;
        }
    }
    
    void destroy() {
        if(this.parent != null) {
            this.parent.children.remove(this);
            this.parent.manaCost += this.manaCost;
        }
    }
    
    WorldModifier getNodeByAddress(String address) {
        String[]parts = address.split("\\.");
        WorldModifier node = this;
        for(String part : parts) {
            int index = Integer.parseInt(part) - 1;  // subtract 1 because addresses are 1-based
            if(index < 0 || index >= node.children.size()) {
                return null;  // address is out of range
            }
            node = node.children.get(index);
        }
        return node;
    }

    void requestUnfoldLayer(String nodeAddress) {
        GameManager.getInstance().unfoldLayerAtAddress(nodeAddress);
    }
    
    void addFactoid(Factoid factoid) {
        localSheaf.addFactoidAddress(factoid.address);
        if(parent != null) {
            parent.addFactoid(factoid);
        }
    }
    
    void createSubQuest() {
        //Initialize subQuests, unlockedAbility, relatedFactoids, factoid trigger links?
    }
    
    void completeQuests() {
        // Player gains the unlocked ability after all subquests are complete
        this.questCompleted = true;
    }
    
    abstract void modify(World world);
    abstract void analyze(World world);
    abstract ArrayList<String> reportAvailableActions();
}

/*
abstract class WorldModifier {
int manaCost;
PVector emojiTag;
ArrayList<WorldModifier> children;
WorldModifier parent;
LocalSection localSheaf;
String address;
NTree subQuests;
Ability unlockedAbility;
boolean questCompleted;

WorldModifier(int manaCost, PVector emojiTag, WorldModifier parent);
void destroy();
WorldModifier getNodeByAddress(String address);
void addFactoid(Factoid factoid);
void createSubQuest();
void changeMode(GameMode mode);
void completeQuests();
abstract void modify(World world);
abstract void analyze(World world);
abstract ArrayList<String> reportAvailableActions();
}
*/