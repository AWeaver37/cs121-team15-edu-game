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

@interface LevelRecordLog : NSObject

/* PROPERTIES */

// The number of questions the user has gotten correct
@property (nonatomic) int levelQuestionsCorrect;

// The total number of questions the user has answered
@property (nonatomic) int levelQuestionsAttempted;

// The total number of questions for the level
@property (nonatomic) int totalLevelQuestions;

// A value that corresponds to the amount of health the user has left
@property (nonatomic) int levelHealth;

// The amount of time the user took to finish the level
@property (nonatomic) int levelTime;

// The user's score for the level
@property (nonatomic) int levelScore;




/* METHODS */

- (void)setTotalLevelQuestions;

@end
