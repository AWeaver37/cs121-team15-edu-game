//
//  QuestionObject.h
//  LinEqGame
//
//  Created by CS121 on 11/15/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"
#import "AnswerChoice.h"

@interface QuestionObject : NSObject

-(Fraction*) slopeAt:(int) index;

-(Fraction*) interceptAt:(int) index;

//Slope answer choices
@property AnswerChoice* slopeAnswer;

//Intercept answer choices
@property AnswerChoice* interceptAnswer;

//Array of Location variables
@property NSMutableArray* enemyLocations;

@end
