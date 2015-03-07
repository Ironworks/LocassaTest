//
//  Box.m
//  LocassaTest
//
//  Created by Trevor Doodes on 07/03/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import "Box.h"
#import "UIColor+LocassaColours.h"

@implementation Box

-(void)backgroundColourForBox {
    
    self.backgroundColor = [UIColor randomColor];
}

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        //Set bacground colour for box
        [self backgroundColourForBox];
    }
    
    return self;
}

-(instancetype) init {
    
    if (self = [super init]) {
        //Set background colour for box
        [self backgroundColourForBox];
    }
    
    return self;
}

@end
