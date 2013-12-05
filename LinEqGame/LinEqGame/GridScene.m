//
//  MyScene.m
//  LinEqGame
//
//  Created by Jason Yu on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "GridScene.h"
#import "QuestionMaster.h"
#import "VectorUtilities.h"
#import "SharkSpriteNode.h"

#define kratio 12
#define kpikachuMovementTime 1

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t enemyCategory          =  0x1 << 1;

@interface GridScene ()
@property CGPoint origin;
@property QuestionMaster *qm;
@property SKShapeNode *fireButton;
@property NSMutableArray *enemyLocations;

@property QuestionObject *question;
@property SKSpriteNode *pikachu;
@property Selector *selectorFrame;
@end

@implementation GridScene
float tickMarkSpacing = 5;
float xAxisGameLength = 50;
float yAxisGameLength = 40;
float tickLength = 30;
float xAxisLength;
float yAxisLength;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        xAxisLength = xAxisGameLength * kratio;
        yAxisLength = yAxisGameLength * kratio;
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"underwater-background.jpg"];
        background.anchorPoint = CGPointZero;
        [self addChild:background];
        
        [self drawGrid];
        
        self.question = [[[QuestionMaster alloc] init] generateQuestion];
        
        //Add enemies
        for (Location *location in self.question.enemyLocations) {
            [self addEnemyToCoordinateWithX:location.x Y:location.y];
        }
        
        self.enemyLocations = self.question.enemyLocations;
        
        self.pikachu = [SKSpriteNode spriteNodeWithImageNamed:@"pikachu"];
        self.pikachu.position = [self convertToRealCoordinatesGameX:0 y:0];
        [self addChild:self.pikachu];
        
        
        //Selector buttons
        self.selectorFrame = [[Selector alloc] init];
        [self.selectorFrame setupWithPresets];
        
        [self.selectorFrame setButtons:self.question];
        
        [self addChild:self.selectorFrame];
        
        SKLabelNode *fireText = [SKLabelNode labelNodeWithFontNamed:@"Marker"];
        fireText.text = @"FIRE";
        fireText.position = CGPointMake(75, 35);

        //Fire Button
        self.fireButton = [SKShapeNode node];
        CGRect fireButtonRect = CGRectMake(0, 0, 150, 100);
        CGPathRef fireButtonPath =  CGPathCreateWithRect(fireButtonRect, NULL);
        self.fireButton.path = fireButtonPath;
        self.fireButton.fillColor = [SKColor colorWithRed:1 green:0 blue:0 alpha:1];
        self.fireButton.position = CGPointMake(850, 100);
        [self.fireButton addChild:fireText];
        [self addChild:self.fireButton];

        //Cheating
//        double correctSlope = [(Fraction *) self.question.slopeAnswer.answerChoices[self.question.slopeAnswer.answerIndex] decimalValue];
//        double correctIntercept = [(Fraction *)self.question.interceptAnswer.answerChoices[self.question.interceptAnswer.answerIndex] decimalValue];
        NSLog(@"correct answer: (%d, %d)", self.question.interceptAnswer.answerIndex, self.question.slopeAnswer.answerIndex);
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
        
        CGPoint location = [touch locationInNode:self.fireButton];
        if (CGPathContainsPoint(self.fireButton.path, NULL, location, true))
        {
            [self fire];
        }
    }
    
}

