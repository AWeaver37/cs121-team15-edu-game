//
//  MyScene.m
//  LinEqGame
//
//  Created by Jason Yu on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "GridScene.h"
#import "QuestionMaster.h"
#import "EnemySpriteNode.h"

#import "HealthBarNode.h"
#import "MessageBarNode.h"
#import "ScoreBoxNode.h"
#import "TimerBoxNode.h"

#define kratio 12
#define kHeroMovementTime 1

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t enemyCategory          =  0x1 << 1;

@interface GridScene ()

// QuestionMaster used to generate the questions
@property QuestionMaster *qm;

// LevelRecordNode used to display the message, score, and time
//@property LevelRecordNode *levelRecordNode;

// Grid
@property CGPoint origin;
@property SKShapeNode *xAxis;
@property SKShapeNode *yAxis;

// Background
@property SKSpriteNode *background;

// Button Locations
@property SKShapeNode *fireButton;

// Avatar and Weapon
@property SKSpriteNode *octopus;
@property SKSpriteNode *ink;

// Enemy and Weapon
@property SKSpriteNode *jellyfish;
@property SKSpriteNode *lightning;

// Enemy Locations
@property NSMutableArray *enemyLocations;

@property QuestionObject *question;

// Actions
@property SKAction *moveToTarget;
//@property SKAction *fire;
@property SKAction *enemyAttack;
@property SKAction *enemyRetreat;

// Bars
@property MessageBarNode *messageBar;
@property HealthBarNode *healthBar;
@property ScoreBoxNode *scoreBox;
@property TimerBoxNode *timerBox;

// Button
@property Selector* selector;
@property PositionSelector* posSelector;
@property SlopeSelector* slopeSelector;

@end

@implementation GridScene

// Set dimensions
float tickMarkSpacing = 5;
float xAxisGameLength = 50;
float yAxisGameLength = 40;
float tickLength = 30;
float xAxisLength;
float yAxisLength;

// Initialize the GridScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        // Set up the scene
        xAxisLength = xAxisGameLength * kratio;
        yAxisLength = yAxisGameLength * kratio;
        //        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        [self createBackground];
        
        [self drawGrid];
        
        [self createButtonBar];
        
        // Initialize the LevelRecordNode to display message console, score, and time
        [self createAllBars];
        
        // Tests set message and reset
        //[_messageBar setMessage:@"Hi Kidz"];
        //[_messageBar reset];
        
        self.question = [[[QuestionMaster alloc] init] generateQuestion];
        for (Location *location in self.question.enemyLocations) {
            [self addEnemyToCoordinateWithX:location.x Y:location.y];
        }
        
        self.enemyLocations = self.question.enemyLocations;
        
        //Enemy
        self.octopus = [SKSpriteNode spriteNodeWithImageNamed:@"octopus_surprised"];
        self.octopus.position = [self convertToRealCoordinatesGameX:0 y:0];
        [self addChild:self.octopus];
        
        self.selector = [[Selector alloc] init];
        [self.selector setupWithPresets];
        [self.selector setButtons:self.question];
        self.posSelector = (PositionSelector *) [self.selector childNodeWithName:@"PositionSelector"];
        self.slopeSelector = (SlopeSelector *) [self.selector childNodeWithName:@"SlopeSelector"];
        [self addChild:self.selector];
        
        [self createFireButton];
        
        //Cheating
        NSLog(@"correct answer: (%d, %d)", self.question.interceptAnswer.answerIndex, self.question.slopeAnswer.answerIndex);

    }
    return self;
}

// Initializes the jellyfish and makes it a physics body
- (void) createJellyfishAtX:(float)x Y:(float)y {
    // Initialize the jellyfish
    _jellyfish = [SKSpriteNode spriteNodeWithImageNamed:@"jellyfish2"];
    
    // Give the jellyfish a position
    _jellyfish.position = [self convertToRealCoordinatesGameX:x y:y];
    
    // Make the jellyfish a physics body and set properties
    _jellyfish.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_jellyfish.size];
    _jellyfish.physicsBody.dynamic = YES;
    _jellyfish.physicsBody.categoryBitMask = enemyCategory;
    _jellyfish.physicsBody.contactTestBitMask = projectileCategory;
    _jellyfish.physicsBody.collisionBitMask = 0;
    
    // Add the jellyfish to the scene
    [self addChild:_jellyfish];
}

