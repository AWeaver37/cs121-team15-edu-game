//
//  SharkSpriteNode.h
//  LinEqGame
//
//  Created by Jason Yu on 12/5/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface EnemySpriteNode : SKSpriteNode
@property SKLabelNode *coordinates;

- (id)initWithGameCoordinates:(CGPoint)gameCoord;
@end
