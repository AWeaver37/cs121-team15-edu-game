//
//  LevelRecordScene.m
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/20/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

#import "LevelRecordScene.h"
#import "LevelRecord.h"


/* "An SKCropNode crops the pixels drawn by its children so that only some of the pixels are rendered to the parent’s framebuffer. To use a crop node, you add child nodes as you would for any other node. Then you set the crop node’s maskNode property to point to another node. When rendered, the crop mask renders its mask node and uses the resulting values to determine which pixels of its children should be rendered to the parent’s framebuffer." - Apple's SpriteKit Programming Guide */



@implementation LevelRecordScene

// Set the length of the health bar
// This is equivalent to the number of questions in the level
static const int HEALTH_BAR_LENGTH = 10;

// Generate the int array where 1 represents true and 0 represents false
// Admitted temporary hard coding hack
- (NSInteger*) createHealthBarInts {
    NSInteger health0 = 1;
    NSInteger health1 = 1;
    NSInteger health2 = 1;
    NSInteger health3 = 1;
    NSInteger health4 = 1;
    NSInteger health5 = 1;
    NSInteger health6 = 1;
    NSInteger health7 = 1;
    NSInteger health8 = 1;
    NSInteger health9 = 1;
    
    _healthBarInts[0] = health0;
    _healthBarInts[1] = health1;
    _healthBarInts[2] = health2;
    _healthBarInts[3] = health3;
    _healthBarInts[4] = health4;
    _healthBarInts[5] = health5;
    _healthBarInts[6] = health6;
    _healthBarInts[7] = health7;
    _healthBarInts[8] = health8;
    _healthBarInts[9] = health9;

    return _healthBarInts;
}

// Initialize the SKShapeNode healthBarNode
- (void)inithealthBar {
    
    // Initialize the numeric representation of the health bar
    [self createHealthBarInts];
       

}

/* Methods */

// Calculates the currentHealth based on the first index that's
// represented by a 1 (true) in healthBarInts
// Note: does not update currentHealth, but can easily be changed to if desired.
// Use: currentHealth = calcCurrentHealth();
- (int)calcCurrentHealth {
    for (int top = HEALTH_BAR_LENGTH; top >= 0; --top) {
        if ([_healthBar objectAtIndex:top = 1]) {
            return top;
        }
    
        // If none of the values in healthBar are true, return a -1 to indicate
        // that the healthBar is empty
        else {
            return -1;
        }
    }
    return 1;
}

- (int)getCurrentHealth {
    return _currentHealth;
}

- (void)setCurrentHealth:(int)currentHealth {
    _currentHealth = currentHealth;
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
