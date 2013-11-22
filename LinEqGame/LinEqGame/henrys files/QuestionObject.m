//
//  QuestionObject.m
//  LinEqGame
//
//  Created by CS121 on 11/15/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "QuestionObject.h"
#include <stdlib.h>

@implementation QuestionObject


- (NSString*) description{
    NSString* string = [NSString stringWithFormat:@"Slope %@\nIntercept %@\nEnemies %@", _slopeAnswer, _interceptAnswer,_enemyLocations];
    return [string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
}



@end
