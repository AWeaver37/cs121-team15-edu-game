//
//  LevelRecord.h
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Alden Weaver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LevelRecordScene.h"

@interface LevelRecord : NSObject

/* Members */

// The number of questions the user has gotten correct
@property (nonatomic) int questionsCorrect;

// The total number of questions the user has answered
@property (nonatomic) int questionsAttempted;

// A value that corresponds to the amount of health the user has left
@property (nonatomic) int health;

// The amount of time the user took to finish the levels
@property (nonatomic) int time;

// Added
// The user's score for the level
@property (nonatomic) int levelScore;

// Added
// The message displayed on the console bar
@property (nonatomic) NSString* consoleMessage;

// The view for the LevelRecord
//property LevelRecordView* view;


/* Getters */

// Returns the number of questions the user has gotten correct
- (int)getQuestionsCorrect;

// Returns the total number of questions the user has answered
- (int)getQuestionsAttempted;

// Returns a value that corresponds to the amount of health the use has left
- (int)getHealth;

// Returns the amount of time the user took to finish the levels
- (int)getTime;

// Returns the user's score for the level
- (int)getLevelScore;

// Returns the console message
- (NSString*)getConsoleMessage;


/* Setters */

// Sets the number of questions the user has gotten correct
- (void)setQuestionsCorrect:(int)questionsCorrect;

// Sets the total number of questions the user has answered
- (void)setQuestionsAttempted:(int)questionsAttempted;

// Sets a value that corresponds to the amount of health the use has left
- (void)setHealth:(int)health;

// Sets the amount of time the user took to finish the levels
- (void)setTime:(int)time;

// Sets the user's score for the level
- (void)setLevelScore:(int)levelScore;

// Sets the console message
- (void)setConsoleMessage:(NSString*)consoleMessage;


/* Other Methods */

// Calculates a user's score and health when the main controller tells
// the LevelRecord object a shot has been fired, then calls updateScore()
// and updateHealth() to update them.
- (void)calcUpNewStats:(bool)shotSuccessful;

// Updates a user's score for the current level
- (int)updateScore:(int)pointsToAdd;

// Updates a user's health for the current level
- (int)updateHealth:(int)amountToChange;


@end
