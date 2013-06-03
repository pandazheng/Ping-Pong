//
//  PPSettings.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-06-02.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	kPPDifficulty_Easy		= 0,
	kPPDifficulty_Medium	= 1,
	kPPDifficulty_Hard		= 2
} PPDifficulty;

typedef enum {
	kPPMode_SinglePlayer	= 0,
	kPPMode_Multiplayer		= 1,
} PPMode;

@interface PPSettings : NSObject

@property (nonatomic) PPDifficulty difficulty;
@property (nonatomic) PPMode mode;

+ (PPSettings *)settings;

@end
