//
//  LevelRecordNode.h
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/20/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

// UI (View)

#import <SpriteKit/SpriteKit.h>
#import "LevelRecordScene.h"
#import "HealthBarNode.h"

@interface LevelRecordNode : SKNode

@property SKShapeNode *messageBar;
@property HealthBarNode *healthBar;
@property SKShapeNode *statsBar;

@property SKLabelNode *consoleMessageLabel;
//@property(copy, nonatomic) NSString *messageFontName;
//@property(retain, nonatomic) SKColor *messageFontColor;
//@property(nonatomic) CGFloat messageFontSize;

@property SKLabelNode *scoreLabel;
//@property(copy, nonatomic) NSString *scoreFontName;
//@property(retain, nonatomic) SKColor *scoreFontColor;
//@property(nonatomic) CGFloat scoreFontSize;

@property SKLabelNode *timeLabel;
//@property(copy, nonatomic) NSString *timeFontName;
//@property(retain, nonatomic) SKColor *timeFontColor;
//@property(nonatomic) CGFloat timeFontSize;

@property NSTimer *timer;

@property 

@property (nonatomic) SKLabelHorizontalAlignmentMode horizAlignMessage;
@property (nonatomic) SKLabelHorizontalAlignmentMode horizAlignScore;
@property (nonatomic) SKLabelHorizontalAlignmentMode horizAlignTime;

@property (nonatomic) SKLabelVerticalAlignmentMode vertAlignMessage;
@property (nonatomic) SKLabelVerticalAlignmentMode vertAlignScore;
@property (nonatomic) SKLabelVerticalAlignmentMode vertAlignTime;


- (void)createAllBars;
- (void)createMessageBar;
- (void)createHealthBar;
- (void)createStatsBar;

- (void)createMessageLabel;
- (void)createScoreLabel;
- (void)createTimeLabel;



@end
