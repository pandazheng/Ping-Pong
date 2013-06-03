//
//  PPPlayers.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-31.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import "PPPlayers.h"

@implementation PPPlayers
{
	PPPlayer *player1;
	PPPlayer *player2;
}

+ (PPPlayers *)sharedStorage
{
	static PPPlayers *players;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        players = [[self alloc] init];
    });
    return players;
}

- (PPPlayer *)player1
{
	return player1;
}

- (PPPlayer *)player2
{
	return player2;
}

- (id)init
{
    self = [super init];
    if (self) {
        player1 = [PPPlayer player];
		player2 = [PPPlayer player];
    }
    return self;
}

@end
