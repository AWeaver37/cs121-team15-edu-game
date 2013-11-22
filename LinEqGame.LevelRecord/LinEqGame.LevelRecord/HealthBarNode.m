//
//  HealthBarNode.m
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/21/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

#import "HealthBarNode.h"

@implementation HealthBarNode

// Default Constructor
- (void)initHealthBarNode {
    super.fillColor = [SKColor greenColor];
    _positionX = 0;
    _positionY = 0;
    _height = 0;
    _width = 0;
    _index = 0;
    _value = 0;
    _next = [[HealthBarNode alloc] init]; //?
    
    // calculate position on screen based on height of previous index and positionY
    
}

// Total Element Constructor
- (void)initHealthBarNodeWithFillColor:(SKColor*)fillColor AndPositionX:(int)positionX AndPositionY:(int)positionY
                                   AndHeight:(int)height AndWidth:(int)width AndIndex:(int)index
                                    AndValue:(int)value AndNext:(HealthBarNode*) next {
    super.fillColor = fillColor;
    _positionX = positionX;
    _positionY = positionY;
    _height = height;
    _width = width;
    _index = index;
    _value = value;
    _next = next;
    
}

/* Other Methods */

// Calculates where to place the node on the healthBar
- (int)calcPositionY {
    return 0;
}




@end
