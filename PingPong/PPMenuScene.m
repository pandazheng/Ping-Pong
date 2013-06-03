//
//  PPMenuScene.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-06-02.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import "PPMenuScene.h"
#import "PPGameScene.h"
#import "PPSettings.h"

@implementation PPMenuScene
{
	PPDifficultyLayer *difficultyLayer;
}

- (void)onEnter
{
	[super onEnter];
	
	// Adds layers
	PPModeLayer *modeLayer = [PPModeLayer node];
	[modeLayer setDelegate:self];
	
	difficultyLayer = [PPDifficultyLayer node];
	[difficultyLayer setDelegate:self];
	
	[self addChild:modeLayer];
}

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	[scene addChild: [self node]];
	
	return scene;
}

- (void)modeLayer:(PPModeLayer *)modeLayer didChooseMode:(PPMode)mode
{
	[[PPSettings settings] setMode:mode];

	[self removeChild:modeLayer];
	[self addChild:difficultyLayer];
}

- (void)difficultyLayer:(PPDifficultyLayer *)difficultyLayer didChooseDifficulty:(PPDifficulty)difficulty
{
	[[PPSettings settings] setDifficulty:difficulty];
	[[CCDirector sharedDirector] replaceScene:[PPGameScene scene]];
}

@end
