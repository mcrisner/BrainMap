// Configuration constants
final String OUTPUT_FILE_NAME = "combined_image.png";

PImage multiplanar, superior, leftImg, rightImg;
PImage combined;

void setup() {
    size(792, 620);
    
    // Calculate canvas dimensions
    int canvasWidth = 3170;
    int canvasHeight = (int)(2012 * 1.35);

    loadImages();
    createCanvas(canvasWidth, canvasHeight);
    processAndCombineImages(canvasWidth, canvasHeight);
    annotateCombinedImage();
    saveImage();
}

void draw() {
    image(combined, 0, 0, width, height);
}

// Load images from the user's Downloads folder
void loadImages() {
    String userHome = System.getProperty("user.home");
    
    try {
        multiplanar = loadImage(userHome + "/Downloads/multi.png");
        superior = loadImage(userHome + "/Downloads/sup.png");
        leftImg = loadImage(userHome + "/Downloads/left.png");
        rightImg = loadImage(userHome + "/Downloads/right.png");
        
        if (multiplanar == null || superior == null || leftImg == null || rightImg == null) {
            println("Error: One or more images failed to load.");
            exit();
        }
    } catch (Exception e) {
        println("Error loading images: " + e.getMessage());
        exit();
    }
}

// Create and initialize the combined canvas
void createCanvas(int imgWidth, int imgHeight) {
    combined = createImage(imgWidth, imgHeight, RGB);
    combined.loadPixels();
}

// Process and combine all images into the combined canvas
void processAndCombineImages(int imgWidth, int imgHeight) {
    // SUPERIOR
    PImage superiorMiddle = getMiddleThird(superior);
    superiorMiddle.resize(int(imgWidth * .28), 0);
    drawImageToCombined(superiorMiddle, int(imgWidth * 0.02), 0);
  
    // LEFT
    PImage leftMiddle = getRoughThird(leftImg);
    leftMiddle.resize(imgWidth / 3, 0);
    drawImageToCombined(leftMiddle, int(imgWidth * 0.315), int(imgHeight * 0.1));
  
    // RIGHT
    PImage rightMiddle = getRoughThird(rightImg);
    rightMiddle.resize(imgWidth / 3, 0);
    drawImageToCombined(rightMiddle, int(imgWidth * 0.65), int(imgHeight * 0.1));
  
    // MULTIPLANAR
    multiplanar = multiplanar.get(0, int(multiplanar.height * 0.35), multiplanar.width, int(multiplanar.height * 0.65));
    multiplanar.resize(imgWidth, 0);
    drawImageToCombined(multiplanar, 0, int(imgHeight * 0.51));
  
    combined = combined.get(0, int(combined.height * 0.08), combined.width, int(combined.height * 0.92));
    
    // Remove confusing 'R' indicators
    drawBlackRectangle(0, 1155, 125, 175);
    drawBlackRectangle(1940, 1300, 125, 250);
}

// Annotate the combined image
void annotateCombinedImage() {
    addTextAnnotation("L", 50, 250, 120); 
    addTextAnnotation("R", 50, 1425, 120); 
    addTextAnnotation("R", 1235, 1425, 120); 
}

// Save the final result
void saveImage() {
    String userHome = System.getProperty("user.home");
    String outputFile = userHome + "/Downloads/" + OUTPUT_FILE_NAME;
    combined.save(outputFile);
    println("Image saved to: " + outputFile);
}

PImage getMiddleThird(PImage img) {
    int thirdWidth = img.width / 3;
    return img.get(thirdWidth, int(img.height * 0.02), thirdWidth, img.height);
}

PImage getRoughThird(PImage img) {
    return img.get(int(img.width * 0.29), int(img.height * 0.2), int(img.width * 0.43), int(img.height * 0.6));
}

// Helper function to draw images onto the combined canvas
void drawImageToCombined(PImage img, int x, int y) {
    for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
            int pixelIndex = (x + i) + (y + j) * combined.width;
            if (pixelIndex < combined.pixels.length && pixelIndex >= 0) {
                combined.pixels[pixelIndex] = img.pixels[i + j * img.width];
            }
        }
    }
}

// Helper function to add text annotations
void addTextAnnotation(String text, int x, int y, int fontsize) {
    PGraphics pg = createGraphics(combined.width, combined.height);
    pg.beginDraw();
    pg.fill(255);
    pg.textSize(fontsize);
    pg.text(text, x, y);
    pg.endDraw();
    combined.loadPixels();
    pg.loadPixels();
    for (int i = 0; i < combined.pixels.length; i++) {
        if (alpha(pg.pixels[i]) > 0) {
            combined.pixels[i] = pg.pixels[i];
        }
    }
    combined.updatePixels();
}

void drawBlackRectangle(int x, int y, int imgWidth, int imgHeight) {
    for (int i = x; i < x + imgWidth; i++) {
        for (int j = y; j < y + imgHeight; j++) {
            int pixelIndex = i + j * combined.width;
            if (pixelIndex < combined.pixels.length && pixelIndex >= 0) {
                combined.pixels[pixelIndex] = color(0, 0, 0);
            }
        }
    }
}
