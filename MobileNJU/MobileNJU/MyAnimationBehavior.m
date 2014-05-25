//
//  MyAnimationBehavior.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-25.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "MyAnimationBehavior.h"
@interface MyAnimationBehavior()

    
    @property (strong, nonatomic)UIGravityBehavior* gravity;
    @property (strong,nonatomic )UICollisionBehavior* collide;
    @property (strong,nonatomic)UIDynamicItemBehavior* animaitionOptions;

@end
@implementation MyAnimationBehavior

- (instancetype)init
{
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collide];
    [self addChildBehavior:self.animaitionOptions];
    return self;
}

- (UIGravityBehavior *)gravity
{
    if (!_gravity ) {
        _gravity =  [[UIGravityBehavior alloc]init];
        CGVector direction = CGVectorMake(0, -568);
        _gravity.gravityDirection = direction;
        _gravity.magnitude = 2.0;
        
    }
    return _gravity;
}

- (UIDynamicItemBehavior *)animaitionOptions
{
    if (!_animaitionOptions) {
        _animaitionOptions = [[UIDynamicItemBehavior alloc]init];
        _animaitionOptions.allowsRotation = NO;
    }
    return _animaitionOptions;
}

- (UICollisionBehavior *)collide
{
    if (!_collide) {
        _collide = [[UICollisionBehavior alloc]init];
        _collide .translatesReferenceBoundsIntoBoundary=YES;
    }
    return _collide;
}

- (void)addItem:(id<UIDynamicItem>)item
{
    [self.gravity addItem:item];
    [self.collide addItem:item];
    [self.animaitionOptions addItem:item];
}

- (void)removeItem:(id<UIDynamicItem>)item
{
    [self.gravity removeItem:item];
    [self.collide removeItem:item];
    [self.animaitionOptions removeItem:item];
}



@end
