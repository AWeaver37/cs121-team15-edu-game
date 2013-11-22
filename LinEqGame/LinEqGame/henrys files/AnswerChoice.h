//
//  AnswerChoice.h
//  LinEqGame
//
//  Created by CS121 on 11/17/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"

@interface AnswerChoice : NSObject

- (id)initWithChoices: (NSArray*) choices withAnswerIndex: (int) index;

// The three answer choices
@property NSArray* answerChoices;

// The index of the correct answer from 0 to 2.
@property int answerIndex;

@end
