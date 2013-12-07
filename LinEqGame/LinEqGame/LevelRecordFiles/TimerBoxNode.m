//
//  TimerBoxNode.m
//  LinEqGame
//
//  Created by CS121 on 12/2/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "TimerBoxNode.h"

@implementation TimerBoxNode

// Create getters and setters
@synthesize timerSeconds, initialTimerSeconds;

/* PROPERTIES */

// The time label
SKLabelNode *timeLabel;

// The timer
NSTimer *timer;


/* METHODS */

// Constructor
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y WithColor:(SKColor*)c
           LineWidth:(CGFloat)lW AndTimerSeconds:(int)s {
    // Initialize the bar and set its dimensions and position
    self = [super initWithHeight:h Width:w AtX:x Y:y WithColor:c AndLineWidth:lW];
    
    timerSeconds = s;
    initialTimerSeconds = s;
    
    // Create the timer
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                            target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
    
    // Create the label for the time
    [self createTimeLabel];
    
    // Add the time label to the timeBox node
    [self addChild:timeLabel];
    
    return self;
}


// Creates the time label
- (void)createTimeLabel {
    
    // Create the label node
    timeLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    timeLabel.fontColor = [SKColor blackColor];
    timeLabel.fontSize = 20;
    
    // Have the label display the timer
    timeLabel.text = [NSString stringWithFormat:@"%d s", timerSeconds];
    
    CGSize stringsize = [timeLabel.text
                         sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:timeLabel.fontSize]}];
    [timeLabel setPosition:CGPointMake((self.width - stringsize.width)/2, (self.height - stringsize.height)/2)];
    
    timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight + 50;
    timeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter + 50;
    
}

// Tells the timer how to tick
- (void)timerTick {
    
    // Tell the timer to decrease the time by 1 second and display the new time
    --timerSeconds;
    timeLabel.text = [NSString stringWithFormat:@"%d s", timerSeconds];
    
    if (timerSeconds == 0 ) {
        [timer invalidate];
        
        // show you lose and reset
        NSLog(@"You lose!");
        [self reset];
    }
}

// Resets the timerBoxNode
- (void)reset {
    timerSeconds = initialTimerSeconds;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
}

@end
