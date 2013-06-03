//
//  PPBoardLayer.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-30.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PPSettings.h"

@class PPBoardLayer;
@class PPPlayer;

#pragma mark - Protocol
@protocol PPBoardLayerDelegate<NSObject>

- (void)boardLayerWantsToExit;

@optional
- (void)boardLayer:(PPBoardLayer *)boardLayer goalByPlayerAtIndex:(NSInteger)index;

@end

#pragma mark - Interface
@interface PPBoardLayer : CCLayer

@property (nonatomic, weak) id<PPBoardLayerDelegate> delegate;
@property (nonatomic) PPMode mode;
@property (nonatomic) PPDifficulty difficulty;

@end
