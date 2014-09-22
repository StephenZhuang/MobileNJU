//
//  BBSDetail.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BBSDetail.h"
#define GESTURE_STATE_START 1
#define GESTURE_STATE_END 2
#define GESTURE_STATE_MOVE 3

@interface BBSDetail ()<UIWebViewDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) NSString* imgURL;
@property (nonatomic,strong)NSTimer* time;
@property (nonatomic)int gesState;
@end


@implementation BBSDetail

static NSString* const kTouchJavaScriptString=
@"document.ontouchstart=function(event){\
x=event.targetTouches[0].clientX;\
y=event.targetTouches[0].clientY;\
document.location=\"myweb:touch:start:\"+x+\":\"+y;};\
document.ontouchmove=function(event){\
x=event.targetTouches[0].clientX;\
y=event.targetTouches[0].clientY;\
document.location=\"myweb:touch:move:\"+x+\":\"+y;};\
document.ontouchcancel=function(event){\
document.location=\"myweb:touch:cancel\";};\
document.ontouchend=function(event){\
document.location=\"myweb:touch:end\";};";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"详情"];
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(timer) userInfo:nil repeats:NO];

    // Do any additional setup after loading the view.
}


- (void)timer
{
    [self.loginIndicator removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView setDelegate:self];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.webView setDelegate:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loginIndicator removeFromSuperview];
    self.OK = YES;
    [self.webView stringByEvaluatingJavaScriptFromString:kTouchJavaScriptString];

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)_request navigationType:(UIWebViewNavigationType)navigationType {

    NSString *requestString =  [[_request URL]   absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0]
                                   isEqualToString:@"myweb"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"])
        {
            //NSLog(@"you are touching!");
            //NSTimeInterval delaytime = Delaytime;
            if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"start"])
            {
                /*
                 @需延时判断是否响应页面内的js...
                 */
                _gesState = GESTURE_STATE_START;
                NSLog(@"touch start!");
                
                float ptX =  [[components objectAtIndex:3]floatValue];
                float ptY = [[components objectAtIndex:4]floatValue];
                NSLog(@"touch point (%f, %f)", ptX, ptY);
                
                NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", ptX, ptY];
                NSString * tagName = [self.webView stringByEvaluatingJavaScriptFromString:js];
                _imgURL = nil;
                if ([tagName isEqualToString:@"IMG"]) {
                    _imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", ptX, ptY];
                }
                if (_imgURL) {
                    
                    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleLongTouch) userInfo:nil repeats:NO];
                }
            }
            else if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"move"])
            {
                //**如果touch动作是滑动，则取消hanleLongTouch动作**//
                _gesState = GESTURE_STATE_MOVE;
                NSLog(@"you are move");
            }
            else if ([(NSString*)[components objectAtIndex:2]isEqualToString:@"end"]) {
            [_time invalidate];
            _time = nil;
            _gesState = GESTURE_STATE_END;
            NSLog(@"touch end");
            }
        }
        return NO;
    }
    return YES;
}

- (void)handleLongTouch {
    NSLog(@"%@", _imgURL);
    if (_imgURL && _gesState == GESTURE_STATE_START) {
        UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        sheet.cancelButtonIndex = sheet.numberOfButtons - 1;
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.numberOfButtons - 1 == buttonIndex) {
        return;
    }
    NSString* title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"保存图片"]) {
        [self waiting:@"正在保存"];
        if (_imgURL) {
            NSLog(@"imgurl = %@", _imgURL);
        }
        NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:_imgURL];
        NSLog(@"image url=%@", urlToSave);
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlToSave]];
        UIImage* image = [UIImage imageWithData:data];
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}
                                                      
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    [self.loginIndicator removeFromSuperview];
    if (error){
        NSLog(@"Error");
            [ToolUtils showMessage:@"保存失败"];
        }else {
            NSLog(@"OK");
            [ToolUtils showMessage:@"保存成功"];
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self waiting:@"加载中"];
}

@end
