interface KnowledgeSheaf {
    ArrayList<Factoid> getFactoids();
    void addFactoid(Factoid fact);
    void removeFactoid(Factoid fact);
    void merge(LocalSection otherSheaf);
}