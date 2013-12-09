//
//  SharkSpriteNode.m
//  LinEqGame
//
//  Created by Jason Yu on 12/5/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "EnemySpriteNode.h"
@interface EnemySpriteNode ()
    @property CGPoint gameCoord;
@end

@implementation EnemySpriteNode

- (id)initWithGameCoordinates:(CGPoint)gameCoord;
{
    if (self = [super initWithImageNamed:@"jellyfish2"])
    {
        self.gameCoord = gameCoord;
        [self addCoordinateLabel];
    }
    
    return self;
}

- (void)removeFromParent
{
    [super removeFromParent];
    [self removeCoordinateLabel];
}

- (void)addCoordinateLabel
{
    float below = 75;
    self.coordinates = [[SKLabelNode alloc] initWithFontNamed:@"Marker"];
    self.coordinates.text = [NSString stringWithFormat:@"(%1.0f, %1.0f)", self.gameCoord.x, self.gameCoord.y];
    self.coordinates.position = CGPointMake(self.position.x, self.position.y - below);
    [self addChild:self.coordinates];
}

- (void)removeCoordinateLabel
{
    [self.coordinates removeFromParent];
}
@end
