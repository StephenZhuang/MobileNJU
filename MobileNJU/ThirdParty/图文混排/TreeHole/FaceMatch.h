//
//  FaceMatch.h
//  FaceAndText
//
//  Created by Ibokan on 14-4-10.
//  Copyright (c) 2014年 CainiaoLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBEGIN_MARK @"["
#define kEND_MARK @"]"
@interface FaceMatch : NSObject
{
    NSMutableArray * _faceArray;

}
-(NSArray * )match:(NSString * )resourceString;
@end
