//
//  LevelRecordView.h
//  LinEqGame
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelRecordView : UIView

/* Members */

// Keeps track of the user's score for the level
int scoreCounter;

// Keeps track of the time remaining to complete the level
double timeCounter;

// An array where each index corresponds to a section of the health bar.
// The value is true if the section remains and false if it has been depleted
boolean[] healthBar;


@end
