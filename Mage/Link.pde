class Link {
    Node a, b;
    
    Link(Node A, Node B) {
        a = A;
        b = B;
    }
    
    void update() {
        //no changes here
    }
    
    boolean eq(Node U, Node V) {  //returns true if u and v are linked but not if u=v
        if(U.eq(a) || U.eq(b))
            if(V.eq(a) || V.eq(b))
                if(!U.eq(V))  
                    return true;
                return false;
    }
}

/*
class Link {
Node a, b;

Link(Node A, Node B)
void update()
boolean eq(Node U, Node V)
}
*/