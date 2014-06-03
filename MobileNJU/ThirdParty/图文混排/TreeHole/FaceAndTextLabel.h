//
//  FaceAndTextLabel.h
//  FaceAndText
//
//  Created by Ibokan on 14-4-10.
//  Copyright (c) 2014年 CainiaoLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FaceMatch.h"

#define kICON_SIZE 20.0f
#define kLINE_HEIGHT 20.0f
#define kSPACE_WIDTH 2.0f

@interface FaceAndTextLabel : UILabel
{
    int line;
    float xIndex;
    float yIndex;
    float maxWidth;

}
-(void)setFaceAndText:(NSString *)string;
@end
