//
//  ChessNode.m
//  testGame
//
//  Created by zhuayi on 15/9/23.
//  Copyright © 2015年 renxin. All rights reserved.
//

#import "ChessNode.h"

@implementation ChessNode

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.zPosition = 0;
    }
    return self;
}

- (void)setCategory:(ChessCategory)category {
    _category = category;
    
    if (category == ChessCategoryHei) {
        self.color = [UIColor blackColor];
    } else {
        self.color = [UIColor redColor];
    }
}


- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    SKAction *action;
    if (_selected) {
        
        self.zPosition = 1;
        action = [SKAction scaleTo:1.2 duration:0.2];
    } else {
        action = [SKAction scaleTo:1 duration:0.2];
        self.zPosition = 0.0;
    }
    
    [self runAction:action];
}


- (void)moveToNode:(ChessNode *)node {
    self.zPosition = 1;
    SKAction *action = [SKAction moveTo:node.position duration:0.2];
    [self runAction:action completion:^{
        
        self.selected = NO;
    }];
    
    [node runAction:[SKAction moveTo:self.position duration:0.2]];
}

- (BOOL)didCollisionNode:(ChessNode *)node senen:(SKScene *)senen {
    if (node.name) {
        return YES;
    }
    
    // 检查规则
    switch (self.type) {
            
        // 判断车走法
        case ChessNodeTypeChe:
            return [self algorithmWithChe:(ChessNode *)node senen:(SKScene *)senen];
            break;
            
        default:
            break;
    }
 
    return YES;
}

/**
 *  检车车移动是否合法
 *
 *  @param node
 *  @param senen
 *
 *  @return
 */
- (BOOL)algorithmWithChe:(ChessNode *)node senen:(SKScene *)senen {

    CGPoint offset = rwSub(node.position, self.position);
    
    if (self.position.x == node.position.x ||  self.position.y == node.position.y) {
        
        // 获取方向
        CGPoint direction = rwNormalize(offset);
        NSInteger count = (int)fabs((offset.y + offset.x) / (node.size.width / 0.7));
        for (int i = 1; i < count + 1; i++) {
            CGPoint point = self.position;
     
            if (fabs(offset.y) > 0) {
                point = rwAdd(self.position, CGPointMake(offset.x, (node.size.height / 0.7) * i * direction.y));
            } else {
                point = rwAdd(self.position, CGPointMake((node.size.width / 0.7) * i * direction.x, offset.y));
            }
            
            ChessNode *node = (ChessNode *)[senen nodeAtPoint:point];
            NSLog(@"node is %@, %@", node, NSStringFromCGPoint(point));
            
            // 路中间遇到旗子
            if (node.name) {
                return NO;
            }
        }
        [self moveToNode:node];
        
        return YES;
    }
    return NO;

}
@end
