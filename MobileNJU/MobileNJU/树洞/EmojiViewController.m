//
//  EmojiViewController.m
//  MallTemplate
//
//  Created by Stephen Zhuang on 14-4-18.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "EmojiViewController.h"
#import "EmojiCell.h"
#import "MatchParser.h"

@interface EmojiViewController ()

@end

@implementation EmojiViewController

+ (EmojiViewController *)shareInstance
{
    static EmojiViewController *sharedInstance = nil;
    
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TreeHole" bundle:nil];
        sharedInstance = [storyboard instantiateViewControllerWithIdentifier:@"EmojiViewController"];
    });
    
    return sharedInstance;
}

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
    // Do any additional setup after loading the view.
    self.title = @"系统表情";
    [self setSubTitle:@"选择最适合你的吧"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 45, 45)];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _collectionView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _collectionView.delegate = nil;
}

- (void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 108;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmojiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiCell" forIndexPath:indexPath];

    NSString *str = [NSString stringWithFormat:@"%i" , 1000 + indexPath.row];
    str = [str substringFromIndex:1];
    [cell.emojiImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"f%@" , str]]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        if (_emojiBlock) {
            NSString *str = [NSString stringWithFormat:@"%i" , 1000 + indexPath.row];
            str = [str substringFromIndex:1];
            NSDictionary *dic = [MatchParser getFaceMap];
            NSString *value = [dic objectForKey:[NSString stringWithFormat:@"f%@",str]];
            _emojiBlock(value);
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *view = nil;
//    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
//        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionHeader" forIndexPath:indexPath];
//    }
//    return view;
//}

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

@end
