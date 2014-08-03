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
@property (nonatomic,strong)NSArray* weekTitle;
@property (nonatomic,strong)NSArray* classTitle;
@property (nonatomic)int day;
@property (nonatomic)int start;
@property (nonatomic)int end;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.day = 0 ;
    self.start = 0;
    self.end = 0;
    self.weekTitle = [NSArray arrayWithObjects:@"周一" ,@"周二",@"周三",@"周四",@"周五",@"周六",@"周日",nil];
    self.classTitle =  [NSArray arrayWithObjects:@"第1节",@"第2节",@"第3节",@"第4节",@"第5节",@"第6节",@"第7节",@"第8节",@"第9节",@"第10节",@"第11节",nil];
    [self.tableView setScrollEnabled:NO];
    if([self.navigationController.navigationBar
        respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        [self.navigationController.navigationBar  setBackgroundImage:[[UIImage imageNamed:@"navigationBack"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]   forBarMetrics:UIBarMetricsDefault];
    }

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)disposeMessage:(Son*)son
{
    if ([son getError]==0) {
        MRet_Builder* ret = (MRet_Builder*)[son getBuild];
        [ToolUtils showMessage:ret.msg];
    }
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
    for (int i = 0 ; i < self.weekTitle.count; i++)
    {
        if ([[titles firstObject] isEqualToString:[self.weekTitle objectAtIndex:i]]) {
            self.day = i+1;
            break;
        }
    }
    for (int i = 0 ; i < self.classTitle.count; i++)
    {
        if ([[titles objectAtIndex:1] isEqualToString:[self.classTitle objectAtIndex:i]]) {
            self.start = i+1;
        }
        if ([[titles objectAtIndex:2] isEqualToString:[self.classTitle objectAtIndex:i]]) {
            self.end = i+1;
        }
    }
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
                                    self.weekTitle,
                                    self.classTitle
                                     ,self.classTitle,
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
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender {
    
    if (self.lessonNameField.text.length==0) {
        [ToolUtils showMessage:@"请输入课程名"];
        return;
    }
   
    if (self.weekField.text.length==0) {
        [ToolUtils showMessage:@"请选择上课周数"];
        return;
    }
    if (self.timeField.text.length==0) {
        [ToolUtils showMessage:@"请选择上课时间"];
        return;
    }
    
    MAddClass_Builder* builder = [[MAddClass_Builder alloc]init];
    builder.account = self.account==nil?@"":self.account;
    builder.name = self.lessonNameField.text;
    builder.teacher = self.teacherNameField.text;
    builder.address = self.classroomField.text;
    builder.week = self.weekField.text;
    builder.day = self.day;
    builder.begin = self.start;
    builder.end = self.end;
    builder.time = self.timeField.text;
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddClass" params:builder  delegate:self selecter:@selector(disposMessage:)];
    
    [DataManager loadData:[[NSArray alloc] initWithObjects:updateone, nil] delegate:self];

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
