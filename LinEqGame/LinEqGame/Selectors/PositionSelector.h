//
//  PositionSelector.h
//  LinEqGame
//
//  Created by Philip Liao on 11/14/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PositionSelector : SKShapeNode

@property int currentSelection;

@property float posSelectorHeight;
@property float posSelectorWidth;

-(void)createButtonsFromDimensions: (CGRect) rect;
-(void) changeCurrentSelection: (int) newSelection;


@end
