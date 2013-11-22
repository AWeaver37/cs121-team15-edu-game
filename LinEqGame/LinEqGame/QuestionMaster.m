//
//  QuestionMaster.m
//  LinEqGame
//
//  Created by CS121 on 11/15/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "QuestionMaster.h"

@implementation QuestionMaster

- (id) init{
    if (self == [super init]){
        srandom(time(NULL));
        _minX = 0;
        _maxX = 80;
        
        _minY = -30;
        _maxY = 30;
        
        _maxSlopeNum = 9;
        _maxSlopeDen = 9;
    }
    return self;
}

- (double) valueAt: (double) x withSlope: (Fraction*) slope withIntercept: (double) intercept{
    return slope.decimalValue*x+intercept;
}

- (BOOL) isValue: (double) value between: (double) bound1 and: (double) bound2{
    return ((bound1 < value) == (bound2 > value));
}

- (int) randomBetween: (int)lowerBound And: (int) upperBound{
    return random()%(upperBound - lowerBound + 1) + lowerBound;
}

- (void) setSlope:(Fraction*) slope boundedBy: (double) maxSlope{
    
    do {
        slope.numerator = [self randomBetween: -_maxSlopeNum And: _maxSlopeNum];
        slope.denominator = [self randomBetween: 1 And: _maxSlopeDen];
    } while (!([self isValue:slope.decimalValue between:-maxSlope and:maxSlope] && slope.numerator!=0));
}

- (void) setIntercept: (Fraction*) intercept
             setAlien: (Location*) alien
     betweenAlienMinX: (int) alienMinX
     betweenAlienMaxX: (int) aliemMaxX
            withSlope: (Fraction*) slope{
    
    do {
        alien.x = [self randomBetween: alienMinX And: aliemMaxX];
        alien.y = [self randomBetween: _minY And: _maxY];
        
        intercept.numerator = alien.y*slope.denominator-alien.x*slope.numerator;
        intercept.denominator = slope.denominator;
        
    } while (
             !([self isValue: intercept.decimalValue between:_minY and:_maxY]
               &&
               [self isValue:
                
                [self
                 valueAt:_maxX
                 withSlope:slope
                 withIntercept:intercept.decimalValue]
                
                     between:_minY and:_maxY]
               ));
}

- (void) setSecondAlien: (Location*) secondAlien
       betweenAlienMinX: (int) alienMinX
       betweenAlienMaxX: (int) alienMaxX
              withSlope: (Fraction*) slope
         withFirstAlien: (Location*) firstAlien{
    

    
    int slopeHopMax = (alienMaxX - firstAlien.x)/(slope.denominator);
    int slopeHopMin = (alienMinX - firstAlien.x)/(slope.denominator)+1;
    int slopeHop = [self randomBetween:slopeHopMin And:slopeHopMax];
    
    secondAlien.x = firstAlien.x + slopeHop*slope.denominator;
    secondAlien.y = firstAlien.y + slopeHop*slope.numerator;
}

- (void) setCorrectIndex: (int*) indexAddress
          setChoiceArray: (NSMutableArray*) choices
               forAnswer: (Fraction*) answer
         withOffsetLevel: (int) offsetLevel{
    
    assert(offsetLevel>0);
    
    NSMutableArray* offsets = [[NSMutableArray alloc] initWithCapacity:3];
    do {
        for (int i = 0; i < 2; ++i) {
            NSNumber* offset = [[NSNumber alloc] initWithInt: [self randomBetween:0 And:1 + offsetLevel]];
            [offsets setObject:offset atIndexedSubscript: i];
        }
    } while ([[offsets objectAtIndex:0] integerValue]==[[offsets objectAtIndex:1] integerValue]);
    
    NSNumber* centerValue;
    do {
        centerValue = [[NSNumber alloc] initWithInt:[self randomBetween:0 And:1 + offsetLevel]];
    } while (
             [centerValue integerValue]==[[offsets objectAtIndex:1] integerValue]
             ||
             [centerValue integerValue]==[[offsets objectAtIndex:0] integerValue]);
    
    for (int i = 0; i < 2; ++i) {
        int totalOffset = [[offsets objectAtIndex:i] integerValue]-[centerValue integerValue];
        Fraction* wrongChoice = [[Fraction alloc]
                                 initWithNum:answer.numerator + totalOffset
                                 AndDen:answer.denominator];
        [wrongChoice simplify];
        [choices setObject:wrongChoice atIndexedSubscript:i];
    }
    [answer simplify];
    *indexAddress = [self randomBetween:0 And:2];
    [choices insertObject: answer atIndex:*indexAddress];
    
    
    
    
}

- (QuestionObject*) generateQuestion{
    
    int rangeX = _maxX - _minX;
    int rangeY = _maxY - _minY;
    double maxSlope = ((double)rangeY)/(rangeX);
    

    Fraction* slope = [[Fraction alloc] init];
    Fraction* intercept = [[Fraction alloc] init];
    
    Location* alien1 = [[Location alloc] init];
    Location* alien2 = [[Location alloc] init];
    NSMutableArray* slopeChoices = [[NSMutableArray alloc] init];
    NSMutableArray* interceptChoices = [[NSMutableArray alloc] init];
    int slopeIndex;
    int interceptIndex;
    
    [self setSlope: slope
         boundedBy: maxSlope];
    
    [self setIntercept: intercept
              setAlien: alien1
      betweenAlienMinX: _minX+rangeX*1/5
      betweenAlienMaxX: _minX+rangeX*3/5
             withSlope: slope];
    
    [self setSecondAlien: alien2
        betweenAlienMinX: alien1.x+rangeX*1/5
        betweenAlienMaxX: _maxX
               withSlope: slope
          withFirstAlien: alien1];
    
    [self setCorrectIndex: &slopeIndex
           setChoiceArray: slopeChoices
                forAnswer: slope
          withOffsetLevel: 2];
    
    [self setCorrectIndex: &interceptIndex
           setChoiceArray: interceptChoices
                forAnswer: intercept
          withOffsetLevel: 10];

    
    
    QuestionObject* newQuestion = [[QuestionObject alloc] init];
    newQuestion.slopeAnswer = [[AnswerChoice alloc]
                               initWithChoices: slopeChoices
                               withAnswerIndex: slopeIndex];
    newQuestion.interceptAnswer = [[AnswerChoice alloc]
                                   initWithChoices: interceptChoices
                                   withAnswerIndex: interceptIndex];
    newQuestion.enemyLocations = [[NSMutableArray alloc] init];
    
    [newQuestion.enemyLocations addObject: alien1];
    [newQuestion.enemyLocations addObject: alien2];
    
    
    return newQuestion;
}



@end
