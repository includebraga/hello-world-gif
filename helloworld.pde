import gifAnimation.*;

GifMaker gifExport;

PFont font;
PImage bgImage;

String includeBraga = "#include <braga>";
String helloWorld = "hello, world!";
String currentString;

int time = 0;

void setup() {
  size(820, 312);
  frameRate(10);

  font = createFont("FiraMono-Bold.ttf", 100);
  textFont(font);

  bgImage = loadImage("bg.png");
  bgImage.resize(width,height);

  currentString = includeBraga;

  gifExport = new GifMaker(this, "includebraga.gif");
  gifExport.setRepeat(0);
}

void draw() {
  background(bgImage);

  fill(#2D3E50);
  noStroke();
  rectMode(CENTER);

  pushMatrix();
  translate(width/2, height/2);
  rect(0, 0, 321, 61);
  popMatrix();

  textAnimation();

  gifExport.setDelay(1);
  gifExport.addFrame();
}

void textAnimation() {
  time++;

  if(time > 20 && time < 40) {
    currentString = new String(glitchString(currentString, 1));
  }
  else if(time > 40 && time < 80) {
    currentString = new String(transformText(currentString, helloWorld, true));
  }
  else if(time > 80 && !currentString.equals(includeBraga)) {
    currentString = new String(transformText(currentString, includeBraga, false));
  }
  else if(time > 80 && currentString.equals(includeBraga)) {
    gifExport.finish();
    exit();
  }

  fill(#ffffff);
  textSize(30);
  text(currentString, width/2 - textWidth(includeBraga)/2, height/2 + 10);
}

char[] glitchString(String string, int numberOfChars){
  char[] newString = string.toCharArray();

  if(numberOfChars < string.length()){
    int[] charsToGlitch = new int[numberOfChars];

    for(int i = 0; i < numberOfChars; i++) {
      charsToGlitch[i] = int(random(0, string.length()));
    }

    for(int j = 0; j < numberOfChars; j++) {
      newString[charsToGlitch[j]] = (char)int(random(33, 122));
    }
  }

  return newString;
}

char[] transformText(String fromString, String toString, Boolean doIt) {
  char[] newString = fromString.toCharArray();

  int randomChar;
  Boolean done = false;

  do{
    randomChar = int(random(0, fromString.length()));

    if(randomChar > toString.length() - 1) {
      newString[randomChar] = ' ';
      break;
    }

    if(newString[randomChar] != toString.toCharArray()[randomChar]) {
      newString[randomChar] = toString.toCharArray()[randomChar];
      done = true;
    }
  } while(!done);

  return newString;
}
