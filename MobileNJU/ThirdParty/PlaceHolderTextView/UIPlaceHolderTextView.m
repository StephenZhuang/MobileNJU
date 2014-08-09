//
//  UIPlaceHolderTextView.m
//  Property
//
//  Created by admin on 14-1-8.
//  Copyright (c) 2014年 lijun. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@implementation UIPlaceHolderTextView

@synthesize placeHolderLabel;

@synthesize placeholder;

@synthesize placeholderColor;



//- (void)dealloc
//
//{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//    [placeHolderLabel release]; placeHolderLabel = nil;
//    
//    [placeholderColor release]; placeholderColor = nil;
//    
//    [placeholder release]; placeholder = nil;
//    
//    [super dealloc];
//    
//}



- (void)awakeFromNib

{
    
    [super awakeFromNib];
    
    [self setPlaceholder:@""];
    
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
}



- (id)initWithFrame:(CGRect)frame

{
    
    if( (self = [super initWithFrame:frame]) )
        
    {
        
        [self setPlaceholder:@""];
        
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    
    return self;
    
}



- (void)textChanged:(NSNotification *)notification

{
    
    if([[self placeholder] length] == 0)
        
    {
        
        return;
        
    }
    
    
    
    if([[self text] length] == 0)
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    else
        
    {
        
        [[self viewWithTag:999] setAlpha:0];
        
    }
    
    CGSize size = CGSizeMake(self.bounds.size.width - 16,2000);
    CGSize newsize = [self.text sizeWithFont:[self font] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    CGRect rect = _letterNumLabel.frame;
    rect.origin.y = 8 + newsize.height;
    [_letterNumLabel setFrame:rect];
    [_letterNumLabel setText:[NSString stringWithFormat:@"%i/120",self.text.length]];
    if (self.text.length > 120) {
        [_letterNumLabel setTextColor:[UIColor redColor]];
    } else {
        [_letterNumLabel setTextColor:[UIColor lightGrayColor]];
    }
    self.contentSize = CGSizeMake(self.contentSize.width, CGRectGetMaxY(_letterNumLabel.frame));
    [self setNeedsLayout];
    [self setNeedsDisplay];
    NSLog(@"%f,%f",self.contentSize.height ,CGRectGetMaxY(_letterNumLabel.frame));
}

- (void)setPlaceholder:(NSString *)aPlaceholder
{
    placeholder = aPlaceholder;
    [self.placeHolderLabel setText:self.placeholder];
    if([[self text] length] == 0)
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    else
        
    {
        
        [[self viewWithTag:999] setAlpha:0];
        
    }
}



- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    [self textChanged:nil];
    
}



- (void)drawRect:(CGRect)rect

{
    if ( IOS7_OR_LATER ) {
        self.contentInset=UIEdgeInsetsMake(0, 0, 20, 0);
    }
    
    if( [[self placeholder] length] > 0 )
        
    {
        
        if ( placeHolderLabel == nil )
            
        {
            
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            
            placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            placeHolderLabel.numberOfLines = 0;
            
            placeHolderLabel.font = self.font;
            
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            
            placeHolderLabel.textColor = self.placeholderColor;
            
            placeHolderLabel.alpha = 0;
            
            placeHolderLabel.tag = 999;
            
            [self addSubview:placeHolderLabel];
            
        }
        
        if (_letterNumLabel == nil) {
            _letterNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 30, self.bounds.size.width - 16, 21)];
            _letterNumLabel.textAlignment = NSTextAlignmentRight;
            _letterNumLabel.font = [UIFont systemFontOfSize:12];
            _letterNumLabel.text = @"0/120";
            _letterNumLabel.textColor = [UIColor lightGrayColor];
            [self addSubview:_letterNumLabel];
        }
        
        
        
        placeHolderLabel.text = self.placeholder;
        
        [placeHolderLabel sizeToFit];
        
        [self sendSubviewToBack:placeHolderLabel];
        
    }
    
    
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    
    
    [super drawRect:rect];
    
}

@end
