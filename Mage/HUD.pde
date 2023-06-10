class HUD {
    ArrayList<UI_Element> uiElements;
    boolean isLocked;
    UI_Element activeElement;
    
    HUD() {
        uiElements = new ArrayList<UI_Element>();
        isLocked = true;
        activeElement = null;
    }
    
    void draw() {
        for(UI_Element element : uiElements) {
            element.disp();
        }
    }
    
    void update() {
        for(UI_Element element : uiElements) {
            element.update();
        }
    }
    
    void commonElements() {
        // Create UI elements in general to all modes
    }
    
    void worldViewElements() {
        // Create UI elements specific to WorldView mode
    }
    
    void travelElements() {
        // Create UI elements specific to Travel mode
    }
    
    void campElements() {
        // Create UI elements specific to Camp mode
    }
    
    void battleElements() {
        // Create UI elements specific to Battle mode
    }
    
    void townElements() {
        // Create UI elements specific to Town mode
    }
    
    void spellbookElements() {
        // Create UI elements specific to spellbook mode
    }
    
    void toggleLock() {
        isLocked = !isLocked;
    }
    
    void onMousePressed(int x, int y) {
        if(!isLocked) {
            for(UI_Element element : uiElements) {
                if(element.containsPoint(x, y)) {
                    activeElement = element;
                    break;
                }
            }
        }
    }
    
    void onMouseDragged(int x, int y) {
        if(!isLocked && activeElement != null) {
            activeElement.setPosition(x, y);
        }
    }
    
    void onMouseReleased() {
        activeElement = null;
    }
}

/*
class HUD {
ArrayList<UI_Element> uiElements;
boolean isLocked;
UI_Element activeElement;

HUD();
void draw();
void update();
void commonElements();
void worldViewElements();
void travelElements();
void campElements();
void battleElements();
void townElements();
void spellbookElements();
void toggleLock();
void onMousePressed(int x, int y);
void onMouseDragged(int x, int y);
void onMouseReleased();
}
*/

//push();
// switch(mode) {
//     case"town":
//     cursor(HAND);
//     image(currentImage,width / 2, height / 2);
//     break;
//     case"travel" :
//     cursor(CROSS); 
//     push();
//     translate(width / 2, height / 2);
//     scale(world.cellRez);
//     image(world.screen[world.screenIndex], 0, 0);  //draw the screen
//     push();
//     translate( -caravan.pos.x, -caravan.pos.y);
//     if(caravan.trail)  for(int i = 0;i < caravan.route.size(); i++)  caravan.route.get(i).flash(i);
//     pop();
//     caravan.disp();   //draw the sprites
//     pop();
//     break;
//     case"trade":

//     break;
//     case"camp" :

//     break;
//     case"dungeon":

//     break;
//     case"party":

//     break;
// }
// pop();