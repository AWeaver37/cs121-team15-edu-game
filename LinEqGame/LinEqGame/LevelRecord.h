//
//  LevelRecord.h
//  LinEqGame
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelRecord : NSObject

/* Members */

// The number of questions the user has gotten correct
int questionsCorrect;

// The total number of questions the user has answered
int questionsAttempted;

// A value that corresponds to the amount of health the use has left
int health;

// The amount of time the user took to finish the levels
int time;

//Added
// The user's score for the level
int levelScore;

// The view for the LevelRecord
LevelRecordView* view;


/* Methods */

// Updates a user's score for the current level
- (int)updateScore:(int)pointsToAdd;

// Updates a user's health for the current level
- (int)updateHealth:(int)amountToChange;

@end
