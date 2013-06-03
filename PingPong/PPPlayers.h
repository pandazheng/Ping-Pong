//
//  PPPlayers.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-31.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPPlayer.h"

@interface PPPlayers : NSObject

- (PPPlayer *)player1;
- (PPPlayer *)player2;

+ (PPPlayers *)sharedStorage;

@end
