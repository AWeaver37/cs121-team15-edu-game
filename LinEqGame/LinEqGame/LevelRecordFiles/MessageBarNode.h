//
//  MessageBarNode.h
//  LinEqGame
//
//  Created by CS121 on 11/29/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "BarBoxNodeBase.h"

@interface MessageBarNode : BarBoxNodeBase

// Constructor
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y
           WithColor:(SKColor*)c LineWidth:(CGFloat)lW AndInitialMessage:(NSString*)m;

/* PROPERTIES */

// The label that displays the message
@property SKLabelNode *messageLabel;

// The message displayed on the console bar
@property (nonatomic) NSString* message;

// The initial message, used for resetting
@property (nonatomic) NSString* initialMessage;

// The label's horizontal and vertical allignments
@property (nonatomic) SKLabelHorizontalAlignmentMode horizAlignMessage;
@property (nonatomic) SKLabelVerticalAlignmentMode vertAlignMessage;


/* METHODS */
// Creates the message label
- (void)createMessageLabel;

// Sets the console message
- (void)setMessage:(NSString*)message;

// Resets the message label
- (void)reset;



@end





