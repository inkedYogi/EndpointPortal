class Item extends Entity {
    hyp constituents; 
    
    Item(int manaCost, PVector emojiTag, WorldModifier parent, float angle, hyp comp) { 
        super(manaCost, emojiTag, parent, angle);
        constituents = comp;
    }    
    void init() {     }    
    void update() {}    
    void disp() {}
}