//
//  MyScene.m
//  LinEqGame
//
//  Created by Jason Yu on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        /*
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
         */
        
        //color scheme: http://www.colourlovers.com/palette/3124537/dreamy
        
        /*
        float selectorXPos = 600.0;
        float selectorYPos = 30.0*10.24;
        Selector *selectorFrame = [[Selector alloc] init];
        selectorFrame.name = @"SelectorFrame";
        CGRect selectorRect = CGRectMake(0, 0, 150, 450);
        CGPathRef selectorPath =  CGPathCreateWithRect(selectorRect, NULL);
        selectorFrame.path = selectorPath;
        selectorFrame.fillColor = [SKColor colorWithRed:129.0/256.0 green:141.0/256.0 blue:163.0/256.0 alpha:1.0];
        selectorFrame.position = CGPointMake(selectorXPos, selectorYPos);
         
        [selectorFrame createSelectorsFromDimensions:selectorRect];
         */
        
        Selector *selectorFrame = [[Selector alloc] init];
        [selectorFrame setupWithPresets];
        

        [self addChild:selectorFrame];
        
        ((SKLabelNode *)[[[[self childNodeWithName:@"SelectorFrame"] childNodeWithName:@"SlopeSelector"] childNodeWithName:@"SlopeButton1"]childNodeWithName:@"Button1Text"]).text = @"ASDF";

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    for (UITouch *touch in touches) {
        Selector* selector = [self childNodeWithName:@"SelectorFrame"];
        PositionSelector* posSelector = [selector childNodeWithName:@"PositionSelector"];
        SlopeSelector* slopeSelector = [selector childNodeWithName:@"SlopeSelector"];
        
        for (int i =1; i <4; i++ )
        {
            SKShapeNode *button = [[posSelector children] objectAtIndex:i];
            CGPoint location = [touch locationInNode:button];
            if ( CGPathContainsPoint(button.path, NULL, location, true) )
            {
                [posSelector changeCurrentSelection:i];

            }
        }

        for (int j =1; j <4; j++ )
        {
            SKShapeNode *button = [[slopeSelector children] objectAtIndex:j];
            CGPoint location = [touch locationInNode:button];
            if ( CGPathContainsPoint(button.path, NULL, location, true) )
                if ( CGPathContainsPoint(button.path, NULL, location, true) )
                {
                    [slopeSelector changeCurrentSelection:j];
                    
                }
            
        }


    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */


}

@end