#pragma mark - Grid
- (void) fire
{
    int posIndex = [self.selector getCurrentPosIndex];
    int slopeIndex = [self.selector getCurrentSlopeIndex];

    if (slopeIndex == -1 || posIndex == -1) {
        return;
    }
    
    double intercept = [[self.question interceptAt:posIndex] decimalValue];
    double slope = [[self.question slopeAt:slopeIndex] decimalValue];
    
    CGPoint destination = [self convertToRealCoordinatesGameX:0 y:intercept];
    SKAction *actionMove = [SKAction moveTo:destination duration:1];

    [self.octopus runAction:actionMove completion:^{
        float gameY = intercept + slope * xAxisGameLength;
        float gameX = xAxisGameLength;
        if (gameY > yAxisGameLength) {
            gameX = (gameY - intercept)/slope;
        }
        [self attackCoordinateWithX:gameX Y:gameY];
        
        if ([self.selector isSelectionCorrect])
        {
        }
    }];
}

- (void) startRound
{
    
}

- (void)addEnemyToCoordinateWithX:(float)x Y:(float)y
{
    EnemySpriteNode *enemy = [EnemySpriteNode spriteNodeWithImageNamed:@"jellyfish2"];
    enemy.position = [self convertToRealCoordinatesGameX:x y:y];
    CGSize smallBody = CGSizeMake(enemy.size.width/2, enemy.size.height/20);
    enemy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:smallBody];
    enemy.physicsBody.dynamic = YES;
    enemy.physicsBody.categoryBitMask = enemyCategory;
    enemy.physicsBody.contactTestBitMask = projectileCategory;
    enemy.physicsBody.collisionBitMask = 0;

    [self addChild:enemy];
    [enemy addCoordinateLabel:self x:x y:y];
    
    // Set the rules for the physicsWorld
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
}

- (void) createLightningAtX:(float)x Y:(float)y {
    // Initialize the jelyfishes' lightning weapon
    _lightning = [SKSpriteNode spriteNodeWithImageNamed:@"lightning"];
    
    // Give the lightning a position
    _lightning.position = self.origin;
    
    // Make the lightning a physics body and set properties
    _lightning.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_lightning.size.width/2];
    _lightning.physicsBody.dynamic = YES;
    _lightning.physicsBody.categoryBitMask = projectileCategory;
    _lightning.physicsBody.contactTestBitMask = enemyCategory;
    _lightning.physicsBody.collisionBitMask = 0;
    _lightning.physicsBody.usesPreciseCollisionDetection = YES;
    
    // Add the lightning to the scene
    [self addChild:_lightning];
}

- (void) createInkAtX:(float)x Y:(float)y {
    // Initialize the octopus's ink weapon
    _ink = [SKSpriteNode spriteNodeWithImageNamed:@"lightning"];
    
    // Give the ink a position
    _ink.position = CGPointMake(x, y);
    
    // Make the ink a physics body and set properties
    _ink.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ink.size.width/2];
    _ink.physicsBody.dynamic = YES;
    _ink.physicsBody.categoryBitMask = projectileCategory;
    _ink.physicsBody.contactTestBitMask = enemyCategory;
    _ink.physicsBody.collisionBitMask = 0;
    _ink.physicsBody.usesPreciseCollisionDetection = YES;
    
    // Add the ink to the scene
    [self addChild:_ink];
}

/* CREATE SCENE ENTITIES */




/* ACTION METHODS */

//- (void) createMoveToTargetAtX:x Y:y ForDuration:duration {
//_move = [SKAction
//                  moveTo:[self convertToRealCoordinatesGameX:x y:y]
//                  duration:2];
//}

- (void)attackCoordinateWithX:(float)x Y:(float)y
{
    [self createInkAtX:(float)self.octopus.position.x Y:(float)self.octopus.position.y];
    
    SKAction *move = [SKAction
                      moveTo:[self convertToRealCoordinatesGameX:x y:y]
                      duration:2];

    [_ink runAction:move];
    
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWitEnemy:(EnemySpriteNode *)enemy {
    NSLog(@"Hit");
    [enemy removeCoordinateLabel];
    [enemy removeFromParent];
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
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWitEnemy:(EnemySpriteNode *) secondBody.node];
    }
}

-(void)moveSprite:(SKSpriteNode *)sprite ToCoordinateWithX:(float)x Y:(float)y
{
    CGPoint destination = [self convertToRealCoordinatesGameX:x y:y];
    SKAction *actionMove = [SKAction moveTo:destination duration:1];
    
    [sprite runAction:actionMove];
}

#pragma mark - Util

-(CGPoint)convertToRealCoordinatesGameX:(float)x y:(float)y
{
    CGPoint point = CGPointMake(self.origin.x + x * kratio, self.origin.y + y * kratio);
    NSLog(@"moved sprite to %@", NSStringFromCGPoint(point));
    
    return point;
}



