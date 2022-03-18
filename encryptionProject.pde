import controlP5.*;
ControlP5 cp5;

String plainText, cipherText, decryptedText;
int keyNum;
String keyWord;
String typeOfEncryption = "";

void setup() {
  size(600, 600);
  
  PFont font = createFont("arial", 20);
  cp5 = new ControlP5(this);
  
  cp5.addTextfield("messageInput")
    .setPosition(20, 100)
    .setSize(450, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255, 0, 0));
    
  cp5.addNumberbox("keyNumInput")
    .setPosition(25, 400)
    .setSize(175, 40)
    .setRange(0, 25)
    .setDirection(Controller.HORIZONTAL)
    .setFont(font);
    
  cp5.addTextfield("keyWordInput")
    .setPosition(325, 400)
    .setSize(175, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255, 0, 0));
    
   cp5.addBang("Message")
    .setPosition(490, 100)
    .setSize(80, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
  cp5.addBang("keyNum")
    .setPosition(225, 400)
    .setSize(50, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
  cp5.addBang("keyWord")
    .setPosition(525, 400)
    .setSize(50, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
  cp5.addBang("cEncrypt")
    .setPosition(12.5, 525)
    .setSize(125, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
  cp5.addBang("vEncrypt")
    .setPosition(312.5, 525)
    .setSize(125, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
  cp5.addBang("cDecrypt")
    .setPosition(167.5, 525)
    .setSize(125, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    cp5.addBang("vDecrypt")
    .setPosition(467.5, 525)
    .setSize(125, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    


  textFont(font);
  plainText = "";
  cipherText = "";
  keyNum = 0;
  keyWord = " ";
}

void draw() {
  background(255);  
  textDisplay();
}

void encryptData(String typeOfEncryption){
  ArrayList<Integer> keyNumbers = new ArrayList<Integer>();
  int j = -1;
  for (int i = 0; i < plainText.length(); i++) {
    if (isLetter(plainText.charAt(i))) j++;
    keyNumbers.add(keyWord.charAt(j % keyWord.length()) - int('a'));
  }
  
  if(typeOfEncryption == "cEncrypt"){
    caesarEncrypt();
  } else if (typeOfEncryption == "vEncrypt"){
    vigenereEncrypt(keyNumbers);
  } else if (typeOfEncryption == "cDecrypt"){
    caesarDecrypt();
  } else if (typeOfEncryption == "vDecrypt"){
    vigenereDecrypt(keyNumbers);
  }
}

void caesarEncrypt(){
  cipherText = caesar(plainText, keyNum);
}

void caesarDecrypt(){
  cipherText = caesar(plainText, 26-keyNum);
}

void vigenereEncrypt(ArrayList<Integer> keyNum){
  cipherText = "";
  for (int i = 0; i < plainText.length(); i++) {
    cipherText += caesar(str(plainText.charAt(i)), keyNum.get(i));
  }
}

void vigenereDecrypt(ArrayList<Integer> keyNum){
  cipherText = "";
  for (int i = 0; i < plainText.length(); i++) {
    cipherText += caesar(str(plainText.charAt(i)), 26-keyNum.get(i));
  }  
}


String caesar(String m, int k) {
  String output = ""; //<>//

  for (int i = 0; i < m.length(); i++) {
    char character = m.charAt(i);
    int asciiCode = int(character);
    if (isLetter(character)) {
      if (isLowerCase(character)) asciiCode = ((asciiCode-97) + k)%26 + 97;
      if (isUpperCase(character)) asciiCode = ((asciiCode-65) + k)%26 + 65;
    }
    char encryptedCharacter =  char(asciiCode);
    output += encryptedCharacter;
  }

  return output;
}

boolean isLowerCase(char c) {
  int j = int(c);
  if (j >= 97 && j <= 122) return true;
  return false;
}

boolean isUpperCase(char c) {
  int j = int(c);
  if (j >= 65 && j <= 90) return true;
  return false;
}

boolean isLetter(char c) {
  int j = int(c);
  if (j >= 65 && j <= 90) return  true;
  if (j >= 97 && j <= 122) return  true;
  return false;
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(cp5.getController("Message"))) {
    submitButtonPressed();
  }
  
  if (theEvent.isFrom(cp5.getController("keyNum"))){
    keyNumberPressed();
  }
  
  if (theEvent.isFrom(cp5.getController("keyWord"))) {
    keyWordPressed();
  }
  
  if (theEvent.isFrom(cp5.getController("cEncrypt"))) {
    encryptData("cEncrypt");
  }
  
  if (theEvent.isFrom(cp5.getController("vEncrypt"))) {
    encryptData("vEncrypt");
  }
  
  if (theEvent.isFrom(cp5.getController("cDecrypt"))) {
    encryptData("cDecrypt");
  }
  
  if (theEvent.isFrom(cp5.getController("vDecrypt"))) {
    encryptData("vDecrypt");
  }
}

void submitButtonPressed() {
  String enteredText = cp5.get(Textfield.class, "messageInput").getText();
  plainText = enteredText;
}

void keyNumberPressed(){
  int enteredNumber = (int) cp5.get(Numberbox.class, "keyNumInput").getValue(); 
  keyNum = enteredNumber;
}

void keyWordPressed(){
  String enteredText = cp5.get(Textfield.class, "keyWordInput").getText();
  keyWord = enteredText;
}

void textDisplay(){
  textSize(40);
  fill(0);
  textAlign(CENTER);
  text("Encryptia!", width/2, 50);
  textSize(25);
  textAlign(LEFT);
  text("Input Text: ", 25, 200);
  text("Modified Text: ", 25, 250);
  text("Caesar", width/6, 350);
  text("Key: " + keyNum, 20, 487.5);
  text("Vigenere", 4*width/6, 350);
  text("Key Word: " + keyWord, 320, 487.5);
  textSize(20);
  fill(27, 138, 165);
  text(plainText, 150, 200);
  fill(173, 21, 39);
  text(cipherText, 190, 250);
  
  line(width/2, 300, width/2, height);
  line(0, 300, width, 300); 
}
