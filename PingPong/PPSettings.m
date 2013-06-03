//
//  PPSettings.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-06-02.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import "PPSettings.h"

@implementation PPSettings

+ (PPSettings *)settings
{
	static PPSettings *settings;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        settings = [[self alloc] init];
    });
    return settings;
}

@end
