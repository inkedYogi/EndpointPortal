class Node {
  int[] address;
  int parentAddress, goalAddress, heuristicScore;
  int id, generation, children, progeny, distToRoot;
  boolean locked;  
  boolean visited;
  ArrayList<Node> child;
  ArrayList nbors;
  ArrayList nCost;

  ArrayList<Factoid> facts;
  WorldModifier enitySlot;
  PVector pos;

  Node() {
    address = new Int[4];
    address = gameManager.helper.generateAddress();
    nbors = new ArrayList();
    nCost = new ArrayList();
    id = 0;
    children = 0;
    progeny = 0;
    generation = 0;
    distToRoot = 0;
    locked = true;
    visited = false;
    child = new ArrayList<QNode>();
    //data = new Data();
  }
  
   void update() {
    progeny = reportProgeny();
  }
  
  void disp() {}
  
  int reportProgeny() {
    progeny = 0;
     for (Node c : child)  progeny += c.reportProgeny();
     return (1+progeny);
  }
  
  void propagateDistance(int D) {
    distToRoot = D;
    for (Node c : child)  c.propagateDistance(distToRoot+1);
  }

  boolean eq(Node T) {   //returns true if two nodes are the same
    if (T.id == this.id)
       return true;
    return false;
  }

  void addNbor(Node N, float C) {
    nbors.add(N);
    nCost.add(new Float(C));
  }
}

/*
class Node {
  int address;
  int parentAddress, goalAddress, heuristicScore;
  int id, generation, children, progeny, distToRoot;
  boolean locked;
  boolean visited;
  ArrayList<Node> child;
  ArrayList nbors;
  ArrayList nCost;
  ArrayList<Factoid> facts;
  WorldModifier enitySlot;

  Node(int A)
  void update()
  void disp()
  int reportProgeny()
  void propagateDistance(int D)
  boolean eq(QNode T)
  void addNbor(NNode N, float C)
}
*/