// Creates the movement for when the enemy attacks
//- (void)enemyAttack {
//    _enemyAttack = SKActionTimingEaseIn;

    // Set what enemy is attacking (jellyfish)

    // Set where the enemy is attacking (the octopus's position)

    // moveSprite
//}


// Creates the movement for when the enemy retreats
//- (void)enemyRetreat {
//    _enemyRetreat = SKActionTimingEaseOut;
    // Set what enemy is retreating (jellyfish)

    // Set where the enemy is retreating (off-screen)

    // moveSprite
//    
//}

// Moves the octopus up and down the y-axis
//- (void)moveAlongYAxisTo:(float)y {
//
//}



#pragma mark - Grid

// Initializes and draws the xAxis
- (void)createXAxis {
    _xAxis = [SKShapeNode node];
    
    // Place the origin in the lower left-hand corner
    _xAxis.position = self.origin;
    CGMutablePathRef xPath = CGPathCreateMutable();
    CGPathMoveToPoint(xPath, NULL, 0, 0);
    CGPathAddLineToPoint(xPath, NULL, xAxisLength, 0);
    _xAxis.path = xPath;
    [_xAxis setStrokeColor:[UIColor redColor]];
    
    [self addChild:_xAxis];
    CGPathRelease(xPath);
}

// Initializes and draws the yAxis
- (void)createYAxis {
    _yAxis = [SKShapeNode node];
    
    // Place the origin in the lower left-hand corner
    _yAxis.position = self.origin;
    CGMutablePathRef yPath = CGPathCreateMutable();
    CGPathMoveToPoint(yPath, NULL, 0, 0);
    CGPathAddLineToPoint(yPath, NULL, 0, yAxisLength);
    _yAxis.path = yPath;
    [_yAxis setStrokeColor:[UIColor redColor]];
    [self addChild:_yAxis];
    CGPathRelease(yPath);
}

// Creates the ticks on the grid
//The axes go from 0 to axisGameLength, with ticks appearing every tickMarkSpacing units
- (void)createTicks {
    
    // Set the tick color
    UIColor *tickColor = [UIColor blueColor];
    
    // Set the offset of the coordinate number from its tick mark
    float offset = 50;
    //  float realTickMarkSpacing = (tickMarkSpacing/axisGameLength)*kaxisLength;
    float realTickMarkSpacing = tickMarkSpacing * kratio;
    
    // Create the ticks on the x-axis
    float realX = self.origin.x;
    float gameX = 0;
    for (; realX <= self.origin.x + xAxisLength; realX += realTickMarkSpacing, gameX += tickMarkSpacing)
    {
        CGPoint currentPosition = CGPointMake(realX, self.origin.y);
        
        // Draw ticks
        // Don't draw a tick at (0, 0)
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
        
        // Add a label for the number below the tick
        SKLabelNode *coordLabel = [SKLabelNode labelNodeWithFontNamed:@"Marker"];
        coordLabel.text = [NSString stringWithFormat:@"%1.0f", gameX];
        coordLabel.position = CGPointMake(currentPosition.x, currentPosition.y - offset);
        [self addChild:coordLabel];
        
    }
    
    // Create the ticks on the y-axis
    float realY = self.origin.y;
    float gameY = 0;
    for (; realY <= self.origin.y + yAxisLength; realY += realTickMarkSpacing, gameY += tickMarkSpacing)
    {
        CGPoint currentPosition = CGPointMake(self.origin.x, realY);
        
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
        
        // Add a label for the number below the tick
        SKLabelNode *coordLabel = [SKLabelNode labelNodeWithFontNamed:@"Marker"];
        coordLabel.text = [NSString stringWithFormat:@"%1.0f", gameY];
        coordLabel.position = CGPointMake(currentPosition.x - offset, currentPosition.y);
        [self addChild:coordLabel];
        //[self addChild:sprite];
    }
}

// Draws the grid
- (void)drawGrid {
    // Set the origin at (0, 0)
    self.origin = CGPointMake(CGRectGetMinX(self.frame) + 15 * kratio, CGRectGetMinY(self.frame) + 15 * kratio);
    
    // Create x and y axes
    [self createXAxis];
    [self createYAxis];
    
    // Draw ticks
    [self createTicks];
    
}

#pragma mark - UI components
// Creates button bar
- (void) createButtonBar {
    _selector = [self childNodeWithName:@"SelectorFrame"];
    _posSelector = [_selector childNodeWithName:@"PositionSelector"];
    _slopeSelector = [_selector childNodeWithName:@"SlopeSelector"];
}

/* SCENE FUNCTIONALITY */

// Called before each frame is rendered
-(void)update:(CFTimeInterval)currentTime {
    
}

