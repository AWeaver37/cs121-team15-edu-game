//
//  BarNodeBase.h
//  LinEqGame
//
//  Created by CS121 on 11/29/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BarBoxNodeBase : SKShapeNode

/* PROPERTIES */

// The node's position
@property (nonatomic) int positionX;
@property (nonatomic) int positionY;

// The node's dimensions
@property (nonatomic) int height;
@property (nonatomic) int width;


/* METHODS */

// Constructor that initializes the bar with a specific height and width at a specific x and y
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y WithColor:(SKColor*)c AndLineWidth:(CGFloat)lW;

// Constructor that initializes the bar with a specific rectangle at a specific point
- (id)initWithRect:(CGRect)r AtPoint:(CGPoint)p WithColor:(SKColor*)c AndLineWidth:(CGFloat)lW;

@end
