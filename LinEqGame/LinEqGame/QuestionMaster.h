//
//  QuestionMaster.h
//  LinEqGame
//
//  Created by CS121 on 11/15/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionObject.h"
#import "Location.h"

@interface QuestionMaster : NSObject



- (QuestionObject*) generateQuestion;

@property int minX;
@property int maxX;
@property int minY;
@property int maxY;
@property int maxSlopeNum;
@property int maxSlopeDen;

@end
