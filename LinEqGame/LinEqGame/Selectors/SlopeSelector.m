//
//  SlopeSelector.m
//  LinEqGame
//
//  Created by Philip Liao on 11/14/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "SlopeSelector.h"

@implementation SlopeSelector


-(void)createButtonsFromDimensions: (CGRect) rect
{
    float titleWidth = rect.size.width;
    float titleHeight = rect.size.height*5.0/22.0;
    CGRect titleRect = CGRectMake(0,0,titleWidth,titleHeight);
    CGPathRef titlePath = CGPathCreateWithRect(titleRect, NULL);
    SKShapeNode * title = [[SKShapeNode alloc] init];
    title.name = @"SlopeTitle";
    float titleXPos = 0;
    float titleYPos = rect.size.height *17.0/22.0;
    title.path = titlePath;
    title.fillColor = [SKColor colorWithRed:241.0/256.0 green:209.0/256.0 blue:198.0/256.0 alpha:1.0];
    title.strokeColor = [SKColor clearColor];
    title.position = CGPointMake(titleXPos, titleYPos);
    
    SKLabelNode * titleText = [[SKLabelNode alloc] init];
    titleText.name = [[NSString alloc] initWithFormat:@"SlopeTitleText"];
    titleText.text = [[NSString alloc] initWithFormat:@"Slope"];
    titleText.position = CGPointMake(65, 20);
    titleText.fontSize = 18.0;
    titleText.fontColor = [SKColor colorWithRed:138.0/256.0 green:81.0/256.0 blue:71.0/256.0 alpha:1.0];
    [title addChild:titleText];
    [self addChild:title];
    
    float buttonWidth = rect.size.width*11.0/13.0; //10
    float buttonHeight = rect.size.height*5.0/22.0; //50
    CGRect buttonRect = CGRectMake(0, 0, buttonWidth, buttonHeight);
    CGPathRef buttonPath =  CGPathCreateWithRect(buttonRect, NULL);
    
    for(int i = 0; i<3; i++)
    {
        SKShapeNode * button = [[SKShapeNode alloc] init];
        button.name = [[NSString alloc] initWithFormat:@"SlopeButton%d", i];
        float buttonXPos = buttonWidth/11.0; //10
        float buttonYPos = i*buttonHeight + (i+1)*buttonHeight/11.0; //i*60 + (i+1)*10
        button.path = buttonPath;
        button.fillColor = [SKColor colorWithRed:245.0/256.0 green:227.0/256.0 blue:207.0/256.0 alpha:1.0];
        button.strokeColor = [SKColor clearColor];
        button.position = CGPointMake(buttonXPos, buttonYPos);
        
        SKLabelNode * buttonText = [[SKLabelNode alloc] init];
        buttonText.name = [[NSString alloc] initWithFormat:@"Button%dText", i];
        buttonText.text = [[NSString alloc] initWithFormat:@"Button %d", i];
        buttonText.position = CGPointMake(55, 20);
        buttonText.fontSize = 18.0;
        buttonText.fontColor = [SKColor colorWithRed:138.0/256.0 green:81.0/256.0 blue:71.0/256.0 alpha:1.0];
        [button addChild:buttonText];
        [self addChild:button];
    }
}

-(void) changeCurrentSelection: (int) newSelection
{
    self.currentSelection = newSelection;
    for (int i = 1; i < 4; i ++)
    {
        if( newSelection == i)
        {
            ((SKShapeNode*)[[self children] objectAtIndex:i]).fillColor = [SKColor colorWithRed:222.0/256.0 green:174.0/256.0 blue:182.0/256.0 alpha:1.0];
            
        } else {
            ((SKShapeNode*)[[self children] objectAtIndex:i]).fillColor = [SKColor colorWithRed:245.0/256.0 green:227.0/256.0 blue:207.0/256.0 alpha:1.0];

        }
     
    }
}

@end