// Called when a touch begins
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    for (UITouch *touch in touches) {
        
        for (int i =1; i <4; i++ )
        {
            SKShapeNode *button = [[_posSelector children] objectAtIndex:i];
            CGPoint location = [touch locationInNode:button];
            if ( CGPathContainsPoint(button.path, NULL, location, true) )
            {
                [_posSelector changeCurrentSelection:i];
                
            }
        }
        
        for (int j =1; j <4; j++ )
        {
            SKShapeNode *button = [[_slopeSelector children] objectAtIndex:j];
            CGPoint location = [touch locationInNode:button];
            if ( CGPathContainsPoint(button.path, NULL, location, true) )
                if ( CGPathContainsPoint(button.path, NULL, location, true) )
                {
                    [_slopeSelector changeCurrentSelection:j];
                    
                }
        }
        
        CGPoint location = [touch locationInNode:self.fireButton];
        if (CGPathContainsPoint(self.fireButton.path, NULL, location, true))
        {
            [self fire];
        }
    }
}

- (void) createBackground {
    _background = [SKSpriteNode spriteNodeWithImageNamed:@"underwater-background.jpg"];
    _background.anchorPoint = CGPointZero;
    [self addChild:_background];
}

// Creates the message, health, and stats bars
- (void)createAllBars {
    // Call the methods to create the bar nodes
    _messageBar = [[MessageBarNode alloc]
                   initWithHeight:75
                   Width:self.size.width
                   AtX:0
                   Y:0
                   WithColor:[SKColor yellowColor]
                   LineWidth:0.25
                   AndInitialMessage:@"Choose an intercept and slope to fire at the enemies along the correct path."];
    
    //_statsBar = [[StatsBarNode alloc] initWithHeight:30 Width:1024 AtX:0 Y:736];
    
    _timerBox = [[TimerBoxNode alloc]
                 initWithHeight:50
                 Width:100
                 AtX:self.size.width - 150 // 150 = scoreBox's x - timerBox's width
                 //_posSelector.posSelectorWidth - (_selector.frameWidth * 2) - 10
                 Y:self.size.height - 75
                 WithColor:[SKColor yellowColor]
                 LineWidth:0.25
                 AndTimerSeconds:120];
    
    _scoreBox = [[ScoreBoxNode alloc]
                 initWithHeight:50
                 Width: 100
                 AtX:50 // same as the health bar
                 Y:self.size.height - 75
                 WithColor:[SKColor yellowColor]
                 LineWidth:0.25
                 TotalQuestions:10
                 AndLossRatio:0.4];
    
    
    _healthBar = [[HealthBarNode alloc]
                  initWithHeight:self.size.height - (_messageBar.height * 3)
                  Width:50
                  AtX:50
                  Y:_messageBar.height * 1.75 + 5
                  WithLineWidth:0.25
                  AndTotalQuestions:10]; // for now, the levels have 10 questions; TODO: make not magic number
    
//    [_healthBar decrementHealth];
//    [_healthBar decrementHealth];
//    [_healthBar decrementHealth];
//    [_healthBar decrementHealth];
//    [_healthBar decrementHealth];
//    [_healthBar decrementHealth];
//    [_healthBar decrementHealth];
//    NSLog(@"isDefeated = %s", [_healthBar isDefeated] ? "true" : "false");
//    [_healthBar decrementHealth];
//    [_healthBar decrementHealth];
//    [_healthBar decrementHealth];
//    NSLog(@"isDefeated = %s", [_healthBar isDefeated] ? "true" : "false");
//    [_healthBar decrementHealth];
//    NSLog(@"isDefeated = %s", [_healthBar isDefeated] ? "true" : "false");
    
    
    //_healthBar = [[HealthBarNode alloc] initWithHeight:50 Width:600 AtX:10 Y:115];
    
    
    // Add the bar and box nodes to the main parent node
    [self addChild:_messageBar];
    [self addChild:_healthBar];
    [self addChild:_scoreBox];
    [self addChild:_timerBox];
}

// Creates the fire button
- (void)createFireButton {
    // Fire Label
    SKLabelNode *fireText = [SKLabelNode labelNodeWithFontNamed:@"Marker"];
    fireText.text = @"FIRE!";
    fireText.position = CGPointMake(75, 35);
    
    // Fire Button
    _fireButton = [SKShapeNode node];
    CGRect fireButtonRect = CGRectMake(0, 0, 150, 100);
    CGPathRef fireButtonPath =  CGPathCreateWithRect(fireButtonRect, NULL);
    _fireButton.path = fireButtonPath;
    _fireButton.fillColor = [SKColor colorWithRed:1 green:0 blue:0 alpha:1];
    _fireButton.position = CGPointMake(850, 100);
    [_fireButton addChild:fireText];
    [self addChild:_fireButton];
}

@end
