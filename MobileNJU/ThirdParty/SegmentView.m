//
//  SegmentView.m
//  SegmentDemo
//
//  Created by admin on 14-3-7.
//  Copyright (c) 2014年 lijun. All rights reserved.
//

#import "SegmentView.h"
#import <QuartzCore/QuartzCore.h>

#define GrayColor ([UIColor colorWithRed:76 / 255.0 green:76 / 255.0 blue:76 / 255.0 alpha:1.0])

#define blackColor ([UIColor colorWithRed:24 / 255.0 green:24 / 255.0 blue:24 / 255.0 alpha:1.0])

#define DarkGrayColor ([UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.0])
@implementation SegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    _selectedIndex = [_dataSource defaultSelectedSegment];
    
//    self.layer.cornerRadius = 5;
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor colorWithRed:110/255.0 green:15/255.0 blue:109/255.0 alpha:1.0].CGColor;
    [self setBackgroundColor:[_dataSource colorForLine]];
    
    int itemCount = [_dataSource numOfSegments];
    CGFloat buttonWidth = self.frame.size.width / itemCount;
    buttonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i< itemCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, self.frame.size.height)];
        
        NSString *title = [_dataSource segmentView:self nameForSegment:i];
        [button setTitle:title forState:UIControlStateNormal];
       
        
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [button setTitleColor:GrayColor forState:UIControlStateNormal];
        [button setTitleColor:blackColor forState:UIControlStateHighlighted];
        [button setTitleColor:blackColor forState:UIControlStateSelected];
        [button setBackgroundColor:DarkGrayColor];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == [_dataSource defaultSelectedSegment]) {
            [button setSelected:YES];
            [button setBackgroundColor:[UIColor whiteColor]];
        }

        [self addSubview:button];
        if (i != 0) {
            [self drawLine:i * buttonWidth end:self.frame.size.height];
        }
        
        [buttonArray addObject:button];
    }

    self.clipsToBounds = YES;
}

- (void)buttonAction:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    
    if (!button.selected) {
//        [UIView animateWithDuration:0.3 animations:^(void) {
//            [selectedImage setFrame:button.frame];
//        }];
        
        for (UIButton *btn in buttonArray) {
            [btn setSelected:NO];
            [btn setBackgroundColor:DarkGrayColor];
            
//            [btn setHidden:YES];
        }
        
        [button setSelected:YES];
        [button setBackgroundColor:[UIColor whiteColor]];
        _selectedIndex = button.tag;
        [_delegate selectSegmentAtIndex:button.tag];
    }
}

- (void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self buttonAction:[buttonArray objectAtIndex:selectedIndex]];
}


- (void)drawLine:(CGFloat)x end:(CGFloat)y
{
//    CGColorRef color = [[_dataSource colorForLine] CGColor];
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取当前ctx
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(ctx, 0.5);  //线宽
//    CGContextSetAllowsAntialiasing(ctx, YES);
//    CGContextSetStrokeColorWithColor(ctx, color);
//    CGContextBeginPath(ctx);
//    CGContextMoveToPoint(ctx, x, 0);  //起点坐标
//    CGContextAddLineToPoint(ctx, x, y);   //终点坐标
//    CGContextStrokePath(ctx);
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 1, y)];
//    [view setBackgroundColor:[_dataSource colorForLine]];
//    [self addSubview:view];
//    [view release];
}

- (void)dealloc
{
//    [buttonArray release];
//    [super dealloc];
}

@end
