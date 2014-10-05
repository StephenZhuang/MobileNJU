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
#import "RegisterVC.h"
#import "EditInfoVC.h"
#import "WelcomeViewController.h"
@interface SelfInfoVC ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
//    [self loadData];
    self.headImage.layer.cornerRadius=55;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.headImage addGestureRecognizer:singleTap];
    [self.headImage setClipsToBounds:YES];
    [self initImg];
    if (!self.offline) {
        [[ApisFactory getApiMGetUserInfo]load:self selecter:@selector(disposMessage:)];
    }

}


-(void)initImg
{
    if ([ToolUtils getHeadImg]!=nil&&[ToolUtils getHeadImg].length>0) {
        NSLog(@"%@ headImage",[ToolUtils getHeadImg]);
        [self.headImage setImageWithURL:[ToolUtils getImageUrlWtihString:[ToolUtils getHeadImg] width:111 height:111] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [self.backgroundImg setContentMode:UIViewContentModeScaleAspectFill];
            [self.backgroundImg setImageToBlur:image blurRadius:10 completionBlock:nil];
            [self.backgroundImg setClipsToBounds:YES];
//            [self.headImage removeFromSuperview];
//            [self.headView addSubview:self.headImage];
        }];
    } else {
        [self.headImage setImage:[UIImage imageNamed:@"05个人－个人头像"]];
        [self.backgroundImg setContentMode:UIViewContentModeScaleAspectFill];
        [self.backgroundImg setImageToBlur:self.headImage.image blurRadius:10 completionBlock:nil];
        [self.backgroundImg setClipsToBounds:YES];
        
    }

}
- (void)viewWillAppear:(BOOL)animated
{
//    [self loadData];
//    [self.infoTable reloadData];
    [super viewWillAppear:animated];
    [self loadData];
    [self.infoTable reloadData];
        NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected)
        [self.tableView deselectRowAtIndexPath:selected animated:NO];
    [self.rdv_tabBarController setTabBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    [ToolUtils setIsLogin:NO];
//    if (sender==nil) {
//        [ToolUtils setHasLogOut:@"yes"];
//    }
//    [self dismissViewControllerAnimated:NO completion:^{
//        [self.rdv_tabBarController dismissViewControllerAnimated:NO completion:nil];
//    }];
    [self.rdv_tabBarController dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) returnToWelcome
{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    WelcomeViewController* welcome = (WelcomeViewController*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"welcome"];
    [ToolUtils setIsLogin:NO];
    [self presentViewController:welcome animated:NO completion:nil];
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
                [self initImg];
            }
        }
    } else {
        [super disposMessage:son];
    }

}

- (IBAction)backToMain:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [self.rdv_tabBarController setSelectedIndex:0];
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
- (IBAction)edit:(id)sender {
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Self" bundle:nil];
    EditInfoVC* vc = (EditInfoVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"edit"]; //test2为viewcontroller的StoryboardId
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:vc action:@selector(cancelVC)];
    [item setTintColor:[UIColor whiteColor]];
    vc.navigationItem.rightBarButtonItem = item;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];

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
    SelfCell *cell = (SelfCell*)[tableView dequeueReusableCellWithIdentifier:@"self"];
    NSString *imageName = [[self.infos objectAtIndex:indexPath.row] objectForKey:@"image"];
    [cell setImageName:imageName];
    NSString* content = [[self.infos objectAtIndex:indexPath.row]objectForKey:@"content"];
    [cell setContent:content];
    if (indexPath.row==self.infos.count-1) {
        [cell setUserInteractionEnabled:NO];
    }
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
    CGSize newSize = CGSizeMake(222, 222);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==self.infos.count-1) {
        return;
    }
    [self edit:nil];
}

- (IBAction)modifyPassword:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    RegisterVC* reg = (RegisterVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"register"]; //test2为viewcontroller的StoryboardId
    reg.myTitle = @"修改密码";
    [self.navigationController pushViewController:reg animated:YES];
}

@end
