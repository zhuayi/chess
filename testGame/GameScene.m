//
//  GameScene.m
//  testGame
//
//  Created by zhuayi on 15/9/23.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "GameScene.h"
#import "ChessNode.h"

@implementation GameScene {
    
    SKSpriteNode *sprite;
    
    BOOL _isCreate;
    
    ChessNode *_selectChessNode;
}

- (instancetype)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor whiteColor];
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"qipan"];
        background.userInteractionEnabled  = NO;
        background.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        [self addChild:background];
        [self createCanvas:CGSizeMake(size.width * 0.8, size.height * 0.8)];
        
    }
    
    return self;
}

- (void)createCanvas:(CGSize)size {

    CGFloat width = 33;
    CGRect frame = CGRectMake((self.size.width - width * 8) / 2, (self.size.height - width * 9) / 2, width, width);
    
    
    NSMutableArray *array = [NSMutableArray new];

    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 9; j++) {
            
            CGRect frame2 = CGRectOffset(frame, frame.size.width * j, frame.size.width * i);
            
            NSLog(@"frame2 is %@", NSStringFromCGRect(frame2));
            
            ChessNode *chessNode = [[ChessNode alloc] init];
            chessNode.zPosition = 0;
            chessNode.position = CGPointMake(frame2.origin.x, self.size.height - frame2.origin.y);
            chessNode.size = CGSizeMake(width * 0.7, width * 0.7);
//            chessNode.color = [UIColor greenColor];
            [self addChild:chessNode];
            // 车
            if ((i == 0 || i == 9) && (j == 0 || j == 8)) {
                chessNode.type = ChessNodeTypeChe;
                if (i == 0) {
                    chessNode.category = ChessCategoryHong;
                } else {
                    chessNode.category = ChessCategoryHei;
                }
                chessNode.name = @"车";
                [array addObject:chessNode];
            }
            
            // 马
            if ((i == 0 || i == 9) && (j == 1 || j == 7)) {
                if (i == 0) {
                    chessNode.category = ChessCategoryHong;
                } else {
                    chessNode.category = ChessCategoryHei;
                }
                chessNode.type = ChessNodeTypeMa;
                chessNode.name = @"马";
                [array addObject:chessNode];
//                [self addChild:chessNode];
            }
            
            // 象
            if ((i == 0 || i == 9) && (j == 2 || j == 6)) {
                if (i == 0) {
                    chessNode.category = ChessCategoryHong;
                } else {
                    chessNode.category = ChessCategoryHei;
                }
                chessNode.type = ChessNodeTypeXiang;
                chessNode.name = @"象";
                [array addObject:chessNode];
//                [self addChild:chessNode];
            }
            
            // 士
            if ((i == 0  || i == 9) && (j == 3 || j == 5)) {
                if (i == 0) {
                    chessNode.category = ChessCategoryHong;
                } else {
                    chessNode.category = ChessCategoryHei;
                }
                chessNode.type = ChessNodeTypeShi;
                chessNode.name = @"士";
                [array addObject:chessNode];
//                [self addChild:chessNode];
            }
            
            // 将
            if ((i == 0  || i == 9) && (j == 4)) {
                if (i == 0) {
                    chessNode.category = ChessCategoryHong;
                } else {
                    chessNode.category = ChessCategoryHei;
                }
                chessNode.type = ChessNodeTypeJiang;
                chessNode.name = @"将";
                [array addObject:chessNode];
//                [self addChild:chessNode];
            }
            
            // 炮
            if ((i == 2 || i == 7) && (j == 1 || j == 7)) {
                if (i == 2) {
                    chessNode.category = ChessCategoryHong;
                } else {
                    chessNode.category = ChessCategoryHei;
                }
                chessNode.type = ChessNodeTypePao;
                chessNode.name = @"炮";
                [array addObject:chessNode];
            }
            
            // 卒
            if ((i == 3 || i == 6) && (j % 2 ==0)) {
                if (i == 3) {
                    chessNode.category = ChessCategoryHong;
                } else {
                    chessNode.category = ChessCategoryHei;
                }
                chessNode.type = ChessNodeTypeZu;
                chessNode.name = @"卒";
                [array addObject:chessNode];
            }
        }
    }
    
//    NSLog(@"array is %@", array);

}

-(void)didMoveToView:(SKView *)view {

}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];

    ChessNode *node = (ChessNode *)[self nodeAtPoint:positionInScene];
    if (![node isKindOfClass:[ChessNode class]]) {
        return;
    }
    
    if (!node.name) {
        
        if ([_selectChessNode didCollisionNode:node senen:self]) {
            _selectChessNode.selected = NO;
            _selectChessNode = nil;
        }

    } else {
        _selectChessNode.selected = NO;
        node.selected = YES;
        _selectChessNode = node;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
