//
//  SharkSpriteNode.m
//  LinEqGame
//
//  Created by Jason Yu on 12/5/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "SharkSpriteNode.h"

@implementation SharkSpriteNode
- (void)addCoordinateLabel:(SKScene *)scene x:(float)x y:(float)y
{
    self.labelX = x;
    self.labelY = y;
    
    float below = 75;
    SKLabelNode *coordinates = [[SKLabelNode alloc] initWithFontNamed:@"Marker"];
    coordinates.text = [NSString stringWithFormat:@"(%1.0f, %1.0f)", self.labelX, self.labelY];
    coordinates.position = CGPointMake(self.position.x, self.position.y - below);
    [scene addChild:coordinates];
}

- (void)removeCoordinateLabel
{
    
}
@end
