//
//  CCPHelperDelegate.h
//  MobileNJU
//
//  Created by luck-mac on 14/11/8.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCPHelperDelegate <NSObject>
-(void) reveiveData: (NSDictionary*) data method:(NSString*) method;
@end
