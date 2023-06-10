class Entity extends WorldModifier {
    float phaseAngle;
    
    Entity(int manaCost, PVector emojiTag, WorldModifier parent, float angle) {
        super(manaCost, emojiTag, parent);
        phaseAngle = angle;
    }
    
    void init() {}
    void update() {}
    void disp() {}
    void modify(World world){}
    void analyze(World world){}
    ArrayList<String> reportAvailableActions(){
        return availableActions;
    }
}