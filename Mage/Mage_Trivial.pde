boolean debug = true;
// boolean debug = false;

GameManager gameManager;
Helper helper;

void setup() {
    size(800, 600);
    helper = new Helper();
    start();
}

void start() {
    gameManager = new GameManager(18819);
    gameManager.init();
}

void draw() {
    gameManager.gameLoop();
}