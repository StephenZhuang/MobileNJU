//
//  NewsDetailVC.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-14.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "NewsDetailVC.h"
#import <Frontia/Frontia.h>
#import <Frontia/FrontiaPush.h>
#import <Frontia/Frontia.h>
@interface NewsDetailVC ()

@end


@implementation NewsDetailVC
# pragma viewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.myTitle];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)share:(id)sender {
    FrontiaShareContent *content = [[FrontiaShareContent alloc] init];
    content.url = [[self.url.absoluteString componentsSeparatedByString:@"?"]firstObject];
    content.description = self.currentNew.content;
    content.title =    self.currentNew.title;
    content.imageObj = [self useImage:self.img];
    //分享取消回调函数
    FrontiaShareCancelCallback onCancel = ^(){
        NSLog(@"OnCancel: share is cancelled");
    };
    
    //分享失败回调函数
    FrontiaShareFailureCallback onFailure = ^(int errorCode, NSString *errorMessage){
        NSLog(@"OnFailure: %d  %@", errorCode, errorMessage);
    };
    
    //分享成功回调函数
    FrontiaMultiShareResultCallback onResult = ^(NSDictionary *respones){
        NSArray *successPlatforms = [respones objectForKey:@"success"];
        NSArray *failPlatforms = [respones objectForKey:@"fail"];
    };
    
    NSArray *sharePlatforms = @[FRONTIA_SOCIAL_SHARE_PLATFORM_SINAWEIBO,FRONTIA_SOCIAL_SHARE_PLATFORM_QQWEIBO,FRONTIA_SOCIAL_SHARE_PLATFORM_QQ,FRONTIA_SOCIAL_SHARE_PLATFORM_RENREN,FRONTIA_SOCIAL_SHARE_PLATFORM_KAIXIN,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION,FRONTIA_SOCIAL_SHARE_PLATFORM_QQFRIEND,FRONTIA_SOCIAL_SHARE_PLATFORM_EMAIL,FRONTIA_SOCIAL_SHARE_PLATFORM_SMS,FRONTIA_SOCIAL_SHARE_PLATFORM_COPY,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE];
    FrontiaShare *share = [Frontia getShare];
    [share registerQQAppId:@"100358052" enableSSO:YES];
    [share registerWeixinAppId:@"wx277782943f4c36be"];
    [share registerSinaweiboAppId:@"306527345"];
    [share showShareMenuWithShareContent:content displayPlatforms:sharePlatforms supportedInterfaceOrientations:UIInterfaceOrientationMaskAll isStatusBarHidden:NO targetViewForPad:nil cancelListener:onCancel failureListener:onFailure resultListener:onResult];
}



- (UIImage *)useImage:(UIImage *)image {
    //    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // Create a graphics image context
    CGSize newSize = CGSizeMake(100, 100);
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    
    //    [pool release];
    return newImage;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
