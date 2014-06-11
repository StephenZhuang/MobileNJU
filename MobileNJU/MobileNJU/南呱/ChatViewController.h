//
//  ChatViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-11.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NanguaBaseViewController.h"
#import "ConnectVIew.h"

@interface ChatViewController : NanguaBaseViewController
@property (nonatomic , weak) IBOutlet ConnectVIew *connentView;
@property (nonatomic , assign) BOOL isFromGua;
@end
