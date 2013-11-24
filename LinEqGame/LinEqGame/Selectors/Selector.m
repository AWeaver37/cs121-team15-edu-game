//
//  Selector.m
//  LinEqGame
//
//  Created by Philip Liao on 11/14/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "Selector.h"

@implementation Selector

-(void)setupWithPresets
{
    float selectorXPos = 850.0;
    float selectorYPos = 280;
    
    self.name = @"SelectorFrame";
    CGRect selectorRect = CGRectMake(0, 0, 150, 450);
    CGPathRef selectorPath =  CGPathCreateWithRect(selectorRect, NULL);
    self.path = selectorPath;
    self.fillColor = [SKColor colorWithRed:129.0/256.0 green:141.0/256.0 blue:163.0/256.0 alpha:1.0];
    self.strokeColor = [SKColor clearColor];
    self.position = CGPointMake(selectorXPos, selectorYPos);
    
    [self createSelectorsFromDimensions:selectorRect];
   
}

-(void)createSelectorsFromDimensions: (CGRect) rect
{
    SKColor * lightBlue = [SKColor colorWithRed:188.0/256.0 green:219.0/256.0 blue:225.0/256.0 alpha:1.0];
    CGRect selectorRect = CGRectMake(0, 0, rect.size.width*13.0/15.0, rect.size.height/2.0 - rect.size.height/90.0);//130, 220
    
    //Create the position selector
    
    PositionSelector * positionSelector = [[PositionSelector alloc] init];
    positionSelector.name = @"PositionSelector";
    //set  size, background color, location of position selector
    CGPathRef positionSelectorPath =  CGPathCreateWithRect(selectorRect, NULL);
    positionSelector.path = positionSelectorPath;
    positionSelector.fillColor = lightBlue;
    positionSelector.strokeColor = [SKColor clearColor];
    float positionSelectorXPos = rect.size.width/15.0; //10
    float positionSelectorYPos = rect.size.height/2.0 + rect.size.height/90.0; //230
    positionSelector.position = CGPointMake(positionSelectorXPos, positionSelectorYPos);
    //creates and adds buttons
    [positionSelector createButtonsFromDimensions:selectorRect];
    
    //Same thing, but for the slope selector (only difference is location)
    SlopeSelector * slopeSelector = [[SlopeSelector alloc] init];
    slopeSelector.name = @"SlopeSelector";
    CGPathRef slopeSelectorPath =  CGPathCreateWithRect(selectorRect, NULL);
    slopeSelector.path = slopeSelectorPath;
    slopeSelector.fillColor = lightBlue;
    slopeSelector.strokeColor = [SKColor clearColor];
    float slopeSelectorXPos = rect.size.width/15.0;
    float slopeSelectorYPos = 0;
    slopeSelector.position = CGPointMake(slopeSelectorXPos, slopeSelectorYPos);
    [slopeSelector createButtonsFromDimensions:selectorRect];

    
    
    [self addChild:positionSelector];
    [self addChild:slopeSelector];
    
    
}

-(void)setButtons: (QuestionObject *) question
{
    NSArray * slopeChoices = [[NSArray alloc] initWithArray: question.slopeAnswer.answerChoices];
    NSArray * postionChoices = [[NSArray alloc] initWithArray: question.interceptAnswer.answerChoices];
    
    
    
    for( int i = 0; i<3; i++)
    {
        NSString * currentSlope = [[slopeChoices objectAtIndex:i] description];
        NSString * currentPostion = [[postionChoices objectAtIndex:i] description];
//        NSLog(currentPostion);
//        NSLog(currentSlope);
        
        ((SKLabelNode *)[[[self childNodeWithName:@"SlopeSelector"] childNodeWithName:[NSString stringWithFormat:@"SlopeButton%d", i ]]childNodeWithName:[NSString stringWithFormat:@"Button%dText", i ]]).text = currentSlope;

        ((SKLabelNode *)[[[self childNodeWithName:@"PositionSelector"] childNodeWithName:[NSString stringWithFormat:@"PosButton%d", i ]]childNodeWithName:[NSString stringWithFormat:@"Button%dText", i ]]).text = currentPostion;
    }

}
@end
