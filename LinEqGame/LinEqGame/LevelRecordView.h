//
//  LevelRecordView.h
//  LinEqGame
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelRecordView : UIView

/* Members */

// Keeps track of the user's score for the level
NSObject scoreCounter;

// Keeps track of the time remaining to complete the level
NSObject timeCounter;

// An array where each index corresponds to a section of the health bar.
// The value is true if the section remains and false if it has been depleted.
boolean[] healthBar;

// Added
// Keeps track of which index of the healthBar currently represents the top
// of the user's health level 
int currentHealth;

// Added
// Displays instructions to the viewer in a bar located
// on the bottom of the game screen
// These instructions are stored in the NSString consoleMessage
// member of the LevelRecord.
NSObject consoleBar;


/* Methods */

// Calculates the currentHealth based on the first true index in healthBar
// Note: does not update currentHealth, but can easily be changed to if desired.
// Use: currentHealth = calcCurrentHealth();
- (int)calcCurrentHealth;


@end
