part of ex05;

const int CANVAS_WIDTH = 600;
const int FINAL_MAX_DEPTH = 8;

class SierpinskiTriangle {

  Timer timer;
  
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  
  int maxDepth = 0;
  
  SierpinskiTriangle(this.canvas) {
    //Définir la hauteur du canvas en fonction de 
    //sa largeur pour y faire entrer un triangle équilatéral
    canvas.width = CANVAS_WIDTH;
    canvas.height = (sqrt(3) / 2 * CANVAS_WIDTH).round();
    
    context = canvas.getContext("2d");
    
    timer = new Timer.periodic(const Duration(milliseconds: 1000),
        (t) => drawNewDepth());
  }
  
  void drawNewDepth() {
    if (maxDepth < FINAL_MAX_DEPTH) {
      context.clearRect(0, 0, canvas.width, canvas.height);
      maxDepth++;
      buildSierpinskiTriangle();
    }
    else {
      maxDepth = 0;
    }
  }
  
  void buildSierpinskiTriangle(){
    //Initialiser les trois points du triangle de base
    Point a = new Point(0, canvas.height);
    Point b = new Point(canvas.width, canvas.height);
    Point c = new Point(canvas.width / 2, 0);
    
    //Dessiner ce triangle en noir
    context.fillStyle = "#000000";
    drawTriangle(a,b,c);

    //Enlever récursivement le triangle au centre (mettre blanc)
    context.fillStyle = "#ffffff";
    removeCenterTriangle(a, b, c, maxDepth);
  }
  
  void drawTriangle(Point a, Point b, Point c) {
    context.beginPath();
    context.moveTo(a.x, a.y);
    context.lineTo(b.x, b.y);
    context.lineTo(c.x, c.y);
    context.lineTo(a.x, a.y);
    context.fill();
  }
  
  void removeCenterTriangle(Point a, Point b, Point c, int depth) {
    if (depth > 1){
      //Calcul des points intermédiaires
      Point interA = new Point((a.x + b.x)/2, (a.y + b.y)/2);
      Point interB = new Point((a.x + c.x)/2, (a.y + c.y)/2);
      Point interC = new Point((b.x + c.x)/2, (b.y + c.y)/2);
      drawTriangle(interA, interB, interC);
      
      //Enlèvement récursif du centre des 3 triangles résultants
      if (depth > 2) {
        removeCenterTriangle(a, interA, interB, depth - 1);
        removeCenterTriangle(interA, b, interC, depth - 1);
        removeCenterTriangle(interB, interC, c, depth - 1);
      }
    }
  }

  
}