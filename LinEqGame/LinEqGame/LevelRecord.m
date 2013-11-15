//
//  LevelRecord.m
//  LinEqGame
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "LevelRecord.h"

@implementation LevelRecord


/* Getters */

// Returns the number of questions the user has gotten correct
- (int)getQuestionsCorrect {
    return questionsCorrect;
}

// Returns the total number of questions the user has answered
- (int)getQuestionsAttempted {
    return questionsAttempted;
}

// Returns a value that corresponds to the amount of health the use has left
- (int)getHealth {
    return health;
}

// Returns the amount of time the user took to finish the levels
- (int)getTime {
    return time;
}

// Returns the user's score for the level
- (int)getLevelScore {
    return levelScore;
}

// Returns the console message
- (NSString) getConsoleMessage {
    return consoleMessage;
}


/* Setters */

// Sets the number of questions the user has gotten correct
- (void)setQuestionsCorrect:(int)questionsCorrect {
    self.questionsCorrect = questionsCorrect;
}

// Sets the total number of questions the user has answered
- (void)setQuestionsAttempted:(int)questionsAttempted {
    self.questionsAttempted = questionsAttempted;
}

// Sets a value that corresponds to the amount of health the use has left
- (void)setHealth:(int)health {
    self.health = health;
}

// Sets the amount of time the user took to finish the levels
- (void)setTime:(int)time {
    self.time = time;
}

// Sets the user's score for the level
- (void)setLevelScore:(int)levelScore {
    self.levelScore = levelScore;
}

// Sets the console message
- (void)setConsoleMessage:(NSString)consoleMessage {
    self.consoleMessage = consoleMessage;
}


/* Other Methods */

// Calculates a user's score when the main controller tells
// the LevelRecord object a shot has been fired
- (int)calculateScore:(boolean)shotSuccessful {
    
    // If the shot is successful, give the player points
    if (shotSuccessful) {
        updateScore(100); // TO DO: change, not magic number
    }
    
    // If the shot is not successful, do not give the player points
    else {
        updateScore(0);
    }
}

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
