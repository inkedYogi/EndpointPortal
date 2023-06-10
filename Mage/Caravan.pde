/*
Fields:
Navigator navigator
ArrayList<Denizen> partyRiders
ArrayList<Vehicle> partyVehicles
ArrayList<Beast> partyBeasts
int vehicle
boolean fullSpeed, halfSpeed, quarterSpeed
Tile currentTile
Tile targetTile
String destination
float distTravelled
float distRemaining
boolean atPOI
PVector pos

Methods:
void setNewDestination(String N, float D)
void reset()
void move(int D)
void planJourney()
void startJourney()
void takeStep()
void travel()
float makeProgress()
void teleport(Tile T)
void spawn(Tile T)
void arrive()
void enterPOI()
void rest()
void changeVehicle(int V)
void charter(int V)
void gather(String B)
void joinParty(Denizen denizen)
void report()
void makeRandom(int N, int V)
*/
