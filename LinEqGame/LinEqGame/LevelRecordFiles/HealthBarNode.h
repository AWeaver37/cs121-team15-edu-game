//
//  HealthBarNode.h
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/21/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HealthBarNode : SKShapeNode

// The node's background color is represented by the member
// SKColor fillColor, inherited from SKShapeNode

// The node's x position
@property int positionX;

// The node's y position
@property int positionY;

// The node's height
@property int height;

// The node's width
@property int width;

// The index that corresponds to where the node is in both
// the healthBarInts and which index it corresponds to in the questions array
@property int index;

// The node's value
// 1 means true, the user answered the question correctly, and the background is colored;
// 0 means false, the user missed that question, and the background is transparent
@property int value;

// The next node in the healthBar
@property HealthBarNode *next;


@end
