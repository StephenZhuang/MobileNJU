//
//  MsgDialog.h
//  protobufTest
//
//  Created by lu liu on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIAlertView.h>

@interface MsgDialog : NSObject<UIAlertViewDelegate>

-(id)init:(id)context;

-(void)show;

-(void)dismiss;

-(void)setMsg:(ErrMsg *)nmsg;

-(id)getContext;

-(NSString*)getMsg;

-(int)getType;
@end
