//
//  LevelRecord.m
//  LinEqGame
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "LevelRecord.h"

@implementation LevelRecord

/* Methods */

// Updates a user's score for the current level
- (int)updateScore:(int)pointsToAdd {
    levelScore = levelScore + pointsToAdd;
    return levelScore;
}

// Updates a user's health for the current level
- (int)updateHealth:(int)amountToChange {
    health = health + amountToChange;
    return health;
}

@end
