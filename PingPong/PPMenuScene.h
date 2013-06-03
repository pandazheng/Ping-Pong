//
//  PPMenuScene.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-06-02.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "PPModeLayer.h"
#import "PPDifficultyLayer.h"

@interface PPMenuScene : CCLayer <PPModeLayerDelegate, PPDifficultyLayerDelegate>

+ (CCScene *)scene;

@end
