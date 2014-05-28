//
//  SegmentView.h
//  SegmentDemo
//
//  Created by admin on 14-3-7.
//  Copyright (c) 2014年 lijun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SegmentView;
@protocol SegmentViewDataSource<NSObject>

@required
- (NSInteger)numOfSegments;
- (NSInteger)defaultSelectedSegment;
- (NSString *)segmentView:(SegmentView *)segmentView nameForSegment:(NSInteger)index;
- (UIColor *)colorForLine;
- (UIColor *)colorForTint;
@end

@protocol SegmentViewDelegate <NSObject>

- (void)selectSegmentAtIndex:(NSInteger)index;

@end

@interface SegmentView : UIView
{
    NSMutableArray *buttonArray;
}
@property (nonatomic , assign) IBOutlet id<SegmentViewDataSource> dataSource;
@property (nonatomic , assign) IBOutlet id<SegmentViewDelegate> delegate;
@property (nonatomic , assign) int selectedIndex;
@end
