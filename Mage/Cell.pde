class Cell {
    PVector loc;
    String biome;
    int type;
    hyp charge;
    ArrayList<Cell> neighbors;
    String frame;
    
    Cell() {
        loc = new PVector(0, 0);
        type = -1;
        biome = "?";
        charge = new hyp();
        neighbors = new ArrayList<Cell>();
        frame = "world"; // default frame of reference
    }
    
    Cell(float X, float Y) {
        loc = new PVector(X, Y);
        type = -1;
        biome = "?";
        charge = new hyp();
        neighbors = new ArrayList<Cell>();
        frame = "world"; // default frame of reference
    }
    
    void flash(int P) {
        push();
        noStroke();
        translate(loc.x, loc.y);
        fill(255, 255 * cos((frameCount + P) *.15));
        square(0,0,1.0);
        pop();
    }
    
    PVector worldCoordinates() {
        if(frame.equals("world")) {
            return loc;
        } else {
            return helper.screenPos2worldPos(loc);
        }
    }
    
    PVector screenCoordinates() {
        if(frame.equals("screen")) {
            return loc;
        } else {
            return helper.worldPos2screenPos(loc);
        }
    }
    
    void convertToFrame(String newFrame) {
        if(newFrame.equals(frame)) {
            return;
        }
        
        if(newFrame.equals("world")) {
            loc = helper.screenPos2worldPos(loc);
        } else if(newFrame.equals("screen")) {
            loc = helper.worldPos2screenPos(loc);
        }
        
        frame = newFrame;
    }
    
    void addNeighbor(Cell cell) {
        neighbors.add(cell);
    }
    
    void calculateCharge() {
        int numNeighbors = neighbors.size();
        if(numNeighbors <= 4) {
            // Assign RGB values based on the accessibility of the cell
            // White: fully accessible, Green: needs green vehicle, Blue: needs blue vehicle, Red: needs red vehicle
            charge = new hyp(new double[]{1, 0, 0, 0}); // Default to white (fully accessible)
            if(biome.equals("mountain")) {
                charge = new hyp(new double[]{0, 1, 0, 0}); // Red for mount
            } else if(biome.equals("sea")) {
                charge = new hyp(new double[]{0, 0, 1, 0}); // Blue for ship
            } else if(biome.equals("sky")) {
                charge = new hyp(new double[]{0, 0, 0, 1}); // Green for airship
            }
        } else {
            // If there are more than 4 neighbors, assign an alpha value to indicate a magical connection
            charge = new hyp(new double[]{1, 0, 0, 1}); // Alpha value added
        }
    }
    }
        