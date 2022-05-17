class Plane{

   private float speed;
   private float pointOfCurve;
   private PVector pos;
   private PVector initPos;
   private PVector points[];
   private InterpolationCurve curve;
   
   
   Plane(float speed, PVector initPos){
   
     this.speed = speed;
     this.initPos = initPos.copy();
     this.points = new PVector[4];
     points[0] = initPos.copy();
     points[1] = new PVector(500, -50, 0);
     points[2] = new PVector(500, -50, 500);
     points[3] = new PVector(0, -50, 500);
     curve = new InterpolationCurve(points);
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
   
     if(pointOfCurve < 1){
       pointOfCurve += 1 / speed;
   
       pos = initPos.copy();
       pos.add(curve.CalculateCurvePoint(speed));
     
     }else{
       ResetPos();
     }
     print(pos.x + " " + pos.y + " " + pos.z + "\n");
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
