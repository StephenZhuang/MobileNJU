//
//  GradeCell.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-26.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "GradeCell.h"

@implementation GradeCell

- (void)addBorder
{
    self.tickButton.layer.borderWidth=1.0;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
    self.tickButton.layer.borderColor = borderColorRef;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addLineForLabel
{
   NSLog(@"字体%@",self.lessonNameLabel.font.fontName);
    self.lessonNameLabel.numberOfLines = 3;
	self.lessonNameLabel.font = [UIFont fontWithName:self.lessonNameLabel.font.fontName size:12];
}

- (void)setTick:(BOOL)tick
{
    _tick = tick;
    if (tick) {
        [self.tickButton setTitle:@"✓" forState:UIControlStateNormal];
        [self.tickButton setTitle:@"" forState:UIControlStateHighlighted];
        [self.tickButton setTitle:@"" forState:UIControlStateSelected];

    } else {
        [self.tickButton setTitle:@"" forState:UIControlStateNormal];
        [self.tickButton setTitle:@"✓" forState:UIControlStateHighlighted];
        [self.tickButton setTitle:@"✓" forState:UIControlStateSelected];


    }
}

- (IBAction)tick:(id)sender {
    if (self.tick) {
        [self setTick:NO];
    } else {
        [self setTick:YES];
    }
}

@end
