//
//  MessageBarNode.m
//  LinEqGame
//
//  Created by CS121 on 11/29/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "MessageBarNode.h"

@implementation MessageBarNode

// Constructor
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y
           WithColor:(SKColor*)c LineWidth:(CGFloat)lW AndInitialMessage:(NSString*)m {
    // Initialize the bar
    self = [super initWithHeight:h Width:w AtX:x Y:y WithColor:c AndLineWidth:lW];
    
    // Save the initial message for reset
    _initialMessage = m;
    
    // Create the label for the consoleMessage
    [self createMessageLabel];
    
    // Add the consoleMessage to the messageBar node
    [self addChild:_messageLabel];
    
    // Set the message on the message label
    [self setMessage:m];
    
    return self;
}

// Creates the message label
- (void)createMessageLabel {
    // Create the label node
    _messageLabel = [[SKLabelNode alloc] initWithFontNamed:@"Times New Roman"];
    _messageLabel.fontColor = [SKColor blackColor];
    _messageLabel.fontSize = 20;
    _messageLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter + 500;
    _messageLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter + 500;
}


// Sets the console message
- (void)setMessage:(NSString*)message {
    _message = message;
    _messageLabel.text = _message;
    
    CGSize stringsize = [_message
                         sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_messageLabel.fontSize]}];
    [_messageLabel setPosition:CGPointMake((self.width - stringsize.width)/2, (self.height - stringsize.height)/2)];
}


// Resets the messageLabel
- (void)reset{
    // Reset the message
    [self setMessage:_initialMessage];
}

@end
