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
        _maxX = 100;
        
        _minY = -40;
        _maxY = 40;
        
        _maxSlopeNum = 9;
        _maxSlopeDen = 9;
        _minSlopeNum = 1;
        _minSlopeDen = 5;
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
        slope.numerator = [self randomBetween: _minSlopeNum And: _maxSlopeNum];
        slope.denominator = [self randomBetween: _minSlopeDen And: _maxSlopeDen];
        slope.numerator *= [self randomBetween:0 And: 1] * 2 - 1;
    } while (!([self isValue:slope.decimalValue between:-maxSlope and:maxSlope] && slope.numerator != 0));
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
       withOffsetBetween: (int) offsetLowerBound
                     and: (int) offsetUpperBound
          boundedBetween: (double) lowerBound
                     and: (double) upperBound{
    
    assert(offsetLowerBound>0);
    assert(offsetUpperBound>0);
    
    NSMutableArray* offsets = [[NSMutableArray alloc] initWithCapacity:3];
    int offset = 0;
    do {
        for (int i = 0; i < 3; ++i) {
            offset += [self randomBetween:offsetLowerBound And:offsetUpperBound];
            offsets[i] =  [[NSNumber alloc] initWithInt:offset];
        }
    } while ([offsets[0] integerValue]==[[offsets objectAtIndex:1] integerValue]);
    
    NSNumber* centerValue;
    
    do {
        *indexAddress = [self randomBetween:0 And:2];
        centerValue = offsets[*indexAddress];
        for (int i = 0; i < 3; ++i) {
            int totalOffset = [[offsets objectAtIndex:i] integerValue]-[centerValue integerValue];
            Fraction* wrongChoice = [[Fraction alloc]
                                     initWithNum:answer.numerator + totalOffset
                                     AndDen:answer.denominator];
            [wrongChoice simplify];
            wrongChoice.isMixedFormat = answer.isMixedFormat;
            [choices setObject:wrongChoice atIndexedSubscript:i];
        }
    } while (
             !(
             [self isValue:[(Fraction*)choices[0] decimalValue] between:lowerBound and:upperBound]
             &&
             [self isValue:[(Fraction*)choices[1] decimalValue] between:lowerBound and:upperBound]
             &&
             [self isValue:[(Fraction*)choices[2] decimalValue] between:lowerBound and:upperBound]
              ));
    
    
    
    
}

- (QuestionObject*) generateQuestion{
    
    int rangeX = _maxX - _minX;
    int rangeY = _maxY - _minY;
    double maxSlope = ((double)rangeY)/(rangeX);
    

    Fraction* slope = [[Fraction alloc] init];
    Fraction* intercept = [[Fraction alloc] init];
    //intercept.isMixedFormat = true;
    
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
        withOffsetBetween: 1
                      and: 1
           boundedBetween: -maxSlope
                      and: maxSlope];
    
    [self setCorrectIndex: &interceptIndex
           setChoiceArray: interceptChoices
                forAnswer: intercept
        withOffsetBetween: rangeY*intercept.denominator/10
                      and: rangeY*intercept.denominator/8
           boundedBetween: _minY
                      and: _maxY];

    
    
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
