//
//  HBTalkTableViewCell.m
//  MyTest
//
//  Created by weqia on 13-8-10.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkTableViewCell.h"

@implementation HBTalkTableViewCell
@synthesize talkData,imageView;

-(BOOL) canBecomeFirstResponder
{
    return YES;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _time=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        _cellContent=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
        [self addSubview:_time];
        [self addSubview:_cellContent];
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [_cellContent setBackgroundColor:[UIColor clearColor]];
        [_time setBackgroundColor:[UIColor clearColor]];
        
        _mLogo=[[UIImageView alloc]init];
        _mLogo.layer.cornerRadius=20;
        _mLogo.clipsToBounds=YES;
        _mLogo.image=[UIImage imageNamed:@"fruit_0_s"];
        _mLogo.layer.shadowColor=[UIColor lightGrayColor].CGColor;
        _mLogo.layer.shadowOpacity=0.5;
        _mLogo.layer.shadowOffset=CGSizeMake(4, 4);
        [_cellContent addSubview:_mLogo];
        
        _backView=[[UIImageView alloc]init];
        [_cellContent addSubview:_backView];
        _cellContent.userInteractionEnabled=YES;
        _content=[[UIView alloc]init];
        [_backView addSubview:_content];
        _content.backgroundColor=[UIColor clearColor];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.userInteractionEnabled=YES;
        _backView.userInteractionEnabled=YES;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma -mark 接口方法

-(void) setLogoImage:(int)head
{
    [_mLogo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"logo_default_%i",head]]];
}

-(void)setLogoImageWithImage:(UIImage*)image
{
    [_mLogo setImage:image];
}

+(float)getHeightByContent:(MChat *)data
{
    float height=0.0f;
    if(data.img.length > 0){
        NSArray *arr = [data.size componentsSeparatedByString:@"x"];
        
        if([[arr lastObject] floatValue] >IMAGE_MAX_WIDTH)
            return IMAGE_MAX_WIDTH+10+height;
        else
            return MAX(40, [[arr lastObject] floatValue]+10+height);
    } else {
        MatchParser *match = [[MatchParser alloc] init];
        match.width = 200;
        match.font = [UIFont systemFontOfSize:17];
        [match match:data.content];
        return MAX(19, match.height) + 40 + height;
    }
    return 60+height;
}

-(void)setContent
{
//    long long pre_time=0.0f;
//    if(self.preTalkData!=nil)
//        pre_time=self.preTalkData.timeInterval.longLongValue;
//    long long now_time=0.0f;
//    if(self.talkData!=nil)
//        now_time=self.talkData.timeInterval.longLongValue;
//    if(now_time-pre_time>5*60)
//    {
//        NSString * time=[TimeUtil getTimeStrStyle1:now_time];
//        CGSize size=[time sizeWithFont:[UIFont systemFontOfSize:13]];
    
//        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake((320-size.width-5)/2, 0, size.width+5, 16)];
//        label.backgroundColor=[UIColor lightGrayColor];
//        label.layer.cornerRadius=3;
//        label.alpha=0.3;
//        [_time addSubview:label];
//        
//        label=[[UILabel alloc]initWithFrame:CGRectMake((320-size.width-5)/2, 3, size.width+5, 10)];
//        label.textAlignment=NSTextAlignmentCenter;
//        label.textColor=[UIColor whiteColor];
//        label.backgroundColor=[UIColor clearColor];
//        label.font=[UIFont systemFontOfSize:10];
//        label.text=[TimeUtil getTimeStrStyle1:now_time];
//        [_time addSubview:label];
    
//        CGRect frame=_cellContent.frame;
//        frame.origin.y=25;
//        _cellContent.frame=frame;
//    }
}
#pragma -mark 私有方法

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame=_backView.frame;
    frame.size.width=_content.frame.size.width+20;
    frame.size.height=_content.frame.size.height+16;
    _backView.frame=frame;
    
    frame=_cellContent.frame;
    frame.size.height=_backView.frame.origin.y+_backView.frame.size.height;
    _cellContent.frame=frame;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [self clear];
}

-(void)clear
{
    _mLogo.image=[UIImage imageNamed:@"fruit_0_s"];
    for(UIView * view in _content.subviews)
        [view removeFromSuperview];
    for(UIView * view in _time.subviews)
        [view removeFromSuperview];
    for(UIView * view in _cellContent.subviews){
        if(view!=_mLogo&&view!=_backView)
           [view removeFromSuperview];
    }
    for(UIGestureRecognizer * ges in _backView.gestureRecognizers)
        [_backView removeGestureRecognizer:ges];
    CGRect frame=_cellContent.frame;
    frame.origin.y=0;
    _cellContent.frame=frame;
}



@end
