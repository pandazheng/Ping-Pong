//
//  PPGameScene.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-30.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PPBoardLayer.h"

@class PPPlayer;

@interface PPGameScene : CCLayer <PPBoardLayerDelegate>

+ (CCScene *)scene;

@end
