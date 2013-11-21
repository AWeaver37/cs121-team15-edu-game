//
//  MyScene.m
//  LinEqGame
//
//  Created by Jason Yu on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "MyScene.h"
#define kaxisLength 600

@interface MyScene ()
@property CGPoint origin;
@end

@implementation MyScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        [self drawGrid];
        
    }
    return self;
}

- (void)drawGrid {
    //(0, 0) for the game
    self.origin = CGPointMake(CGRectGetMinX(self.frame) + 100, CGRectGetMinY(self.frame) + 100);
    
    //The axes go from 0 to axisGameLength, with ticks appearing every tickMarkSpacing units
    float tickMarkSpacing = 10;
    float axisGameLength = 50;
    float tickLength = 30;
    UIColor *tickColor = [UIColor blueColor];
    
    /* Axes */
    SKShapeNode *xAxis = [SKShapeNode node];
    //lower left-hand corner
    xAxis.position = self.origin;
    CGMutablePathRef xPath = CGPathCreateMutable();
    CGPathMoveToPoint(xPath, NULL, 0, 0);
    CGPathAddLineToPoint(xPath, NULL, kaxisLength, 0);
    xAxis.path = xPath;
    [xAxis setStrokeColor:[UIColor redColor]];
    [self addChild:xAxis];
    CGPathRelease(xPath);
    
    SKShapeNode *yAxis = [SKShapeNode node];
    //lower left-hand corner
    yAxis.position = self.origin;
    CGMutablePathRef yPath = CGPathCreateMutable();
    CGPathMoveToPoint(yPath, NULL, 0, 0);
    CGPathAddLineToPoint(yPath, NULL, 0, kaxisLength);
    yAxis.path = yPath;
    [yAxis setStrokeColor:[UIColor redColor]];
    [self addChild:yAxis];
    CGPathRelease(yPath);
    
    
    /* Ticks */
    //offset of coordinate number from tick mark
    float offset = 50;
    float realTickMarkSpacing = (tickMarkSpacing/axisGameLength)*kaxisLength;
    
    //x-axis
    float realX = self.origin.x;
    float gameX = 0;
    for (; realX <= self.origin.x + kaxisLength; realX += realTickMarkSpacing, gameX += tickMarkSpacing)
    {
        CGPoint currentPosition = CGPointMake(realX, self.origin.y);
        
        //tick
        //don't draw tick for (0, 0)
        if (gameX != 0) {
            SKShapeNode *tick = [SKShapeNode node];
            CGMutablePathRef tickPath = CGPathCreateMutable();
            CGPathMoveToPoint(tickPath, NULL, 0, tickLength/2);
            CGPathAddLineToPoint(tickPath, NULL, 0, -tickLength/2);
            tick.path = tickPath;
            CGPathRelease(tickPath);
            
            tick.position = currentPosition;
            [tick setStrokeColor:tickColor];
            [self addChild:tick];
        }
        
        //number below tick
        SKLabelNode *coordLabel = [SKLabelNode labelNodeWithFontNamed:@"Marker"];
        coordLabel.text = [NSString stringWithFormat:@"%1.0f", gameX];
        coordLabel.position = CGPointMake(currentPosition.x, currentPosition.y - offset);
        [self addChild:coordLabel];
        
    }
    
    //y-axis
    float realY = self.origin.y;
    float gameY = 0;
    for (; realY <= self.origin.y + kaxisLength; realY += realTickMarkSpacing, gameY += tickMarkSpacing)
    {
        CGPoint currentPosition = CGPointMake(self.origin.x, realY);
        //tick
        if (gameY != 0) {
            SKShapeNode *tick = [SKShapeNode node];
            CGMutablePathRef tickPath = CGPathCreateMutable();
            CGPathMoveToPoint(tickPath, NULL, tickLength/2, 0);
            CGPathAddLineToPoint(tickPath, NULL, -tickLength/2, 0);
            tick.path = tickPath;
            CGPathRelease(tickPath);
            
            tick.position = currentPosition;
            [tick setStrokeColor:tickColor];
            [self addChild:tick];
        }
        
        //number below tick
        SKLabelNode *coordLabel = [SKLabelNode labelNodeWithFontNamed:@"Marker"];
        coordLabel.text = [NSString stringWithFormat:@"%1.0f", gameY];
        coordLabel.position = CGPointMake(currentPosition.x - offset, currentPosition.y);
        [self addChild:coordLabel];
    }
}



//-(Pair *)convertToDrawingCoordinatesGameX:(float)x y:(float)y
//{
//    
//}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
