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
static const int HEALTH_BAR_LENGTH = 20;

// Initialize the SKCropNode healthBarNode
// Some of following comments and code have been modified from Apple's SpriteKit Programming Guide
// "When the crop node is rendered, the mask is rendered before the descendants are drawn.
// Only the alpha component of the resulting mask is relevant.
// Any pixel in the mask with an alpha value of 0.05 or higher is rendered. All other pixels are cropped."
- (void)inithealthBar {
    
    // Apple's SpriteKit Programming Guide code
    SKCropNode *healthBarNode = [[SKCropNode alloc] init];
    healthBarNode.position = CGPointMake(CGRectGetMidX(_bounds),
                                  CGRectGetMidY(_bounds));

    healthBarNode.maskNode = [[SKSpriteNode alloc] initWithImageNamed:@"healthBarMask"]; // TODO
    [healthBarNode addChild:_gamePlayNode];
    [self addChild:healthBarNode];
    [self addChild:_gameControlNodes];
    // End Apple's SpriteKit Programming Guide code
    
    
    // Initialize the numeric representation of the health bar
    _healthBar = [[NSArray alloc] init];
    

}

/* Methods */

// Calculates the currentHealth based on the first true index in healthBar
// Note: does not update currentHealth, but can easily be changed to if desired.
// Use: currentHealth = calcCurrentHealth();
- (int)calcCurrentHealth {
//    for (int top = _healthBar.count; top >= 0; --top) {
//        if (_healthBar objectAtIndex:top == true){
//            return top;
//        }
//    
//        // If none of the values in healthBar are true, return a -1 to indicate
//        // that the healthBar is empty
//        else {
//            return -1;
//        }
//    }
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
        
        [self addChild:myLabel];
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
