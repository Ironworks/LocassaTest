//
//  UIColor+LocassaColours.m
//  LocassaTest
//
//  Created by Trevor Doodes on 07/03/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import "UIColor+LocassaColours.h"

@implementation UIColor (LocassaColours)

//Return a random colour
+(UIColor *)randomColor {
    
    
    //Randomly generate the values for red, green, and blue
    CGFloat red = arc4random() % 256;
    CGFloat green = arc4random() % 256;
    CGFloat blue = arc4random() % 256;
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];

}

@end
