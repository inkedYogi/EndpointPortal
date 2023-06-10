class Helper {
    
    void saveMatrix(int[][] M, String filename) {
        PrintWriter output = createWriter(filename); 
        for(int x = 0; x < M.length; x++) {
            for(int y = 0; y < M[0].length; y++) {
                output.print(M[x][y] + "  ");
            }
            output.println();
        }
        output.flush(); // Writes the remaining data to the file
        output.close(); // Finishes the file
    }
    
    char[][] File2CMat(String F) {
        String filename = F;
        String[] lines = loadStrings(filename);
        println(filename + " was loaded");
        String[] q = splitTokens(lines[0], " ");
        char[][] M = new char[lines.length][q.length];
        for(int i = 0; i < lines.length; i++) {
            String[] t = splitTokens(lines[i], " ");
            for(int j = 0; j < t.length; j++) {
                M[i][j] = t[j].charAt(0);
            }
        }
        println("there are " + M.length + " lines of data");
        println("there are " + M[0].length + " columns of characters");
        return M;
    }
    
    char[] flatten(char[][] M) {
        int x = M.length;
        int y = M[0].length;
        char[] temp = new char[x * y];
        for(int i = 0; i < x; i++) {
            for(int j = 0; j < y; j++) {
                temp[i * y + j] = M[i][j];
            }
        }
        return temp;
    }    
    
    PVector worldPos2screenPos(PVector W) {
        PVector S = new PVector(0, 0);
        S.x =  W.x;// - worldScreen.x;
        S.y =  W.y;// - worldScreen.y;
        return S;
    }
    
    PVector screenPos2worldPos(PVector S) {
        PVector W = new PVector(0, 0);
        W.x =  S.x;// + worldScreen.x;
        W.y =  S.y;// + worldScreen.y;
        return W;
    }
    
    Node getNodeByAddress(NTree tree, int[] address) {
        if(tree == null || address == null || tree.nodes == null) {
            return null;
        }
        
        for(Node node : tree.nodes) {
            if(node.address==address) {
                return node;
            }
        }
        return null;
    }

    int[] createPOIAddress(int age, int regionCode, boolean[] colorInteractions, int totalConnections) {
        int[] address = new int[4];
        int colorInteraction = 0;
        for(int i = 0; i < colorInteractions.length; i++) {
            if (colorInteractions[i]) {
                colorInteraction += (int) Math.pow(2, i);
            }
        }
        address[0] = age;
        address[1] = regionCode;
        address[2] = colorInteraction;
        address[3] = totalConnections;
        return address;
    }
    
    boolean[] decodeColorInteractions(int colorInteractionCode, int numColors) {
        boolean[] colorInteractions = new boolean[numColors];
        for (int i = 0; i < numColors; i++) {
            colorInteractions[i] = ((colorInteractionCode >> i) & 1) == 1;
        }
        return colorInteractions;
    }

    //Function to create a (Faction_Relation_Matrix [FRM])
    // int[][] createFactionMatrix(int n) {
    //  // Generate an n x n matrix where each entry is a random integer between -1 and 1
    //  int[][] matrix = new int[n][n];
    //  for(int i = 0; i < n; i++) {
    //  for(int j = 0; j < n; j++) {
    //  matrix[i][j] = floor(random(3) - 1);
    //  }
    //     }
    //  return matrix;
// }
    
    //Function to create a language matrix for language compatability calcs(Language_Compatibility_Matrix[LCM])
    // float[][]createLanguageMatrix(int n, int m) {
    //     // Generate an nx m matrix where each entry is a random floating-point number between 0 and 1
    //     float[][] matrix = new float[n][m];
    //     for(int i = 0; i < n; i++) {
    //         for(int j = 0; j < m; j++) {
    //             matrix[i][j] = random(1);
    //         }
    //     }
    //     return matrix;
// }
    
    // Function to transfer knowledge from a source language to a target language(Scroll_Exchange[SEX])
    float[][] transferKnowledge(float[][] sourceMatrix, float[][] targetMatrix) {
        // Compute the dotproduct of the transpose of the source matrix and the target matrix
        float[][] result = new float[sourceMatrix[0].length][targetMatrix.length];
        for(int i = 0; i < sourceMatrix[0].length; i++) {
            for(int j = 0; j < targetMatrix.length; j++) {
                float sum = 0;
                for(int k = 0; k < sourceMatrix.length; k++) {
                    sum += sourceMatrix[k][i] * targetMatrix[k][j];
                }
                result[i][j] = sum;
            }
        }
        return result;
    }
    
    // Method for reading a CSV file and returning its content as an ArrayList of String arrays
    // ArrayList<String[]> File2Arrs(String filePath) {
    //     ArrayList<String[]> data = new ArrayList<String>();
    //     try(BufferedReader br = new BufferedReader(new FileReader(filePath))) {
    //         String line;
    //         while((line = br.readLine()) != null) {
    //             String[] values = line.split(",");
    //             data.add(values);
    //         }
    //     } catch(IOException e) {
    //         e.printStackTrace();
    //     }
    //     return data;
// }
    
    // Method for processing theCSV data and storing it in data structures
    void processData(ArrayList < String[] > csvData, GameManager gameManager) {
        // Process CSV data and populate data structures in GameManager
        // For example, you could create methods for processing each type of CSV file
        // (cities, trade network, language compatibility matrix, faction relation matrix, etc.)
        // and call them here.
    }
}
