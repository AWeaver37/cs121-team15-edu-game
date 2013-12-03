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

//Bounds on where enemies can appear
@property int minX;
@property int maxX;
@property int minY;
@property int maxY;

//Bounds on the slope of form numerator/denominator
//Denominator should be significantly less than maxX-minX
@property int maxSlopeNum;
@property int minSlopeNum;
@property int maxSlopeDen;
@property int minSlopeDen;

@end
