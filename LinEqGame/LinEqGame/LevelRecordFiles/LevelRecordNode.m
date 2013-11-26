//
//  LevelRecordNode.m
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/20/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

// UI (View)
// Reloaded each question (at least)

#import "LevelRecordNode.h"


@implementation LevelRecordNode

// Constructor
- (id)init {
    return [super init];
}


- (void)createAllBars {
    [self createMessageBar];
    [self createHealthBar];
    [self createStatsBar];
}

- (void)createMessageBar {
    // Set the dimensions
    int messageX = 800;
    int messageY = 75;
    
    // Create the shape node
    SKShapeNode *messageBar = [[SKShapeNode alloc] init];
    CGRect tempRect1 = CGRectMake(0, 0, messageX, messageY);
    CGPathRef messageBarPath = CGPathCreateWithRect(tempRect1, NULL);
    messageBar.path = messageBarPath;
    messageBar.fillColor = [SKColor orangeColor];
    messageBar.lineWidth = 0.25;
    
    // Tell the node where it should go
    int messagePosX = 112;
    int messagePosY = 20;
    messageBar.position = CGPointMake(messagePosX, messagePosY);
    
    // Create the label for the consoleMessage
    [self createMessageLabel];
    
    // Add the consoleMessage to the messageBar node
    [messageBar addChild:_consoleMessageLabel];
    
    // Add the messageBar to the main parent node
    [self addChild:messageBar];

}

- (void)createHealthBar {
    // Set the dimensions
    int healthX = 50;
    int healthY = 600;
    
    // Create the shape node
    _healthBar = [[HealthBarNode alloc] init];
    CGRect tempRect2 = CGRectMake(0, 0, healthX, healthY);
    CGPathRef healthBarPath = CGPathCreateWithRect(tempRect2, NULL);
    _healthBar.path = healthBarPath;
    _healthBar.fillColor = [SKColor greenColor];
    _healthBar.lineWidth = 0.25;
    
    // Tell the node where it should go
    int healthPosX = 10;
    int healthPosY = 115;
    _healthBar.position = CGPointMake(healthPosX, healthPosY);
    
    // Update the healthBar
    
    // Add the healthBar to the main parent node
    [self addChild:_healthBar];
    
}

- (void)createStatsBar {
    // Set the dimensions
    int statsX = 1024;
    int statsY = 30;
    
    // Create the shape node
    _statsBar = [[SKShapeNode alloc] init];
    CGRect tempRect3 = CGRectMake(0, 0, statsX, statsY);
    CGPathRef statsBarPath = CGPathCreateWithRect(tempRect3, NULL);
    _statsBar.path = statsBarPath;
    _statsBar.fillColor = [SKColor yellowColor];
    _statsBar.lineWidth = 0.25;
    
    // Tell the node where it should go
    int statsPosX = 0;
    int statsPosY = 738;
    _statsBar.position = CGPointMake(statsPosX, statsPosY);
    
    // Add the statsBar to the main parent node
    [self addChild:_statsBar];
    
    // Create the labels for the score and time
    [self createScoreLabel];
    [self createTimeLabel];
    
    // Add score and time labels to the statsBar node
    [_statsBar addChild:_scoreLabel];
    [_statsBar addChild:_timeLabel];
    
}

- (void)createMessageLabel {
    // Create the label node
    _consoleMessageLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    _consoleMessageLabel.fontColor = [SKColor blackColor];
    _consoleMessageLabel.fontSize = 20;
    _consoleMessageLabel.text = @"Choose an intercept and slope to fire at the enemies along the correct path.";
    _consoleMessageLabel.position = CGPointMake(125, 25);
    _consoleMessageLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter + 500;
    _consoleMessageLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter + 500;
    
}


- (void)createScoreLabel {
    
    // Create the label node
    _scoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    _scoreLabel.fontColor = [SKColor blackColor];
    _scoreLabel.fontSize = 20;
    _scoreLabel.text = @"SCORE";
    _scoreLabel.position = CGPointMake(175, 5);
    _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft + 10;
    _scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter + 10;

}

- (void)createTimeLabel {
    
    // Create the label node
    _timeLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    _timeLabel.fontColor = [SKColor blackColor];
    _timeLabel.fontSize = 20;
    _timeLabel.text = @"TIME";
    _timeLabel.position = CGPointMake(775, 5);
    _timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight + 50;
    _timeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter + 50;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];


}

- (void)createTimer {
    int totalSeconds = 120;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer)
                                                          userInfo:nil repeats:YES];
    totalSeconds--;
    _timeLabel.text = [timeFormatted:totalSeconds];
    if ( totalSeconds == 0 ) {
        [_timer invalidate];
    }
}

- (void)timerTick:(NSTimer *)timer {
    NSDate *levelTime = [NSDate date];
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"h:mm:ss a";  // very simple format  "8:47:22 AM"
    }
    _timeLabel.text = [dateFormatter stringFromDate:now];
}



@end

