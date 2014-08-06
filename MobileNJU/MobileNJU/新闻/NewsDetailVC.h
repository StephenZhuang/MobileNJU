//
//  NewsDetailVC.h
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-14.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSDetail.h"
#import "ZsndNews.pb.h"
@interface NewsDetailVC : BBSDetail
@property (nonatomic,strong)MNews* currentNew;
@property (nonatomic,strong)UIImage* img;
@end
