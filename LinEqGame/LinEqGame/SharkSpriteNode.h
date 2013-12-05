//
//  SharkSpriteNode.h
//  LinEqGame
//
//  Created by Jason Yu on 12/5/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SharkSpriteNode : SKSpriteNode
@property float labelX;
@property float labelY;

- (void)addCoordinateLabel:(SKScene *)scene x:(float)x y:(float)y;
- (void)removeCoordinateLabel;
@end
