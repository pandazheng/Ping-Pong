//
//  PPPlayer.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-29.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CCSprite;

@interface PPPlayer : NSObject

@property (nonatomic) NSInteger score;

+ (PPPlayer *)player;

@end
