//
//  PPDifficultyLayer.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-06-02.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PPSettings.h"

@class PPDifficultyLayer;

@protocol PPDifficultyLayerDelegate<NSObject>

- (void)difficultyLayer:(PPDifficultyLayer *)difficultyLayer didChooseDifficulty:(PPDifficulty)difficulty;

@end

@interface PPDifficultyLayer : CCLayer

@property (nonatomic) id<PPDifficultyLayerDelegate> delegate;

@end