#pragma mark - Grid
- (void) fire
{
    int posIndex = [self.selectorFrame getCurrentPosIndex];
    int slopeIndex = [self.selectorFrame getCurrentSlopeIndex];

    if (slopeIndex == -1 || posIndex == -1) {
        return;
    }
    
    double intercept = [[self.question interceptAt:posIndex] decimalValue];
    double slope = [[self.question slopeAt:slopeIndex] decimalValue];
    
    CGPoint destination = [self convertToRealCoordinatesGameX:0 y:intercept];
    SKAction *actionMove = [SKAction moveTo:destination duration:kpikachuMovementTime];

    [self.pikachu runAction:actionMove completion:^{
        float gameY = intercept + slope * xAxisGameLength;
        float gameX = xAxisGameLength;
        if (gameY > yAxisGameLength) {
            gameX = (gameY - intercept)/slope;
        }
        [self attackCoordinateWithX:gameX Y:gameY];
        
        if ([self.selectorFrame isSelectionCorrect])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Correct!" message:@"youwin!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

- (void) startRound
{
    
}

- (void)addEnemyToCoordinateWithX:(float)x Y:(float)y
{
    SharkSpriteNode *shark = [SharkSpriteNode spriteNodeWithImageNamed:@"shark"];
    shark.position = [self convertToRealCoordinatesGameX:x y:y];
    CGSize smallBody = CGSizeMake(shark.size.width/2, shark.size.height/20);
    shark.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:smallBody];
    shark.physicsBody.dynamic = YES;
    shark.physicsBody.categoryBitMask = enemyCategory;
    shark.physicsBody.contactTestBitMask = projectileCategory;
    shark.physicsBody.collisionBitMask = 0;

    [self addChild:shark];
    [shark addCoordinateLabel:self x:x y:y];
    
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
}

- (void)attackCoordinateWithX:(float)x Y:(float)y
{
    NSLog(@"Attacking (%f, %f)", x, y);
    SKSpriteNode *lightning = [SKSpriteNode spriteNodeWithImageNamed:@"lightning"];
    lightning.position = self.pikachu.position;
    NSLog(@"Lighting starts at (%f, %f)", lightning.position.x, lightning.position.y);
    lightning.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:lightning.size.width/2];
    lightning.physicsBody.dynamic = YES;
    lightning.physicsBody.categoryBitMask = projectileCategory;
    lightning.physicsBody.contactTestBitMask = enemyCategory;
    lightning.physicsBody.collisionBitMask = 0;
    lightning.physicsBody.usesPreciseCollisionDetection = YES;
    
    [self addChild:lightning];
    
    SKAction *move = [SKAction
                      moveTo:[self convertToRealCoordinatesGameX:x y:y]
                      duration:2];
    [lightning runAction:move];
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    NSLog(@"Hit");
    [monster removeFromParent];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    // 1
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // 2
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & enemyCategory) != 0)
    {
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
}

- (void)drawGrid {
    //(0, 0) for the game
    self.origin = CGPointMake(CGRectGetMinX(self.frame) + 15 * kratio, CGRectGetMinY(self.frame) + 15 * kratio);
    
    //The axes go from 0 to axisGameLength, with ticks appearing every tickMarkSpacing units

    UIColor *tickColor = [UIColor blueColor];
    
    /* Axes */
    SKShapeNode *xAxis = [SKShapeNode node];
    //lower left-hand corner
    xAxis.position = self.origin;
    CGMutablePathRef xPath = CGPathCreateMutable();
    CGPathMoveToPoint(xPath, NULL, 0, 0);
    CGPathAddLineToPoint(xPath, NULL, xAxisLength, 0);
    xAxis.path = xPath;
    [xAxis setStrokeColor:[UIColor redColor]];
    [self addChild:xAxis];
    CGPathRelease(xPath);
    
    SKShapeNode *yAxis = [SKShapeNode node];
    //lower left-hand corner
    yAxis.position = self.origin;
    CGMutablePathRef yPath = CGPathCreateMutable();
    CGPathMoveToPoint(yPath, NULL, 0, 0);
    CGPathAddLineToPoint(yPath, NULL, 0, yAxisLength);
    yAxis.path = yPath;
    [yAxis setStrokeColor:[UIColor redColor]];
    [self addChild:yAxis];
    CGPathRelease(yPath);
    
    
    /* Ticks */
    //offset of coordinate number from tick mark
    float offset = 50;
//    float realTickMarkSpacing = (tickMarkSpacing/axisGameLength)*kaxisLength;
    float realTickMarkSpacing = tickMarkSpacing * kratio;
    
    //x-axis
    float realX = self.origin.x;
    float gameX = 0;
    for (; realX <= self.origin.x + xAxisLength; realX += realTickMarkSpacing, gameX += tickMarkSpacing)
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
    for (; realY <= self.origin.y + yAxisLength; realY += realTickMarkSpacing, gameY += tickMarkSpacing)
    {
        CGPoint currentPosition = CGPointMake(self.origin.x, realY);
//        NSLog(@"Added tick at %@", NSStringFromCGPoint(currentPosition));
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
        //[self addChild:sprite];
    }
}



-(CGPoint)convertToRealCoordinatesGameX:(float)x y:(float)y
{
    CGPoint point = CGPointMake(self.origin.x + x * kratio, self.origin.y + y * kratio);
//    NSLog(@"moved sprite to %@", NSStringFromCGPoint(point));
    
    return point;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
