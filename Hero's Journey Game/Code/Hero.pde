class Hero extends Sprite {
  PImage spriteImgLeft, spriteImgRight, spriteImgFront, spriteImgDie;
  int speed;
  float gravity, velocity;
  boolean onGround,isPaused;
  int pauseTime, pauseStartTime; 

  /**
  * Hero(Coordinate position, int spriteWidth, int spriteHeight, int speed, float gravity)
  * 
  * This method is the constructor of the Hero class which extends the Sprite class
  *
  * @param - Coordinate position: Coordinate object of the position of the Hero
  *          int spriteWidth: Integer value of the width of the Hero
  *          int spriteHeight: Integer value of the height of the Hero
  *          int speed: Integer value of the current speed of the Hero
  *          float gravity: Integer value that acts as the pull of gravity
  * @return - none
  */
  Hero(Coordinate position, int spriteWidth, int spriteHeight, int speed, float gravity) {
    super(position, spriteWidth, spriteHeight);
    this.speed = speed;
    this.gravity = gravity;
    this.velocity = 0;
    this.onGround = false;
    this.isPaused = false; // Initialize pause state
    this.pauseTime = 0;    // Initialize pause duration
    this.pauseStartTime = 0; // Initialize pause start time

    this.spriteImgFront = loadImage("CharacterImages/Level1/front.png");
    this.spriteImgLeft = loadImage("CharacterImages/Level1/left.png");
    this.spriteImgRight = loadImage("CharacterImages/Level1/right.png");
    this.spriteImgDie = loadImage("CharacterImages/Level1/die.png");
    this.spriteImg = spriteImgFront;
  }

  /**
  * void handleMovement(int canvasWidth, boolean leftPressed, boolean rightPressed)
  * 
  * This method handles the changing of velocity when it comes to movement as well
  * as changing the sprite image of the hero when it moves
  * 
  * @param - int canvasWidth: Integer value for the width of the canvas
  *          boolean leftPressed: Boolean value to determine if the left key is pressed
  *          boolean rightPressed: Boolean value to determine if the right key is pressed
  * @return - void
  */
  void handleMovement(int canvasWidth, boolean leftPressed, boolean rightPressed) {
    // Only handle movement if not paused
    if (!isPaused) {
      if (leftPressed) {
        position.x = max(0, position.x - speed);
        this.spriteImg = spriteImgLeft;
      } else if (rightPressed) {
        position.x = min(canvasWidth - spriteWidth, position.x + speed);
        this.spriteImg = spriteImgRight;
      } else {
        this.spriteImg = spriteImgFront;
      }
    }
  }

  /**
  * void applyGravity()
  *
  * This method adds gravity to the characters movements
  *
  * @param - none
  * @return - void
  */
  void applyGravity() {
    if (!onGround) {
      position.y += velocity;
      velocity += gravity;
    }
  }

  /**
  * void pause(int time)
  * 
  * This method is a way to pause the character
  *
  * @param - int time: Integer value for the amount of time for the character to be paused
  * @return - void
  */
  void pause(int time) {
    isPaused = true; // Set pause state to true
    pauseTime = time; // Set the duration for the pause
    pauseStartTime = millis(); // Record the start time of the pause
  }

  /**
  * void update()
  *
  * This updates the pause method if the timer is up
  *
  * @param - none
  * @return - void
  */
  void update() {
    // Check if the pause duration has elapsed
    if (isPaused && millis() - pauseStartTime >= pauseTime) {
      isPaused = false; // Resume movement after the pause
    }
  }

  /**
  * void jump()
  *
  * Updates the necessary values to jump the character
  *
  * @param - none
  * @return - void
  */
  void jump() {
    if (onGround && !isPaused) {
      velocity = -12;
      onGround = false;
    }
  }

  /**
  * boolean isJumping()
  *
  * Checks if the characters velocity is less than 0 meaning the
  * character is in the air by moving
  *
  * @param - none
  * @return - boolean of if the character is jumping
  */
  boolean isJumping() {
    return velocity < 0;
  }
  
  /**
  * void dieFromEnemy()
  * 
  * This method is the method called when the hero dies 
  * specifically from the enemy. Meaning the hero pauses and
  * the character sprite changes to the death image
  *
  * @param - none
  * @return - void
  */
  void dieFromEnemy() {
    spriteImg = spriteImgDie; // Change to die image
    isPaused = true;          // Stop all movements
    isHeroDead = true;        // Set the hero's death flag
    currTime = millis();      // Record the time of death
  }
  
  /**
  * void die(boolean showDieImage)
  * 
  * This method is to kill the hero
  * 
  * @param - boolean showDieImage: boolean value to see if the die image is to be displayed
  * @return - void
  */
  void die(boolean showDieImage) {
    if (showDieImage) {
        spriteImg = spriteImgDie;  // Display die image on death by enemy
    }
    isPaused = true;  // Stop all movements
    isHeroDead = true;  // Set the hero's death flag
    currTime = millis();  // Record the time of death
  }

  /**
  * void revive()
  * 
  * This method is to respawn the character after the character dies
  *
  * @param - none
  * @return - void
  */
  void revive() {
    position = new Coordinate(currentLevel.grounds[0].position.x, currentLevel.grounds[0].position.y - 75); // Reset to start position
    velocity = 0;  // Reset velocity
    isPaused = false;  // Resume movements
    isHeroDead = false;  // Clear the death flag
    spriteImg = spriteImgFront;  // Reset to default image
    collidedWithEnemy = false;  // Clear collision flag
  }
  
  /**
  * void setImage(int levelNumber)
  * 
  * This method sets the current image of the character. It changes
  * depending on the level
  *
  * @param - int levelNumber: Integer of which level the character is on
  * @return - void
  */
  void setImage(int levelNumber) {
      if(levelNumber == 1){
        this.spriteImgFront = loadImage("CharacterImages/Level1/front.png");
        this.spriteImgLeft = loadImage("CharacterImages/Level1/left.png");
        this.spriteImgRight = loadImage("CharacterImages/Level1/right.png");
        this.spriteImgDie = loadImage("CharacterImages/Level1/die.png");
      }else if (levelNumber == 2) {
        this.spriteImgFront = loadImage("CharacterImages/Level2/front.png");
        this.spriteImgLeft = loadImage("CharacterImages/Level2/left.png"); // Change with new image
        this.spriteImgRight = loadImage("CharacterImages/Level2/right.png"); // Change with new image
        this.spriteImgDie = loadImage("CharacterImages/Level2/die.png");
      } else if (levelNumber == 3) {
        this.spriteImgFront = loadImage("CharacterImages/Level3/front.png");
        this.spriteImgLeft = loadImage("CharacterImages/Level3/left.png"); 
        this.spriteImgRight = loadImage("CharacterImages/Level3/right.png");
        this.spriteImgDie = loadImage("CharacterImages/Level3/die.png");
      }
  } 

  /**
  * void land(int groundLevel)
  *
  * This method lands the character on the ground
  *
  * @param - int groundLevel: Integer value of the ground level
  * @return - void
  */
  void land(int groundLevel) {
    position.y = groundLevel;
    velocity = 0;
    onGround = true;
  }
}
