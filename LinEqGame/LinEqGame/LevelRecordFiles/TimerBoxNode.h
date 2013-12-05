//
//  TimerBoxNode.h
//  LinEqGame
//
//  Created by CS121 on 12/2/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "BarBoxNodeBase.h"

@interface TimerBoxNode : BarBoxNodeBase

/* PROPERTIES */

// The number of seconds to start the timer with
@property int timerSeconds;

// Saves the initial timerTotalSeconds for reset
@property int initialTimerSeconds;

// The time label's horizontal and vertical allignments
@property (nonatomic) SKLabelHorizontalAlignmentMode horizAlignTime;
@property (nonatomic) SKLabelVerticalAlignmentMode vertAlignTime;


/* METHODS */

// Constructor
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y WithColor:(SKColor*)c
           LineWidth:(CGFloat)lW AndTimerSeconds:(int)s;

// Creates the time label
- (void)createTimeLabel;

// Tells the timer how to tick
- (void)timerTick;

// Resets the timerBoxNode
- (void)reset;

@end
