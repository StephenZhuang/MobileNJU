//
//  AddTreeHoleViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"

@interface AddTreeHoleViewController : BaseViewController<UICollectionViewDataSource , UICollectionViewDelegate ,UIImagePickerControllerDelegate , UIActionSheetDelegate>
@property (nonatomic , weak) IBOutlet UITextField *titleTextField;
@property (nonatomic , weak) IBOutlet UITextView *contentTextView;
@property (nonatomic , weak) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic , strong) NSMutableArray *photoArray;
@end
