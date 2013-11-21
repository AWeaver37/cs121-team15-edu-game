//
//  LevelRecordScene.h
//  LinEqGame.LevelRecord
//

//  Copyright (c) 2013 CS121. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface LevelRecordScene : SKScene

/* Members */

// Keeps track of the user's score for the level
@property (nonatomic) NSObject *scoreCounter;

// Keeps track of the time remaining to complete the level
@property (nonatomic) NSObject *timeCounter;

// An SKShapeNode that is the health bar and will change size based
// on the size of the NSArray healthBar
@property (nonatomic) SKShapeNode *healthBarNode;

// An array where each index corresponds to a section of the health bar.
// The value is true if the section remains and false if it has been depleted.
// This is the numerical representation of how much of the healthBarNode to show.
@property (nonatomic) NSArray *healthBar;

// Keeps track of which index of the healthBar currently represents the top
// of the user's health level
@property (nonatomic) int currentHealth;

// Displays instructions to the viewer in a bar located
// on the bottom of the game screen
// These instructions are stored in the NSString consoleMessage
// member of the LevelRecord.
@property (nonatomic) NSObject *consoleBar;


@property (nonatomic) CGRect bounds;

@property (nonatomic) SKCropNode *gamePlayNode;

@property (nonatomic) SKCropNode *gameControlNodes;


/* Methods */

// Calculates the currentHealth based on the first true index in healthBar
// Note: does not update currentHealth, but can easily be changed to if desired.
// Use: currentHealth = calcCurrentHealth();
- (int)calcCurrentHealth;

- (int)getCurrentHealth;

- (void)setCurrentHealth:(int)currentHealth;

@end
