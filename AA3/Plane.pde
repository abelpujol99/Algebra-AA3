class Plane{

   private float speed;
   private float pointOfCurve;
   private int curveCounter;
   private PVector pos;
   private PVector initPos;
   private PVector points[][];
   private InterpolationCurve curve[];
   
   
   Plane(float speed, PVector initPos){
   
     this.speed = speed;
     this.initPos = initPos.copy();
     this.points = new PVector[2][4];
   }
   
   void SetPoints(PVector points[][]){   
     this.points = points;
   }
   
   PVector GetInitPos(){
     return initPos;
   }
   
   void SetCurves(){     
     curve = new InterpolationCurve[points.length];
     for(int i = 0; i < curve.length; i++){
       this.curve[i] = new InterpolationCurve(points[i]);
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
        
     if(pointOfCurve < 1){
       pointOfCurve += 1 / speed;       
       PVector auxPos = initPos.copy();    
       auxPos.add(curve[curveCounter].CalculateCurvePoint(pointOfCurve));       
       pos = auxPos.copy();
     }else{
       this.pointOfCurve = 0;
       this.curveCounter++;
       if(curveCounter == curve.length){
         curveCounter = 0;
       }
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
