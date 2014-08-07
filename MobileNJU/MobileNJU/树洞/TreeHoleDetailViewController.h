//
//  TreeHoleDetailViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "ZsndTreehole.pb.h"
#import "UIPlaceHolderTextView.h"

@interface TreeHoleDetailViewController : RefreshTableViewController<UITextFieldDelegate , UITextViewDelegate>
@property (nonatomic , weak) IBOutlet UIView *bottomView;
@property (nonatomic , weak) IBOutlet UITextField *messageField;
@property (nonatomic , copy) NSString *treeHoleid;
@property (nonatomic , strong) MTopic_Builder *topic;
@property (nonatomic , copy) NSString *targetid;
@property (nonatomic , copy) NSString *commentid;
@property (nonatomic , assign) double replyfloor;
@property (nonatomic , strong) NSArray *colorArray;
@property (nonatomic , weak) IBOutlet UIButton *lzButton;
@property (nonatomic , weak) IBOutlet UIPlaceHolderTextView *textView;
@property (nonatomic , weak) IBOutlet UIView *editView;
@end
