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

@property NSArray* answerChoices;

@property int answerIndex;

@end
