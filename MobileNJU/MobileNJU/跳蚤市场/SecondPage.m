//
//  SecondPage.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SecondPage.h"
@implementation SecondPage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark -初始化
- (void)drawRect:(CGRect)rect
{
    self.typeId = @"-1";
    self.QQField.delegate = self;
    self.typeField.delegate = self;
    self.locationField.delegate = self;
    self.phoneField.delegate = self;
    self.font = self.QQLabel.font;

}
- (IBAction)chooseType:(id)sender {
    NSMutableArray* typeArr = [[NSMutableArray alloc]init];
    for (int i = 1 ; i < self.typeList.count; i++) {
        MMarketType* type = [self.typeList objectAtIndex:i];
        [typeArr addObject:type.title];
    }
    self.typeArr= typeArr;
    [self returnLabel:self.lastField];
    [self.QQField resignFirstResponder];
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc]initWithTitle:@"请选择商品类别" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:123456];
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     self.typeArr,
                                     nil]];

    [picker showInView:self];
}

- (IBAction)chooseLocation:(id)sender {
    [self returnLabel:self.lastField];
    [self.QQField resignFirstResponder];
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc]initWithTitle:@"请选择交易地点" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:654321];
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     [NSArray arrayWithObjects:@"卫岗校区",@"浦口校区", nil],
                                     nil]];
    
    [picker showInView:self];
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.phoneField) {
        if (range.location >=11)
            return NO; // return NO to not change text
        return YES;
    }
    if (textField==self.QQField)
    {
        if (range.location >=12)
            return NO; // return NO to not change text
        return YES;
    }
    return YES;
}

#pragma textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self returnLabel:textField];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    if (textField==self.phoneField) {
        [self.QQField becomeFirstResponder];
    }
    return YES;
}

-(void) returnLabel:(id)textField
{
    if (textField==nil) {
        return;
    }
    UILabel *label;
    if (textField==self.QQField) {
        label = self.QQLabel;
    } else if (textField==self.phoneField)
    {
        label = self.phoneLabel;
    }
    
    if (((UITextField*)textField).text.length>0) {
    
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            [label setFont:self.font];
            [label setTextColor:[UIColor lightGrayColor]];
            label.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
}

-(void) changeLabel:(id)textField
{
    UILabel *label;
    if (textField==self.QQField) {
        label = self.QQLabel;
    } else if (textField==self.phoneField)
    {
        label = self.phoneLabel;
    }
    [UIView animateWithDuration:0.2f animations:^{
        [label setTextColor:[UIColor colorWithRed:0/255.0 green:147/255.0 blue:242/255.0 alpha:1]];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:10.0]];
        label.transform = CGAffineTransformMakeTranslation(0, -10);
    }];
    
    self.lastField = textField;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.typeField||textField==self.locationField) {
        return NO;
    }
    [self returnLabel:self.lastField];
    [self changeLabel:textField];
    CGRect frame = textField.frame;
    int offset = frame.origin.y +422 - (self.frame.size.height - 240);//键盘高度216
    NSLog(@"offset is %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.frame = rect;
    }
    [UIView commitAnimations];
    return YES;
}

#pragma mark -IQActionSheetDelegate
- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    
    if (pickerView.tag==123456) {
        [self.typeField setText:[titles firstObject]];
        for (int i = 0 ; i < self.typeArr.count; i++) {
            if ([[self.typeArr objectAtIndex:i] isEqualToString:[titles firstObject]]) {
                self.typeId = [NSString stringWithFormat:@"%d",i];
                break;
            }
        }
    } else {
        [self.locationField setText:[titles firstObject]];
    }
}
- (void)resignAll
{
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    CGRect rect = CGRectMake(0.0f,0,width,height);
    self.frame = rect;
    [self.lastField resignFirstResponder];
    [self returnLabel:self.lastField];
    
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
