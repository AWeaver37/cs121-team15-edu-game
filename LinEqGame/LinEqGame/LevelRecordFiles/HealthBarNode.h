//
//  HealthBarNode.h
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/21/13.
//  Copyright (c) 2013 CS121. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "BarBoxNodeBase.h"

@interface HealthBarNode : BarBoxNodeBase

// Boolean that keeps track of whether there is any health left
@property (nonatomic, readonly) bool isDefeated;

// Constructor
- (id)initWithHeight:(int)h Width:(int)w AtX:(int)x Y:(int)y
       WithLineWidth:(CGFloat)lW AndTotalQuestions:(int)q;

- (void)incrementHealth;
- (void)decrementHealth;
- (void)changeHealth:(int)amountToChange;

- (void)reset;

@end
