//
//  AnswerChoice.m
//  LinEqGame
//
//  Created by CS121 on 11/17/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "AnswerChoice.h"

@implementation AnswerChoice

- (id)initWithChoices: (NSArray*) choices withAnswerIndex: (int) index
{
    self = [super init];
    if (self) {
        _answerChoices = choices;
        _answerIndex = index;
    }
    return self;
}

- (Fraction*) answerAt: (int) index{
    assert(index>=0&&index<3);
    return _answerChoices[index];
}

- (NSString*) description{
    NSString* string = [NSString stringWithFormat:@"%@[%d]", _answerChoices, _answerIndex];
    return [string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
}



@end
