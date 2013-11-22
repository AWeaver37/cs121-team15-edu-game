//
//  LevelRecord.h
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Alden Weaver. All rights reserved.
//

// DATA (Model)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HealthBarNode.h"

@class LevelRecordScene;
@interface LevelRecord : NSObject

/* Members */

// The number of questions the user has gotten correct
@property (nonatomic) int questionsCorrect;

// The total number of questions the user has answered
@property (nonatomic) int questionsAttempted;

// The total number of questions for the level
@property (nonatomic) int totalLevelQuestions;

// A value that corresponds to the amount of health the user has left
@property (nonatomic) int levelHealth;

// The amount of time the user took to finish the level
@property (nonatomic) int levelTime;

// The user's score for the level
@property (nonatomic) int levelScore;

// The message displayed on the console bar
@property (nonatomic) NSString* consoleMessage;

// The scene for the LevelRecord
@property LevelRecordScene* scene;


/* Methods */
- (void)setTotalLevelQuestions;


@end
