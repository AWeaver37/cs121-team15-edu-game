//
//  BarNodeBase.m
//  LinEqGame
//
//  Created by CS121 on 11/29/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "BarBoxNodeBase.h"

@implementation BarBoxNodeBase

// Create getters and setters
@synthesize positionX, positionY, height, width;

// Constructor that initializes the bar with a specific height and width at a specific x and y
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y WithColor:(SKColor*)c AndLineWidth:(CGFloat)lW {
    self = [super init];
    
    self.height = h;
    self.width = w;
    self.positionX = x;
    self.positionY = y;
    super.fillColor = c;
    super.lineWidth = lW;
    
    [self createBar];
    
    return self;
}

// Constructor that initializes the bar with a specific rectangle at a specific point
- (id)initWithRect:(CGRect)r AtPoint:(CGPoint)p WithColor:(SKColor*)c AndLineWidth:(CGFloat)lW {
    self = [super init];
    
    self.path = CGPathCreateWithRect(r, NULL);
    self.position = p;
    super.fillColor = c;
    super.lineWidth = lW;
    
    return self;
}

// Creates the shape node and tells it where to go
- (void)createBar {
    // Create the shape node
    CGRect tempRect = CGRectMake(0, 0, width, height);
    CGPathRef barPath = CGPathCreateWithRect(tempRect, NULL);
    self.path = barPath;
    
    // Tell the node where it should go
    self.position = CGPointMake(positionX, positionY);
    
}


@end
