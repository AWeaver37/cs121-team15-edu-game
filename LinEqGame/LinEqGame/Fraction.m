//
//  Fraction.m
//  LinEqGame
//
//  Created by CS121 on 11/17/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

- (id) initWithNum: (int) numerator AndDen: (int) denominator{
    if (self == [super init]){
        _numerator = numerator;
        _denominator = denominator;
    }
    return self;
}

- (double) decimalValue{
    return ((double)_numerator)/_denominator;
}

@end
