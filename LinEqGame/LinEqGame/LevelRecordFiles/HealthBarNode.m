//
//  HealthBarNode.m
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/21/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

#import "HealthBarNode.h"

@implementation HealthBarNode

// Create getter and setter for public properties
@synthesize isDefeated;

/* PROPERTIES */

// Keeps track of the user's current health
int currentHealth;

// Keeps track of the total number of questions
CGFloat totalQuestions;

// Keeps track of how much to decrease the height by
CGFloat healthIncrement;

BarBoxNodeBase* internalBar;


/* METHODS */

// Constructor
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y
           WithLineWidth:(CGFloat)lW AndTotalQuestions:(int)q {
    // Initialize the bar and set its dimensions and position
    self = [super initWithHeight:h Width:w AtX:x Y:y WithColor:[SKColor clearColor] AndLineWidth:lW];
    
    // Initialize the internal bar
    internalBar = [[BarBoxNodeBase alloc] initWithHeight:self.height Width:self.width
                                                  AtX:0 Y:0 WithColor:[SKColor greenColor] AndLineWidth:0];
    
    isDefeated = NO;
    
    // Set the totalQuestions and currentHealth equal to the total questions
    totalQuestions = q;
    currentHealth = q;
    
    healthIncrement = self.height/totalQuestions;
    
    [self addChild:internalBar];
    
    return self;
}

// Increases the user's health by 1 and changes the appearance of the health bar
- (void)incrementHealth {
    [self changeHealth:1];

}

// Decreases the user's health by 1 and changes the appearance of the health bar
- (void)decrementHealth {
    [self changeHealth:-1];
}

// Can either increment or decrement the health by a specified amount
- (void)changeHealth:(int)amountToChange {
    // Reflect the health change numerically
    currentHealth += amountToChange;
    
    // Cap the health on both ends
    if(currentHealth > totalQuestions) {
        currentHealth = totalQuestions;
    }
    
    if(currentHealth < 0) {
        currentHealth = 0;
    }
    
    // Reflect the health change pictorally
    
    // Change the health bar's color
    //[self setHealthBarColor];
    
    // Set the new height
//    internalBar.height = 0;
    
    // Remove and re-add internal bar so its shape will change
    [internalBar removeFromParent];
    internalBar = [[BarBoxNodeBase alloc] initWithHeight:healthIncrement * currentHealth Width:self.width
                                                  AtX:0 Y:0 WithColor:[self getHealthBarColor] AndLineWidth:0];
    [self addChild:internalBar];
}

// Sets the color of the health bar and returns the new height
- (SKColor*)getHealthBarColor {
    
    CGFloat healthRatio = currentHealth/totalQuestions;
    
    // If the question ratio is less than or equal to 0,
    // get rid of the healthBar and set isDefeated to true
    if (currentHealth == 0) {
        isDefeated = YES;
        return [SKColor clearColor];
    }
    
    // If the question ratio is < 1/4, change the color to red
    if (healthRatio <= (CGFloat)1/4) {
        return [SKColor redColor];
    }
    
    // If the question ratio is < 1/3, change the color to yellow
    if (healthRatio <= (CGFloat)1/3) {
        return [SKColor yellowColor];
    }
    
    // Else the health bar will stay green
    return [SKColor greenColor];
}


// Resets the health bar
- (void)reset {
    // Reset the currentHealth
    currentHealth = totalQuestions;

    // Remove and re-add internal bar to reset it
    [internalBar removeFromParent];
    internalBar = [[BarBoxNodeBase alloc] initWithHeight:self.height Width:self.width
                                                  AtX:0 Y:0 WithColor:[SKColor greenColor] AndLineWidth:0];
    [self addChild:internalBar];
    
    // Reset isDefeated
    isDefeated = NO;
}

@end
