//
//  Selector.h
//  LinEqGame
//
//  Created by Philip Liao on 11/14/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PositionSelector.h"
#import "SlopeSelector.h"
#import "QuestionObject.h"
#import "AnswerChoice.h"
#import "Fraction.h"

@interface Selector : SKShapeNode

@property QuestionObject *currentQuestion;

-(void)setupWithPresets;
-(void)createSelectorsFromDimensions: (CGRect) rect;
-(void)setButtons: (QuestionObject *) question;
-(BOOL) isSlopeCorrect;
-(BOOL) isPosCorrect;
-(BOOL) isSelectionCorrect;


@end
