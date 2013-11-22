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

- (NSString*) description{
    if (_denominator == 1) {
        return [NSString stringWithFormat:@"%d",_numerator];
    } else {
        return [NSString stringWithFormat:@"%d/%d",_numerator,_denominator];
    }
}

- (double) decimalValue{
    return ((double)_numerator)/_denominator;
}

- (void) simplify{
    if (_denominator < 0) {
        _denominator *= -1;
        _numerator *= -1;
    }
    
    int i = 2;
    while(i <= MAX(ABS(_numerator), _denominator))
    {
        if (_numerator%i == 0 && _denominator%i == 0) {
            _numerator /= i;
            _denominator /= i;
        } else {
            ++i;
        }
    }
}

- (int) integerPart{
    return _numerator/_denominator;
};

- (Fraction*) fractionPart{
    Fraction* fractionPart = [[Fraction alloc] init];
    fractionPart.numerator = ABS( _numerator%_denominator);
    fractionPart.denominator = _denominator;
    return fractionPart;
};

@end
