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

@property AnswerChoice* slopeAnswer;

@property AnswerChoice* interceptAnswer;

@property NSMutableArray* alienLocations;

@end
