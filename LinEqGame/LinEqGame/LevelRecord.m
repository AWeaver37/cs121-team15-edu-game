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

// Calculates a user's score and health when the main controller tells
// the LevelRecord object a shot has been fired, then calls updateScore()
// and updateHealth() to update them.
- (int)calculateStats:(boolean)shotSuccessful {
    
    // If the shot is successful, give the player points
    // and do not change their health level
    if (shotSuccessful) {
        updateScore(100); // TO DO: change, not magic number
    }
    
    // If the shot is not successful, do not give the player points
    // and subtract from their health level
    else {
        updateScore(0);
        updateHealth(-1);
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
    
    // Reflect the health change on the LevelRecordView's health bar array:
    
    // If the user's health is being depleted, change the health bar to 
    if (amountToChange < 0) {
        for(int i = 0; i >= amountToChange; --i) {
            LevelRecordView.healthBar[LevelRecordView.currentHealth + i] = false;
            --LevelRecordView.currentHealth;
        }
    }
    
    // If the user's health is increasing, 
    // Note: In our current version, we are only subtracting from the user's
    // health when they get a question wrong and not adding to the user's health
    // if they get the question correct. However, this case was added for extensibility
    // and to ensure the function will work with both negative and positive inputs.
    else {
        for(int j = 0; j =< amountToChange; ++j) {
            LevelRecordView.healthBar[LevelRecordView.currentHealth + j] = true;
            ++LevelRecordView.currentHealth;
        }
    }
    
    return health;
}


@end
