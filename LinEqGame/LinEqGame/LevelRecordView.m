//
//  LevelRecordView.m
//  LinEqGame
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "LevelRecordView.h"

@implementation LevelRecordView


/* Methods */

// Calculates the currentHealth based on the first true index in healthBar
// Note: does not update currentHealth, but can easily be changed to if desired.
// Use: currentHealth = calcCurrentHealth();
- (int)calcCurrentHealth {
    for (int top = healthBar.length(); top >= 0; --top) {
        if (healthBar[top] == true) {
            return top;
        }
    }
    
    // If none of the values in healthBar are true, return a -1 to indicate
    // that the healthBar is empty
    else {
        return -1;
    }
}


/* Pre-Written Functions */

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
