//
//  TestView.m
//  testGame
//
//  Created by zhuayi on 15/9/23.
//  Copyright © 2015年 renxin. All rights reserved.
//

#import "TestView.h"
#import "GameScene.h"
@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showsFPS = YES;
        self.showsNodeCount = YES;
        self.ignoresSiblingOrder = YES;
        
        GameScene *gameScenne = [[GameScene alloc] initWithSize:frame.size];
        
        
        [self presentScene:gameScenne];
        
        
        
    }
    return self;
}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.*/

- (void)drawRect:(CGRect)rect {
    
}


@end
