//
//  ViewController.m
//  CreateLesson
//
//  Created by luck-mac on 14-7-27.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import "ViewController.h"
#import "IQActionSheetPickerView.h"
#import "WeekPicker.h"
#import "weekPickerDelegate.h"
#import "WeekCell.h"
@interface ViewController ()<IQActionSheetPickerViewDelegate,weekPickerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lessonNameField;
@property (weak, nonatomic) IBOutlet UITextField *teacherNameField;
@property (weak, nonatomic) IBOutlet UITextField *classroomField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (nonatomic,strong)WeekPicker *weekPicker;
@property (weak, nonatomic) IBOutlet UITextField *weekField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setScrollEnabled:NO];
    if([self.navigationController.navigationBar
        respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        [self.navigationController.navigationBar  setBackgroundImage:[[UIImage imageNamed:@"navigationBack"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]   forBarMetrics:UIBarMetricsDefault];
    }

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enableAll:(BOOL)enable
{
    [self.lessonNameField setEnabled:enable];
    [self.teacherNameField setEnabled:enable];
    [self.classroomField setEnabled:enable];
}

-  (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    [self.timeField setText:[NSString stringWithFormat:@"%@ %@-%@",[titles firstObject],[titles objectAtIndex:1],[titles lastObject]]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.lessonNameField resignFirstResponder];
    [self.teacherNameField resignFirstResponder];
    [self.classroomField resignFirstResponder];

    
    if (indexPath.section==1&&indexPath.row==1) {
        if (self.weekPicker) {
            [self cancel];
        }
        [self showDateChoose];
    } else if (indexPath.section==1&&indexPath.row==2)
    {
        if (self.weekPicker)
        {
            [self.weekPicker removeFromSuperview];
        }
        [self enableAll:NO];
        WeekPicker* weekPicker = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:0];
        [weekPicker setFrame:CGRectMake(0, self.view.bounds.size.height, 320, 280)];
        [weekPicker addWeek];
        CGRect newFrame = CGRectMake(0, self.view.bounds.size.height-280, 320,280);
        [self.view addSubview:weekPicker];
        [UIView animateWithDuration:0.3 animations:^{
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                [weekPicker setFrame:newFrame];
            }
        }];
        weekPicker.delegate = self;
        self.weekPicker = weekPicker;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return nil;
    }
    if (indexPath.section==1&&indexPath.row==0) {
        return nil;
    }
    return indexPath;
}

-(void)showDateChoose
{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"请选择节数" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:233];
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     [NSArray arrayWithObjects:@"周一" ,@"周二",@"周三",@"周四",@"周五",@"周六",@"周日",nil],
                                     [NSArray arrayWithObjects:@"第1节",@"第2节",@"第3节",@"第4节",@"第5节",@"第6节",@"第7节",@"第8节",@"第9节",@"第10节",@"第11节",nil],
                                     [NSArray arrayWithObjects:@"第1节",@"第2节",@"第3节",@"第4节",@"第5节",@"第6节",@"第7节",@"第8节",@"第9节",@"第10节",@"第11节",nil],
                                     nil]];
    [picker showInView:self.view];

    
}

#pragma -mark weekchooseDelegate
- (void)cancel
{
    [self enableAll:YES];
    CGRect frame = CGRectMake(0, self.view.bounds.size.height, 320, 280);
    [UIView animateWithDuration:0.3 animations:^{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            [self.weekPicker setFrame:frame];
        }
    } completion:^(BOOL finished) {
        [self.weekPicker removeFromSuperview];
    }];
    self.weekPicker = nil;
}

- (void)done:(NSArray *)result
{
    
    [self cancel];
    NSMutableString* string = [[NSMutableString alloc]init];
    for (NSString* chooseNum in result) {
        [string appendFormat:@"%@ ",chooseNum];
    }
    [self.weekField setText:string];
    
}


#pragma -mark textfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField==self.lessonNameField) {
        [self.teacherNameField becomeFirstResponder];
    } else if (textField==self.teacherNameField){
        [self.classroomField becomeFirstResponder];
    } else if (textField==self.classroomField)
    {
        [self showDateChoose];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.weekPicker) {
        [self cancel];
    }
    return YES;
}
@end
