class NTree { 
    Node root;
    int totalNodes;
    int maxDeg, actualDeg;
    int maxGen, actualGen;
    ArrayList<Node> nodes;
    ArrayList<Link> links;
    ArrayList<Node> leafs;
    int[] heirarchy;
    
    NTree() {
        root = new Node();
        totalNodes = 1;
        maxGen = 1;
        maxDeg = 1;
        heirarchy = new int[maxGen + 1];
        nodes = new ArrayList<Node>();
        links = new ArrayList<Link>();
        leafs = new ArrayList<Node>();
    }
    
    void setParams(Node R, int T, int G, int D) {
        root = R;
        totalNodes = T;
        maxGen = G;
        maxDeg = D;
        heirarchy = new int[maxGen + 1];
    }
    
    void build() {
        actualGen = 1;
        actualDeg = 1;
        nodes.add(root);
        leafs.add(root);
        while(this.nodes.size() < totalNodes)  growRandomLayer();
        calcHeirarchy();
        calcProgeny();
        root.propagateDistance(0);
        for(Node n : leafs)  n.locked = false;
    }
    
    void update() {
        for(Link l : links)  l.update();        
        for(Node n : nodes)  n.update();
    }
    
    void disp() {
        // for(Link l : links)  l.disp();
        for(Node n : nodes)  n.disp();
    }
    
    void attach(Node M, Node N) {   // M <- N
        Link L = new Link(M, N);   
        if(leafs.contains(M))  leafs.remove(M);
        nodes.add(N);   
        links.add(L);
        leafs.add(N);   
        // N.pos = M.pos.copy();
        // N.id = nodes.size() - 1;
        N.generation = M.generation + 1;
        N.update();
        M.child.add(N);
        // N.pos.add(L.growth);
        if(M.child.size() > actualDeg)  actualDeg = M.child.size();
        if(N.generation > actualGen)  actualGen = N.generation;
    }
    
    void growRandomLayer() {
        int index = (int)random(0, nodes.size());
        if(nodes.get(index).generation == maxGen)  return;
        if(nodes.get(index).child.size() == maxDeg)  return;
        attach(nodes.get(index), new Node());
    }
    
    void calcHeirarchy() {
        for(int i = 0; i < maxGen + 1; i++)  heirarchy[i] = 0;
        for(int j = 0; j < nodes.size(); j++) {
            for(int i = 0; i < maxGen + 1; i++) {
                if(nodes.get(j).generation == i)  heirarchy[i] += 1;
            }
        }
    }
    
    void calcProgeny() {
        root.reportProgeny();
    }
    
    void report() {
        println("tree nodes: " + nodes.size());
        println("tree links: " + links.size());       
        println("leaf nodes: " + leafs.size());
        print("max degree: " + maxDeg + "   ");
        println("     actual degree: " + actualDeg);
        print("max generations: " + maxGen + "   ");
        println("actual generations: " + actualGen);
    }
    
    void popNode(Node N) {
        for(int i = links.size() - 1; i>= 0;i--)  if(links.get(i).b == N) { 
                links.get(i).a.children--;
                if(links.get(i).a.children == 0)  leafs.add(links.get(i).a);
            links.remove(links.get(i));
        }
        heirarchy[N.generation]--;
        leafs.remove(N);
        nodes.remove(N);
        if(heirarchy[N.generation] == 0) {  //if the node removed was the last of the generation, gain a level
            // player.gainLevel();                     //level = travel mode
        } 
    }
    
    int[][] tree2Mat() {
        int n = nodes.size();
        int[][] M = new int[n][n];        
        for(int i = 0; i < n; i++)  for(int j = 0; j < n; j++) {
                M[i][j] = 0;                                    //defaults all entries to 0
                Node a = nodes.get(i);
            Node b = nodes.get(j);
            for(Link l : links) {
                if(l.eq(a, b)) {                            //puts a 1 in the entry if i is linked to j
                    M[i][j] = 1;
                    M[j][i] = 1;
                }
            }
            if(i == j)  M[i][j] = 1;                            //puts a 1 in the entry connecting it to itself (the diagonal)
        }   
        return M;
    }
    
    void saveMat(String F) {
        int n = nodes.size();
        int[][] M = tree2Mat();
        helper.saveMatrix(M,"data/" + F + ".txt");
    }
}

/*
class NTree {
Node root;
int totalNodes;
int maxDeg, actualDeg;
int maxGen, actualGen;
ArrayList<Node> nodes;
ArrayList<Link> links;
ArrayList<Node> leafs;
int[] heirarchy;

NTree();
void setParams(QNode R, int T, int G, int D);
void build();
void update();
void disp();
void attach(Node M, QNode N);
void growRandomLayer();
void calcHeirarchy();
void calcProgeny();
void report();
void popNode();
int[][] tree2Mat();
void saveMat(String F);
}
*/