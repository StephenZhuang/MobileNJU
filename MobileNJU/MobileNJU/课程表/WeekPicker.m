//
//  WeekPicker.m
//  CreateLesson
//
//  Created by luck-mac on 14-7-27.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import "WeekPicker.h"
#import "WeekCell.h"
@implementation WeekPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSArray *)weekButtons
{
    if (!_weekButtons) {
        _weekButtons = [[NSArray alloc]init];
    }
    return _weekButtons;
}
-(void)addWeek
{
    [self.cancelButton setTintColor:[UIColor blackColor]];
    [self.doneButton setTintColor:[UIColor blackColor]];
    [self.chooseAllBt setSelected:YES];
    
    
    
    NSMutableArray* weekButtons = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<5; i++) {
        for (int j=0; j<5; j++) {
            WeekCell* weekCell = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:1];
            [weekCell setFlag:1];
            CGRect frame = CGRectMake(j*60, i*36, 60, 36);
            [weekCell setFrame:frame];
            [weekCell setNum:i*5+j+1];
            weekCell.layer.borderColor = [UIColor whiteColor].CGColor;
            weekCell.layer.borderWidth=0.5;
            weekCell.myDelegate = self;
            [weekButtons addObject:weekCell];
            
            [self.chooseArea addSubview:weekCell];
            
        }
    }
    
    self.weekButtons = weekButtons;
}

- (void)clearAll
{
    for (int i = 0; i<self.weekButtons.count; i++) {
        [[self.weekButtons objectAtIndex:i] setFlag:0];
    }
}
- (void)chooseAll
{
    for (int i = 0; i<self.weekButtons.count; i++) {
        [[self.weekButtons objectAtIndex:i] setFlag:1];
    }
}
- (IBAction)chooseSIngle:(id)sender {
    if (self.chooseSingleBt.isSelected) {
        [self.chooseSingleBt setSelected:NO];
    } else {
        [self.chooseDoubleBt setSelected:NO];
        [self.chooseAllBt setSelected:NO];
        [self.chooseSingleBt setSelected:YES];
    }
    [self clearAll];
    for (int i = 0; i<self.weekButtons.count; i=i+2) {
        [[self.weekButtons objectAtIndex:i] setFlag:self.chooseSingleBt.isSelected?1:0];
    }
}
- (IBAction)chooseDouble:(id)sender {
    if ([self.chooseDoubleBt isSelected]) {
        [self.chooseDoubleBt setSelected:NO];
    } else {
        [self.chooseDoubleBt setSelected:YES];
        [self.chooseAllBt setSelected:NO];
        [self.chooseSingleBt setSelected:NO];
    }
    [self clearAll];
    for (int i = 1; i<self.weekButtons.count; i=i+2) {
        [[self.weekButtons objectAtIndex:i] setFlag:self.chooseDoubleBt.isSelected?1:0];
    }
}
- (IBAction)chooseAll:(id)sender {
    if ([self.chooseAllBt isSelected]) {
        [self.chooseAllBt setSelected:NO];
    } else {
        [self.chooseDoubleBt setSelected:NO];
        [self.chooseAllBt setSelected:YES];
        [self.chooseSingleBt setSelected:NO];
    }
    if (self.chooseAllBt.isSelected) {
        [self chooseAll];
    } else {
        [self clearAll];
    }
  
}


- (IBAction)cancel:(id)sender {
    [self.delegate cancel];
}
- (IBAction)done:(id)sender {
    NSMutableArray *result = [[NSMutableArray alloc]init];

    if (self.chooseAllBt.isSelected) {
        [result addObject:@"全部"];
    } else if (self.chooseSingleBt.isSelected)
    {
        [result addObject:@"单周"];

    }else if (self.chooseDoubleBt.isSelected)
    {
        [result addObject:@"双周"];
        
    } else{
        for (WeekCell *cell in self.weekButtons) {
            if (cell.select) {
                [result addObject:[NSString stringWithFormat:@"%d",cell.number]];
            }
        }
    }
   
    [self.delegate done:result];
}

- (void)chooseWeek:(NSInteger)num select:(BOOL)select
{
   
    int allFlag=1;
    int singleFlag=1;
    int doubleFlag=1;
    for (WeekCell* cell in self.weekButtons) {
        if (cell.select==0) {
            allFlag=0;
            if (cell.number%2==0) {
                doubleFlag=0;
            } else {
                singleFlag=0;
            }
        } else {
            if (cell.number%2==0) {
                singleFlag=0;
            } else {
                doubleFlag=0;
            }
        }
        if (doubleFlag==0&&singleFlag==0&&allFlag==0) {
            break;
        }
    }
    [self.chooseAllBt setSelected:allFlag==1];
    [self.chooseSingleBt setSelected:singleFlag==1];
    [self.chooseDoubleBt setSelected:doubleFlag==1];
    
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
