//
//  SelfInfoVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SelfInfoVC.h"
#import "SelfCell.h"
#import "ToolUtils.h"
#import "ZsndUser.pb.h"
#import "ZsndSystem.pb.h"
#import "UIImageView+LBBlurredImage.h"
#import "MyNavigationController.h"
#import "RDVTabBarController.h"
@interface SelfInfoVC ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UITableView *infoTable;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *flowerLabel;
@end

@implementation SelfInfoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

    self.navigationController.delegate = self;
    [self loadData];
    self.headImage.layer.cornerRadius=55;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.headImage addGestureRecognizer:singleTap];
//    [self.headImage setImage:[UIImage imageNamed:@"head"]];
    [self.headImage setClipsToBounds:YES];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

    [self loadData];
    [self.infoTable reloadData];
    [[ApisFactory getApiMGetUserInfo]load:self selecter:@selector(disposMessage:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    [ToolUtils setIsLogin:NO];
    [self.rdv_tabBarController dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)disposMessage:(Son *)son
{
    self.OK = YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError] == 0) {
        //判断接口名
        if ([[son getMethod] isEqualToString:@"MGetUserInfo"]) {
            //获得返回类
            MUser_Builder *user = (MUser_Builder *)[son getBuild];
            [ToolUtils setBelong:user.belong==nil?@"":user.belong];
            [ToolUtils setBirthday:user.birthday==nil?@"":user.birthday];
            [ToolUtils setNickname:user.nickname==nil?@"":user.nickname];
            [ToolUtils setHeadImg:user.headImg==nil?@"":user.headImg];
            [ToolUtils setIsVeryfy:user.isV];
            switch (user.sex) {
                case 0:
                    [ToolUtils setSex:@"女"];
                    break;
                case 1:
                    [ToolUtils setSex:@"男"];
                    break;
                case 2:
                    [ToolUtils setSex:@"未知"];
                    break;
                default:
                    break;
            }
            self.flowerCount = user.flower;
            //用这个方法把array 里的string 组合起来
            NSString *tagsString = [user.tagsList componentsJoinedByString:@";"];
            [ToolUtils setTags:tagsString];
            [self loadData];
            [self.infoTable reloadData];
            [ToolUtils setFlowerCount:user.flower];
            [self.flowerLabel setText:[NSString stringWithFormat:@"%d",self.flowerCount]];
        }
        else if ([[son getMethod] isEqualToString:@"MUpdateHeadImg"])
        {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            NSLog(@"%d",ret.code);
            if (ret.code==1) {
                [ToolUtils setHeadImg:ret.msg];
                [self loadData];
            }
        }
    }

}

- (IBAction)backToMain:(id)sender {
    [self.rdv_tabBarController setSelectedIndex:0];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

# pragma ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




#pragma toDo
- (void)loadData
{
    [self.flowerLabel setText:[NSString stringWithFormat:@"%d",[ToolUtils getFlowerCount]]];
    NSArray* keys = [[NSArray alloc]initWithObjects:@"image", @"content",nil];
    NSArray* images = [[NSArray alloc]initWithObjects:@"昵称",@"院系",@"性别",@"生日",@"版本号", nil];
    NSArray* content = [[NSArray alloc]initWithObjects:
                        [ToolUtils getNickName]==nil?@"":[ToolUtils getNickName],
                        [ToolUtils getBelong]==nil?@"":[ToolUtils getBelong],
                        [ToolUtils getSex]==nil?@"":[ToolUtils getSex],
                        [ToolUtils getBirthday]==nil?@"":[ToolUtils getBirthday], [ToolUtils getVersion]==nil?@"":[ToolUtils getVersion],nil];
    if ([ToolUtils getHeadImg]!=nil) {
        NSLog(@"%@ headImage",[ToolUtils getHeadImg]);
        [self.headImage setImageWithURL:[ToolUtils getImageUrlWtihString:[ToolUtils getHeadImg] width:111 height:111] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [self.backgroundImg setContentMode:UIViewContentModeScaleAspectFill];
            [self.backgroundImg setImageToBlur:image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
            [self.backgroundImg setClipsToBounds:YES];
          
        }];
        } else {
        
        [self.headImage setImage:[UIImage imageNamed:@"05个人－个人头像"]];
        [self.backgroundImg setImage:[UIImage imageNamed:@"05个人－个人头像"]];
        [self.backgroundImg setContentMode:UIViewContentModeScaleAspectFill];
        [self.backgroundImg setImageToBlur:self.headImage.image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
            [self.backgroundImg setClipsToBounds:YES];
           
    }
    
       [self.nameLabel setText:[ToolUtils getNickName]==nil?@"":[ToolUtils getNickName]];
    NSMutableArray* mutableArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < images.count; i++)
    {
        NSArray* rows = [[NSArray alloc]initWithObjects:[images objectAtIndex:i],[content objectAtIndex:i], nil];
        NSDictionary* dic = [[NSDictionary alloc]initWithObjects:rows forKeys:keys];
        [mutableArray addObject:dic];
    }
    self.infos = [[NSArray alloc]initWithArray:mutableArray];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infos count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"self";
    SelfCell *cell = (SelfCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *imageName = [[self.infos objectAtIndex:indexPath.row] objectForKey:@"image"];
    [cell setImageName:imageName];
    NSString* content = [[self.infos objectAtIndex:indexPath.row]objectForKey:@"content"];
    [cell setContent:content];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


#pragma -mark 头像更改
-(void)onClickImage
{
    [self showActionSheet];
}


- (void) showActionSheet
{
        UIActionSheet *sheet;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        }
        else {
            
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
        }
        
        sheet.tag = 255;
        
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
}



#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowPhotoTabbar" object:nil];
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    image = [self useImage:image];
    [self upLoadImage:image];
//    [self.headImage setImage:image];
}

- (UIImage *)useImage:(UIImage *)image {
    //    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // Create a graphics image context
    CGSize newSize = CGSizeMake(80, 80);
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


- (void)upLoadImage:(UIImage*)image
{
    
    MImg_Builder* img = [MImg_Builder new];
    [img setImg: UIImagePNGRepresentation(image)];
    
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MUpdateHeadImg" params:img  delegate:self selecter:@selector(disposMessage:)];
    [updateone setShowLoading:NO];
    [self waiting:@"正在上传"];
    [DataManager loadData:[[NSArray alloc] initWithObjects:updateone, nil] delegate:self];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowPhotoTabbar" object:nil];
	[self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 2:
                    // 取消
                    return;
                    break;
                default:
                    return;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        //        [imagePickerController release];
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"HidePhotoTabbar" object:nil];
    } else {
        switch (buttonIndex) {
            case 0:
                // 删除
            {
                [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            }
                
                break;
            default:
                break;
        }
    }
}



@end
