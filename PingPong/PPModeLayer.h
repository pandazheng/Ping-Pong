//
//  PPModeLayer.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-06-02.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PPSettings.h"

@class PPModeLayer;

#pragma mark Protocol
@protocol PPModeLayerDelegate<NSObject>

- (void)modeLayer:(PPModeLayer *)modeLayer didChooseMode:(PPMode)mode;

@end

#pragma mark Interface
@interface PPModeLayer : CCLayer

@property (nonatomic) id<PPModeLayerDelegate> delegate;

@end