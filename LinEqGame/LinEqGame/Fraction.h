//
//  Fraction.h
//  LinEqGame
//
//  Created by CS121 on 11/17/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

- (id) initWithNum: (int) numerator AndDen: (int) denominator;

- (double) decimalValue;

@property int numerator;

@property int denominator;



@end
