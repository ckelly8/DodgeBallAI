class Population {
   Hero[] heroes;
   
   Hero bestHero;
  
   int gen = 0;
   
   float fitnessSum;
   float bestFitness = 0;
  
   Population(int size) {
       heroes = new Hero[size];
       for(int i=0; i<size; i++) {
          heroes[i] = new Hero(); 
       }
       bestHero = heroes[0];
   }
   /*
   void show() {
     if(!replayBest) {
        for(int i=0; i<heroes.length; i++) {
           heroes[i].show(); 
        }
     } else {
        bestHero.show(); 
        bestHero.brain.show(10,height-160,200,150,bestHero.vision,bestHero.decision);
     }
   }*/
   
   void update() {
     if(!bestHero.dead) {
        bestHero.look();
        bestHero.think();
        bestHero.move();
     }
     for(int i=0; i<heroes.length; i++) {
        if(!heroes[i].dead) {
           heroes[i].look();
           heroes[i].think();
           heroes[i].move(); 
        }
     }
   }
   
   boolean done() {
      for(int i=0; i<heroes.length; i++) {
         if(!heroes[i].dead) {
            return false; 
         }
      }
      if(!bestHero.dead) {
         return false; 
      }
      return true;
   }
   
   void calculateFitness() {
     fitnessSum = 0;
     for(int i=0; i<heroes.length; i++) {
        fitnessSum += heroes[i].calculateFitness(); 
     }
   }
   
   void setBestDoodle() {
      int bestIndex = 0;
      float best = 0;
      for(int i=0; i<heroes.length; i++) {
          if(heroes[i].fitness > best) {
             best = heroes[i].fitness;
             bestIndex = i;
          }
      }
      if(best > bestFitness) {
        bestFitness = best;
        bestHero = heroes[bestIndex].cloneReplay();
        bestHero.replay = true;
        println("Gen "+gen+" Best Fitness "+bestFitness);
      } else {
        bestHero = bestHero.cloneReplay(); 
      }
   }
   
   Hero selectHero() {
      float rand = random(fitnessSum);
      float runSum = 0;
      for(int i=0; i<heroes.length; i++) {
        runSum += heroes[i].fitness;
        if(runSum > rand) {
            return heroes[i];
        }
      }  
      return heroes[0];
   }
   
   void naturalSelection() {
        setBestDoodle();
        
        Hero[] newHeroes = new Hero[heroes.length];
        newHeroes[0] = bestHero.clone();
        for(int i=1; i<newHeroes.length; i++) {
            Hero child = selectHero().breed(selectHero());
            child.mutate();
            newHeroes[i] = child;
            
        }
        heroes = newHeroes.clone();
        gen+=1;
     
   }  
   
}
