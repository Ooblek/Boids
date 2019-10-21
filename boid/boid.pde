class Boid {

 

    PVector position  = new PVector();
     PVector vel = new PVector();
    PVector acc = new PVector();
    float maxSteer = 1;
    float maxSpeed = 2;
    
    
     
  
  Boid(){
    position = new PVector(random(width), random(height));
    vel = PVector.random2D();
    
    
    
    
  }
  
  void coll(){
    
    if(this.position.x > width){
    
      this.position.x = 0;
    }
     if(this.position.x < 0){
    
      this.position.x = width;
    }
    
     if(this.position.y > height){
    
      this.position.y = 0;
    }
     if(this.position.y < 0){
    
      this.position.y = height;
    }
  
  }
  
  void show(){
  
    strokeWeight(2);
    stroke(255);
    point(this.position.x, this.position.y);
    
  }
  
  void update(){
  
    this.position.add(vel);
    this.vel.add(acc);
    this.vel.limit(maxSpeed);
      
    
  }
  
  
  //alignment
  PVector align(Boid b[]){
    
    float perception =100;

    PVector steer = new PVector(0,0);
    
    float total = 0;
    
    for(Boid other : b){
      float dist;
      dist = PVector.dist(other.position, this.position);
      
      if(other != this && dist<perception){
          steer.add(other.vel);
          total = total+1;
       }
            
    }
    
    if(total >0){
      steer.div(total);
      //cR's steering formula desired - vel = new force
      steer.setMag(maxSpeed);
      steer.sub(this.vel);
      
      steer.limit(maxSteer);
      return steer;
   
    }
    
    return steer;   
    
  }
  
  
  PVector cohesion(Boid b[]){
    
   
    float perception =100;
    PVector steer = new PVector(0,0);
    float total = 0;
    
    for(Boid other : b){
        
        
        float dist = PVector.dist(other.position, this.position);
         if(other != this && dist<perception){
          steer.add(other.position);
          total = total+1;
           }
                
        }
    
        if(total >0){
            steer.div(total); //av position
            steer.sub(this.position);
            steer.setMag(maxSpeed);
            steer.sub(this.vel);
            
            steer.limit(maxSteer);
            return steer;
         
          }
        
        return steer;   
        
   }
   
   
   
   
   
    PVector avoidance(Boid b[]){
    
   
    float perception =100;
    PVector steer = new PVector(0,0);
    float total = 0;
    
    for(Boid other : b){
        
        
        float dist = PVector.dist(other.position, this.position);
         if(other != this && dist<perception){
           
              PVector diff = new PVector();
              diff = PVector.sub(this.position, other.position);
              diff.div(dist);
             
              steer.add(diff);
              total = total+1;
           }
                
        }
    
        if(total >0){
            steer.div(total); //av position
         
            steer.setMag(maxSpeed);
            steer.sub(this.vel);
            
            steer.limit(maxSteer);
            return steer;
         
          }
        
        return steer;   
        
   }
  
  
  
  
  void flocking(Boid b[]){
    this.acc.set(0,0);
    PVector alignment = align(b);
    PVector seperation = avoidance(b);    
    PVector cohesion = cohesion(b);
    this.acc.add(cohesion);
    this.acc.add(alignment);
    this.acc.add(seperation);


    
    
    
  }
  
}
  
  





Boid b[] = new Boid[300];


void setup(){

  size(600,600);
  background(0);
  for(int i=0; i<b.length;i++){
    b[i] = new Boid();
  }
 
  
}








void draw(){
   
  clear();
   for(int i = 0; i< b.length; i++){
     b[i].coll();
     b[i].show();
     b[i].update();
     b[i].flocking(b);
     
   }
 
  
}
