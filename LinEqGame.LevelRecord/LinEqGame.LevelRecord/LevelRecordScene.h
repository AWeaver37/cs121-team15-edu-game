//
//  LevelRecordScene.h
//  LinEqGame.LevelRecord
//

//  Copyright (c) 2013 CS121. All rights reserved.
//

// LOGIC (Controller)

#import <SpriteKit/SpriteKit.h>

@class HealthBarNode;
@class LevelRecordNode;
@interface LevelRecordScene : SKScene

/* Members */

// An array where each index corresponds to a section of the health bar.
// These sections are represented by HealthBarNodes.
// Their value is true if the section remains and false if it has been depleted.
// This is the pictoral representation of the healthBar.
@property (nonatomic) HealthBarNode *healthBar;

// Keeps track of which index of the healthBar currently represents the top
// of the user's health level
@property (nonatomic) int currentHealth;

// Keeps track of how many questions the user has answered
@property (nonatomic) int currentQuestionsAnswered;

// Keeps track of how many questions the user has gotten correct
@property (nonatomic) int currentQuestionsCorrect;

// Keeps track of the user's current score
@property (nonatomic) int currentScore;

// The LevelRecordNode corresponding to this LevelRecordScene
@property LevelRecordNode *levelRecordNode;



/* Methods */


// Calculates the currentHealth based on the first true index in healthBar
// Note: does not update currentHealth, but can easily be changed to if desired.
// Use: currentHealth = calcCurrentHealth();
- (int)calcCurrentHealth;

// Updates a user's score for the current level
- (void)updateScore:(int)pointsToAdd;

// Updates a user's health for the current level
- (void)updateHealth:(int)amountToChange;

// Calculates a user's score and health when the main controller tells
// the LevelRecord object a shot has been fired, then calls updateScore()
// and updateHealth() to update them.
- (void)calcUpdateNewStats:(bool)shotSuccessful;

// Returns the value of the health node at the specified index on the healthBar
- (int)getHealthValueAtIndex:(int)index;

// Sets the value of the health node at the specified index on the healthBar
- (void)setHealthValueAtIndex:(int)index ToValue:(int)value;

// Sets the fillColor of the health node at the specified index on the healthBar
- (void)setFillColorAtIndex:(int)index ToFillColor:(SKColor*)fillColor;


@end
