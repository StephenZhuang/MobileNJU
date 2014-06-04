//
//  TagView.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TagView.h"
@implementation TagView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
           }
    return self;
}

- (void)initialTags
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"selfInfo" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray* items = [data objectForKey:@"Tags"];
    for (int i = 0 ; i < items.count; i ++){
        TagButton* button = (TagButton*)[self.subviews objectAtIndex:i];
        [button setTagContent:[items objectAtIndex:i]];
        [button setSelected:NO];
        [button addTarget:self
                   action:@selector(chooseTag:)forControlEvents:UIControlEventTouchUpInside];
    }

}

-(NSString*)getHobbies
{
    if (self.selectedTag1==nil) {
        return @"";
    } else if (self.selectedTag2==nil){
        return self.selectedTag1.tagContent;
    } else {
        return [NSString stringWithFormat:@"%@、%@",self.selectedTag1.tagContent,self.selectedTag2.tagContent];
    }
}

- (void)chooseTag:(id)sender
{
    TagButton* selectedButton = (TagButton*) sender;
    if (self.selectedTag1==selectedButton) {
        self.selectedTag1 = self.selectedTag2;
        [selectedButton setChoose:NO];
    } else if (self.selectedTag2 == selectedButton){
        self.selectedTag2 = nil;
        [selectedButton setChoose:NO];
    } else if (self.selectedTag1==nil) {
        self.selectedTag1 = selectedButton;
        [selectedButton setChoose:YES];
    } else if (self.selectedTag2==nil){
        self.selectedTag2 = selectedButton;
        [selectedButton setChoose:YES];
    } else {
        [self.selectedTag1 setChoose:NO];
        self.selectedTag1 = self.selectedTag2;
        self.selectedTag2 = selectedButton;
        [selectedButton setChoose:YES];
    }
}

- (void)setHobbies:(NSArray *)hobbies
{
    for (NSString* hobby in hobbies) {
        NSLog(@"%@",hobby);
        for (UIView* view in self.subviews) {
            TagButton* button = (TagButton*)view;
            if ([button.tagContent isEqualToString:hobby]) {
                [self chooseTag:button];
                break;
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
