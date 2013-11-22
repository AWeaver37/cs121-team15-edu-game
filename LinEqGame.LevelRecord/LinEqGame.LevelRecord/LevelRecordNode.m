//
//  LevelRecordNode.m
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/20/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

#import "LevelRecordNode.h"


@implementation LevelRecordNode

- (void)createAllBars {
    [self createMessageBar];
    [self createHealthBar];
    [self createStatsBar];
}

- (void)createMessageBar {
    // Set the dimensions
    int messageX = 800;
    int messageY = 100;
    
    // Create the shape node
    SKShapeNode *messageBar = [[SKShapeNode alloc] init];
    CGRect tempRect1 = CGRectMake(0, 0, messageX, messageY);
    CGPathRef messageBarPath = CGPathCreateWithRect(tempRect1, NULL);
    messageBar.path = messageBarPath;
    messageBar.fillColor = [SKColor blueColor];
    
    // Tell the node where it should go
    int messagePosX = 50;
    int messagePosY = 20;
    messageBar.position = CGPointMake(messagePosX, messagePosY);
    
    // Add the messageBar to the main parent node
    [self addChild:messageBar];
    
    // Add the consoleMessage to the messageBar node
    [messageBar addChild:_consoleMessageLabel];
    
    // Create the label for the consoleMessage
    [self createMessageLabel];
    
    // Add the consoleMessage label to the statsBar node
    [messageBar addChild:_consoleMessageLabel];

}

- (void)createHealthBar {
    // Set the dimensions
    int healthX = 50;
    int healthY = 600;
    
    // Create the shape node
    SKShapeNode *healthBar = [[SKShapeNode alloc] init];
    CGRect tempRect2 = CGRectMake(0, 0, healthX, healthY);
    CGPathRef healthBarPath = CGPathCreateWithRect(tempRect2, NULL);
    healthBar.path = healthBarPath;
    healthBar.fillColor = [SKColor blueColor];
    
    // Tell the node where it should go
    int healthPosX = 10;
    int healthPosY = 128;
    healthBar.position = CGPointMake(healthPosX, healthPosY);
    
    // Add the healthBar to the main parent node
    [self addChild:healthBar];
}

- (void)createStatsBar {
    // Set the dimensions
    int statsX = 1024;
    int statsY = 30;
    
    // Create the shape node
    SKShapeNode *statsBar = [[SKShapeNode alloc] init];
    CGRect tempRect3 = CGRectMake(0, 0, statsX, statsY);
    CGPathRef statsBarPath = CGPathCreateWithRect(tempRect3, NULL);
    statsBar.path = statsBarPath;
    statsBar.fillColor = [SKColor blueColor];
    
    // Tell the node where it should go
    int statsPosX = 0;
    int statsPosY = 738;
    statsBar.position = CGPointMake(statsPosX, statsPosY);
    
    // Add the statsBar to the main parent node
    [self addChild:statsBar];
    
    // Create the labels for the score and time
    [self createScoreLabel];
    [self createTimeLabel];
    
    // Add score and time labels to the statsBar node
    [statsBar addChild:_scoreLabel];
    [statsBar addChild:_timeLabel];
}

- (void)createMessageLabel {
    
    // Create the label node
    _consoleMessageLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    _consoleMessageLabel.fontColor = [SKColor blackColor];
    _consoleMessageLabel.fontSize = 5;
    
}


- (void)createScoreLabel {
    
    // Create the label node
    _scoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    _scoreLabel.fontColor = [SKColor blackColor];
    _scoreLabel.fontSize = 3;

}

- (void)createTimeLabel {
    
    // Create the label node
    _timeLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    _timeLabel.fontColor = [SKColor blackColor];
    _timeLabel.fontSize = 3;

}


@end

