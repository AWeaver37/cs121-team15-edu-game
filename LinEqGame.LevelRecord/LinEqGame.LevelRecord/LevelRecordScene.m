//
//  LevelRecordScene.m
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/20/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

// LOGIC (Controller)

#import "LevelRecordScene.h"
#import "LevelRecord.h"

#import "LevelRecordNode.h"
#import "HealthBarNode.h"

@implementation LevelRecordScene

// Set the length of the health bar
// This is equivalent to the number of questions in the level
static const int HEALTH_BAR_LENGTH = 10;


/* Methods */

// Constructor
- (id)init {
    return [super init];
}


// Initializes all the objects in the LevelRecordScene
- (void)createLevelRecordScene {
    _levelRecordNode = [[LevelRecordNode alloc] init];
    [self createhealthBar];
    
}


// Initialize healthBar, the array of HealthBarNodes
- (void)createhealthBar {
    
    // Initial currentHealth will be the length of the healthBar array
    _currentHealth = HEALTH_BAR_LENGTH;
    
    // Initialize the numeric representation of the health bar
    _healthBar = [self createHealthBarNodes];

    
}

// Generate the int array where 1 represents true and 0 represents false
// Admitted temporary hard coding hack
- (HealthBarNode*)createHealthBarNodes {
    _healthBar = [[HealthBarNode alloc] init];
    
    // Initialize each node
    for(int i = 0; i < HEALTH_BAR_LENGTH; i++) {
        [self setHealthValueAtIndex:i ToValue:1]; // all values are true to begin
    }
    
    return _healthBar;
}


// Calculates the currentHealth based on the first index that's
// represented by a 1 (true) in healthBarInts
// Note: does not update currentHealth, but can easily be changed to if desired.
// Use: currentHealth = calcCurrentHealth();
- (int)calcCurrentHealth {
    for (NSInteger top = HEALTH_BAR_LENGTH; top >= 0; --top) {
        while(top == _healthBar.next.index) {
            if (_healthBar.value == 1) {
                return top;
            }
            
            // If none of the values in healthBar are true, return a -1 to indicate
            // that the healthBar is empty
            else {
                return -1;
            }
        }
    }
    return 1;
}

// Calculates a user's score and health when the main controller tells
// the LevelRecord object a shot has been fired, then calls updateScore()
// and updateHealth() to update them.
- (void)calcUpdateNewStats:(bool)shotSuccessful {
    
    // If the shot is successful, give the player points
    // and do not change their health level
    if (shotSuccessful) {
        [self updateScore:100]; // TO DO: change, not magic number
        _levelRecordNode.consoleMessageLabel.text = @"HIT! Well done!";
        _levelRecordNode.scoreLabel.text = [NSString stringWithFormat:@"%d", _currentScore];
    }
    
    // If the shot is not successful, do not give the player points
    // and subtract from their health level
    else {
        [self updateScore:0];
        [self updateHealth:-1];
        _levelRecordNode.consoleMessageLabel.text = @"MISS! Try a new question!";
    }
}

// Updates a user's score for the current level
- (void)updateScore:(int)pointsToAdd {
    _currentScore += pointsToAdd;

}

// Updates a user's health for the current level
- (void)updateHealth:(int)amountToChange {
    
    // Reflect the health change numerically
    _currentHealth += amountToChange;
    
    // Reflect the health change pictorally on the LevelRecordView's health bar array:
    
    // If the user's health is being depleted, change the health bar to have one less green box
    if (amountToChange < 0) {
        for(int i = 0; i >= amountToChange; --i) {
            [self setHealthValueAtIndex:_currentHealth + i ToValue:0]; // set value to false
            [self setFillColorAtIndex:_currentHealth + i ToFillColor:[SKColor clearColor]]; // set color to clear
            --_currentHealth;
        }
    }
    
    // If the user's health is increasing,
    // Note: In our current version, we are only subtracting from the user's
    // health when they get a question wrong and not adding to the user's health
    // if they get the question correct. However, this case was added for extensibility
    // and to ensure the function will work with both negative and positive inputs.
    else {
        for(int j = 0; j <= amountToChange; ++j) {
            [self setHealthValueAtIndex:_currentHealth + 1 ToValue:1]; // set value to true
            [self setFillColorAtIndex:_currentHealth + 1 ToFillColor:[SKColor greenColor]]; // set color to green
            ++_currentHealth;
        }
    }
}

- (int)getHealthValueAtIndex:(int)index {
    for(int i = 0; i < HEALTH_BAR_LENGTH; ++i) {
        if(i == index){
            return _healthBar.value; // ?
        }
    }
    return -1; // indicates an invalid index
}

- (void)setHealthValueAtIndex:(int)index ToValue:(int)value {
    for(int i = 0; i < HEALTH_BAR_LENGTH; ++i) {
        if(_healthBar.index == i) {
            _healthBar.value = value; // ?
            _healthBar = _healthBar.next;
        }
    }
}

- (void)setFillColorAtIndex:(int)index ToFillColor:(SKColor*)fillColor {
    for(int i = 0; i < HEALTH_BAR_LENGTH; ++i) {
        if(_healthBar.index == i) {
            _healthBar.fillColor = fillColor; // ?
            _healthBar = _healthBar.next;
        }
    }
}




/* Pre-Written Functions */

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        LevelRecordNode * levelRecordNode = [[LevelRecordNode alloc] init];
        [levelRecordNode createAllBars];
        [self addChild:myLabel];
        [self addChild:levelRecordNode];

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
