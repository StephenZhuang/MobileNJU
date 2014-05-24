//
//  TagView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagButton.h"

@interface TagView : UIView
@property(nonatomic,strong)NSArray* tags;
@property (nonatomic,strong)TagButton* selectedTag1;
@property (nonatomic,strong)TagButton* selectedTag2;
- (void)initialTags;
- (NSString*)getHobbies;
- (void)setHobbies:(NSArray*) hobbies;;
@end
