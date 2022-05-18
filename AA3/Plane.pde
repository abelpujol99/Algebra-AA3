class Plane{

   private int curveState;
   private float speed;
   private float pointOfCurve;
   private PVector pos;
   private PVector initPos;
   private PVector points[][];
   private InterpolationCurve curve[];
   
   
   Plane(float speed, PVector initPos){
   
     this.curveState = 0;
     this.speed = speed;
     this.initPos = initPos.copy();
     this.points = new PVector[2][4];
     points[0][0] = new PVector(0, 0, 0);
     points[0][1] = new PVector(500, 0, 0);
     points[0][2] = new PVector(500, 0, 500);
     points[0][3] = new PVector(0, 0, 0);
     points[1][0] = new PVector(-500, 0, 0);
     points[1][1] = new PVector(-500, 0, -500);
     points[1][2] = new PVector(0, 0, -500);
     points[1][3] = new PVector(0, 0, 0);
     this.curve = new InterpolationCurve[2];
     for(int i = 0; i < points.length; i++){
       curve[i] = new InterpolationCurve(points[i]);
     }      
   }
   
   void SetSpeed(float speed){
     this.speed = speed;
   }
   
   float GetSpeed(){
     return speed;
   }   
   
   void SetPos(PVector pos){
     this.pos = pos;   
   }
   
   PVector GetPos(){
     return pos;
   }
   
   void Move(){
   
     if(pointOfCurve < 1 && curveState < 2){
       pointOfCurve += 1 / speed;
   
       pos = initPos.copy();
       pos.add(curve[0].CalculateCurvePoint(pointOfCurve));
     }
     else if(curveState < 2){
       this.curveState++;
     }
     else{
       ResetPos();
     }
   }
   
   void ResetPos(){     
     pos = initPos.copy();
   }
   
   void Draw(){

     push();
     
     strokeWeight(3);
     fill(color(50,200,150));
     stroke(color(50,200,150));
     translate(pos.x, pos.y, pos.z);
     sphere(20);
     
     pop();

   }
}
