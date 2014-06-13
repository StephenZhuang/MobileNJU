//
//  ConnectViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-12.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NanguaBaseViewController.h"
#import "ConnectVIew.h"

typedef void(^MatchSuccessBlcok)(NSString *targetid , int targethead ,NSString *headImg);

@interface ConnectViewController : NanguaBaseViewController
@property (nonatomic , weak) IBOutlet ConnectVIew *connentView;
@property (nonatomic , copy) NSString *headImg;
@property (nonatomic , copy) MatchSuccessBlcok matchSuccessBlock;
@end
