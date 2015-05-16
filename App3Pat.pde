import android.bluetooth.BluetoothAdapter;
import ketai.net.bluetooth.*;    
import ketai.ui.*;

KetaiBluetooth bt;
BluetoothAdapter bluetooth = BluetoothAdapter.getDefaultAdapter();
//Habilitar permisos de bluetooth

//Creacion de objetos 
Rect rec1; 
Rect rec2;
Rect rec3;
Rect rec4;
Rect rec5;
Rect rec6; 
onBlue blue = new onBlue(false);

//Declaracion de variables
PFont font;
PImage img;
PImage icon; 

boolean state;
boolean blueState=false;
boolean h;

int time1 = 100;
int time2 = 100;
int i = 0;
//Asignacion de la MAC del bluetooth
String device = "20:13:01:24:14:29";
ArrayList<String> deviceConnected;
int flag = 0;

void setup(){
  orientation(PORTRAIT);
  //size(displayWidth,displayHeight);
  img = loadImage("itla.jpg");
  icon = loadImage("3paticon.png");
  fill(255);
  smooth();
  noStroke();
  font = loadFont("BodoniMTBlack-Italic-48.vlw");
  textFont(font);
  bt = new KetaiBluetooth(this);
  //Declaracion de objetos
  rec1 = new Rect(10,(displayHeight-650),(displayWidth-20)/3,310,'b', 'i');
  rec2 = new Rect((displayWidth-20)/3+10,(displayHeight-650),(displayWidth-20)/3,310,'b', 'f');
  rec3 = new Rect(2*(displayWidth-20)/3+10,(displayHeight-650),(displayWidth-20)/3,310,'b', 'd');
  rec4 = new Rect(10,(displayHeight-340),(displayWidth-20)/3,310,'b', 'j');
  rec5 = new Rect((displayWidth-20)/3+10,(displayHeight-340),(displayWidth-20)/3,310,'b', 'r');
  rec6 = new Rect(2*(displayWidth-20)/3+10,(displayHeight-340),(displayWidth-20)/3,310,'b', 'l');
  //Conexion del bluetooth
  bt.connectDevice(device);
}

void draw(){
  if (i < 485){
    background(255);
    image(icon,10,10,238,128);
    //int currentTime = millis();
    if (true/*currentTime > time1*/){
       image(img,width-i,(height/2),400,100);
       i+=5;
    }
  }else{
    background(255);
    textSize(48);
    textAlign(CENTER);
    fill(0);
    text("3Patines App",width/2,40);
    
    rec1.drawing();
    rec2.drawing();
    rec3.drawing();
    rec4.drawing();
    rec5.drawing();
    rec6.drawing();
    blue.drawing(bluetooth.isEnabled());
    
    fill(0);
    textSize(16);
    text("State:",25,15);
    
    if (mousePressed){
      flag = 0;
      fill(202,82,240);
      //ellipse(mouseX,mouseY,30,30);
      //text(mouseX+"      "+mouseY,mouseX,mouseY);
      fill(187,252,178,160);
      ellipse(mouseX,mouseY,50,50);
      
    }else{
      if (flag <= 3){
        char stop = 's';
        byte[] fc = {(byte)stop};
        bt.write(device, fc);
        flag++;
      }
    }
    fill(187,252,178,160);
    ellipse(270,620,480,620);
  }
}



//Clases
class Rect{
  //Clase para la creacion de los botones de control
  float x1,x2,y1,y2,r1,g1,b1,r2,g2,b2;
  char blue;
  Rect(float xpos1, float ypos1, float xpos2, float ypos2, char c, char bluet){
    //Constructor de la clase Rect que representa un rectangulo con atributos caracteristicos
    //xpo1 y xpos2 son el punto de inicio
    //xpos2 y ypos2 son el ancho y el alto del rectangulo
    //c es el color del rectangulo 'g'-verde 'b'-azul 'r'-rojo 'o'-naranja
    x1 = xpos1;
    x2 = xpos2;
    y1 = ypos1;
    y2 = ypos2;
    blue = bluet;
    
    if (c == 'g'){
      r1 = 24; r2 = 81;
      g1 = 155; g2 = 234;
      b1 = 16; b2 = 71;
    }else if (c == 'b'){
      r1 = 25; r2 = 52;
      g1 = 102; g2 = 141;
      b1 = 152; b2 = 198;
    }else if (c == 'r'){
      r1 = 242; r2 = 245;
      g1 = 10; g2 = 84;
      b1 = 14; b2 = 87;
    }else if (c == 'o'){
      r1 = 219; r2 = 232;
      g1 = 78; g2 = 118;
      b1 = 22; b2 = 73;
    }
  }
  void state(boolean state){
    //Atributo que realiza el cambio de estado representado por la variacion del color
    if (state == true){
      fill(this.r2,this.g2,this.b2);
    }else if(state == false){
      fill(this.r1,this.g1,this.b1);
    }
    rect(this.x1,this.y1,this.x2,this.y2);
  }
  void drawing(){
    //Atributo que dibuja el objeto y permite saber si el objeto debe de cambiar de estado
    if (mousePressed){
      if (mouseX < (this.x2 + this.x1) && mouseX > this.x1 && mouseY < (this.y2 + this.y1) && mouseY > this.y1){
        this.state(true);
        byte[] tx = {(byte)blue};
        bt.write(device, tx);
      }else{
        this.state(false);
      }
    }else{
      fill(this.r1,this.g1,this.b1);
      rect(this.x1,this.y1,this.x2,this.y2);
    }
  }
}

class onBlue{
  //Estado del bluetooth
  boolean blueState;
  onBlue(boolean state){
    blueState = state;
  }
  void drawing(boolean state){
    if (state){
      fill(10,255,30);
    }else{
      fill(255,10,30);
    }
    rect(0,20,50,50);
  }

}
