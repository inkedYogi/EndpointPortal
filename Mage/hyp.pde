class hyp {
    double[] components;
    
    hyp() {
        zeroInit();
    }
    
    hyp(double[] components) {
        int iterations = (int)(Math.log(components.length) / Math.log(2));
        hyp unfolded = this.unfold(iterations);
        this.components = unfolded.components;
        for(int i = 0; i < components.length; i++) {
            this.components[i] = components[i];
        }
    }
    
    hyp(int pixel) {
        zeroInit();
        extractRGBA(pixel);
    }
    
    private void zeroInit() {
        components = new double[8];
        for(int i = 0; i < 8; i++) {
            components[i] = 0.0;
        }
    }
    
    hyp unfold(int iterations) {
        int newLength = components.length * (int) Math.pow(2, iterations);
        double[] unfolded = new double[newLength];
        return new hyp(unfolded);
    }
    
    hyp add(hyp other) {
        double[] result = new double[8];
        for(int i = 0; i < 8; i++) {
            result[i] = components[i] + other.components[i];
        }
        return new hyp(result);
    }
    
    hyp multiply(hyp other) {
        // Implement octonion multiplicationrules here
    }
    
    hyp conjugate() {
        double[] result = new double[components.length];
        result[0] = components[0];
        for(int i = 1; i < components.length; i++) {
            result[i] = -components[i];
        }
        return new hyp(result);
    }
    
    double norm() {
        double sum = 0;
        for(double component : components) {
            sum += component * component;
        }
        return sqrt(sum);
    }
    
    void extractARGB(int pixel) {
        int alpha = alpha(pixel);
        int red = red(pixel);
        int green = green(pixel);
        int blue = blue(pixel);
        
        components[0] = alpha;
        components[1] = red;
        components[2] = green;
        components[3] = blue;
    }
    
    void extractWRGB(int pixel) {
        int white = brightness(pixel);
        int red = red(pixel);
        int green = green(pixel);
        int blue = blue(pixel);
        
        components[0] = white;
        components[1] = red;
        components[2] = green;
        components[3] = blue;
    }
    
    hyp copy() {
        return new hyp(components.clone());
    }
    
    void encodeInt(int value) {
        for(int i = 0; i < 4; i++) {
            components[i] = (value >> (i * 8)) & 0xFF;
        }
    }

    int decodeToInt() {
        int value = 0;
        for(inti = 0; i < 4; i++) {
            value |= (components[i] & 0xFF) << (i * 8);
        }
        return value;
    }
    
}

/*
class hyp {
double[] components;

hyp() {}
hyp(double[]components) {}
hyp(int pixel) {}
void extractARGB(int pixel) {}
void extractWRGB(int pixel) {}
hyp add(hyp other) {}
hyp multiply(hypother) {}
hyp conjugate() {}
double norm() {}
hyp copy() {}
void encodeInt(int value) {}
int decodeToInt() {}
}
*/