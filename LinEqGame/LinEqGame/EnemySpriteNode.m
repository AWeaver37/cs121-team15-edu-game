//
//  SharkSpriteNode.m
//  LinEqGame
//
//  Created by Jason Yu on 12/5/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "EnemySpriteNode.h"

@implementation EnemySpriteNode
- (void)addCoordinateLabel:(SKScene *)scene x:(float)x y:(float)y
{
    float below = 75;
    self.coordinates = [[SKLabelNode alloc] initWithFontNamed:@"Marker"];
    self.coordinates.text = [NSString stringWithFormat:@"(%1.0f, %1.0f)", x, y];
    self.coordinates.position = CGPointMake(self.position.x, self.position.y - below);
    [scene addChild:self.coordinates];
}

- (void)removeCoordinateLabel
{
    [self.coordinates removeFromParent];
}
@end
