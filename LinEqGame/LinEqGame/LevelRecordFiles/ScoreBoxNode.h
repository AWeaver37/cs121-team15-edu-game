//
//  ScoreBoxNode.h
//  LinEqGame
//
//  Created by CS121 on 12/2/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "BarBoxNodeBase.h"

@interface ScoreBoxNode : BarBoxNodeBase

/* PROPERTIES */


// The total number of questions for the round
@property int totalQuestions;

// The number of questions the user has gotten correct
@property int questionsCorrect;

// The number of questions the user has answered so far
@property int questionsAnswered;

// The current score
@property int currentScore;

// The ratio at which the user will lose
@property CGFloat lossRatio;

// Indicates whether the game has been lost
@property bool gameLost;

// The score label's horizontal and vertical allignments
@property (nonatomic) SKLabelHorizontalAlignmentMode horizAlignScore;
@property (nonatomic) SKLabelVerticalAlignmentMode vertAlignScore;


/* METHODS */

// Constructor
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y WithColor:(SKColor*)c
           LineWidth:(CGFloat)lW TotalQuestions:(int)tQ AndLossRatio:(CGFloat)lR;

// Creates the score label
- (void)createScoreLabel;

// Updates a user's score for the current level
- (void)updateScore:(int)pointsToAdd;

// Calculates a user's score and health when the main controller tells
// the LevelRecord object a shot has been fired, then calls updateScore()
// and updateHealth() to update them.
- (void)calcUpdateNewScore:(bool)shotSuccessful;

// Resets the scoreBoxNode
- (void)reset;

@end
