//
//  PPPlayer.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-29.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import "PPPlayer.h"

@implementation PPPlayer

+ (PPPlayer *)player
{
	return [[self alloc] init];
}

- (id)init
{
	self = [super init];
    if (self) {
		_score = 0;
    }
    return self;
}

@end
