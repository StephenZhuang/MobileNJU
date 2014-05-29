//
//  ClassroomCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassroomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (nonatomic) NSInteger line;
-(void)addClassrooms:(NSArray*)classrooms;
@end
