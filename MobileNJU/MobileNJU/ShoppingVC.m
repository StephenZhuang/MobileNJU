//
//  ShoppingVC.m
//  CreateLesson
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import "ShoppingVC.h"
#import "ShoppingCell.h"
#import "ShoppingDetailVC.h"
@interface ShoppingVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@end

@implementation ShoppingVC

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"d....");
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"shop" bundle:nil];
    ShoppingDetailVC* vc = (ShoppingDetailVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"detail"]; //test2为viewcontroller的StoryboardId
    [self.myDelegate moveToDetail:vc];
}

@end
