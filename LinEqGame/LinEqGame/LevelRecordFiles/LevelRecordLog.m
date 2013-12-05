//
//  LevelRecord.m
//  LinEqGame.LevelRecord
//
//  Created by CS121 on 11/12/13.
//  Copyright (c) 2013 Alden Weaver. All rights reserved.
//

// DATA (Model)

#import "LevelRecordLog.h"


@implementation LevelRecordLog

// Constructor
- (id)init {
    return [super init];
}

// Must be the same as HEALTH_BAR_LENGTH
// Currently both are hard coded
- (void)setTotalLevelQuestions{
    _totalLevelQuestions = 10;
}



@end
