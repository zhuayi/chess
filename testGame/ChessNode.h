//
//  ChessNode.h
//  testGame
//
//  Created by zhuayi on 15/9/23.
//  Copyright © 2015年 renxin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}
static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}
// 让向量的长度（模）等于1
static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

typedef NS_OPTIONS(int, ChessNodeType) {
    // 车
    ChessNodeTypeChe = 1 << 0,
    
    // 马
    ChessNodeTypeMa = 1 << 1,
    
    // 象
    ChessNodeTypeXiang = 1 << 2,
    
    // 士
    ChessNodeTypeShi = 1 << 3,
    
    // 将
    ChessNodeTypeJiang = 1 << 4,
    
    // 卒
    ChessNodeTypeZu = 1 << 5,
    
    // 炮
    ChessNodeTypePao = 1 << 6,
    
};

typedef NS_OPTIONS(int, ChessCategory) {
    // 红方
    ChessCategoryHong,
    
    // 黑方
    ChessCategoryHei,
};

@interface ChessNode : SKSpriteNode


@property (nonatomic, assign) ChessNodeType type;

@property (nonatomic, assign) ChessCategory category;

@property (nonatomic, assign) BOOL selected;


- (BOOL)didCollisionNode:(ChessNode *)node senen:(SKScene *)senen;

@end
