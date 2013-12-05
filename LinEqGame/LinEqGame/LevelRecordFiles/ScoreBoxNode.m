//
//  ScoreBoxNode.m
//  LinEqGame
//
//  Created by CS121 on 12/2/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "ScoreBoxNode.h"

@implementation ScoreBoxNode

// Create getters and setters
@synthesize totalQuestions, questionsCorrect, questionsAnswered, currentScore, lossRatio, gameLost;

/* PROPERTIES */

// The score label
SKLabelNode *scoreLabel;

// The question ratio label
SKLabelNode *questionRatioLabel;


/* METHODS */

// Constructor
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y WithColor:(SKColor*)c
           LineWidth:(CGFloat)lW TotalQuestions:(int)tQ AndLossRatio:(CGFloat)lR {
    // Initialize the bar and set its dimensions and position
    self = [super initWithHeight:h Width:w AtX:x Y:y WithColor:c AndLineWidth:lW];
    
    totalQuestions = tQ;
    lossRatio = lR;
    questionsAnswered = 0;
    questionsCorrect = 0;
    currentScore = 0;
    gameLost = false;
    
    // Create the label for the score
    [self createScoreLabel];
    
    // Create the label for the question ratio
    [self createQuestionRatioLabel];
    
    // Add score label to the score box node
    [self addChild:scoreLabel];
    
    // Add question ratio label to the score box node
    [self addChild:questionRatioLabel];
    
    return self;
}


// Calculates a user's score when the main controller tells
// the node a shot has been fired, then calls updateScore()
// to update the score.
- (void)calcUpdateNewScore:(bool)shotSuccessful {
    
    // If the shot is successful, give the player points
    // and do not change their health level
    if (shotSuccessful) {
        [self updateScore:100]; // TO DO: change, not magic number
        //_levelRecordNode._consoleMessageLabel.text = @"HIT! Well done!";
        scoreLabel.text = [NSString stringWithFormat:@"%d", self.currentScore];
    }
    
    // If the shot is not successful, do not give the player points
    // and subtract from their health level
    else {
        [self updateScore:0];
        //[self updateHealth:-1];
        //_levelRecordNode.consoleMessageLabel.text = @"MISS! Try a new question!";
    }
    
    // Check if the game has been lost
    [self checkForLoss];
}

// Updates a user's score for the current level
- (void)updateScore:(int)pointsToAdd {
    self.currentScore += pointsToAdd;
    
}

// Creates the score label
- (void)createScoreLabel {
    
    // Create the label node
    scoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    scoreLabel.fontColor = [SKColor blackColor];
    scoreLabel.fontSize = 20;

    scoreLabel.text = [NSMutableString stringWithFormat:@"%d", currentScore];
    //scoreLabel.position = CGPointMake(175, 5);
    
    CGSize stringsize = [scoreLabel.text
                         sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:scoreLabel.fontSize]}];
    [scoreLabel setPosition:CGPointMake((self.width - stringsize.width)/2, (self.height - stringsize.height)/2 + 15)];
    
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight + 50;
    scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;

    
}

// Creates the question ration label
- (void)createQuestionRatioLabel {
    
    // Create the label node
    questionRatioLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    questionRatioLabel.fontColor = [SKColor blackColor];
    questionRatioLabel.fontSize = 20;
    
    questionRatioLabel.text = [NSMutableString stringWithFormat:@"%d / %d", questionsCorrect, totalQuestions];
    //scoreLabel.position = CGPointMake(175, 5);
    
    CGSize stringsize = [questionRatioLabel.text
                         sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:questionRatioLabel.fontSize]}];
    [questionRatioLabel setPosition:CGPointMake((self.width - stringsize.width)/2, (self.height - stringsize.height)/2 + 10) ];
    
    questionRatioLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight + 50;
    questionRatioLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    
    
}

// Checks if the score is a losing score
- (void)checkForLoss {
    if (questionsCorrect / questionsAnswered <= lossRatio) {
        gameLost = true;
    }
}

// Resets the scoreBoxNode
- (void)reset {
    questionsAnswered = 0;
    questionsCorrect = 0;
    currentScore = 0;
    gameLost = false;
}


@end
