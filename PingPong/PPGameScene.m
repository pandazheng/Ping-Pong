//
//  PPGameScene.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-30.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import "PPGameScene.h"
#import "PPBoardLayer.h"
#import "PPScoreLayer.h"
#import "PPServeLayer.h"
#import "PPPlayer.h"
#import "PPPlayers.h"
#import "PPSettings.h"
#import "PPMenuScene.h"

@implementation PPGameScene
{
	PPScoreLayer *scoreLayer;
	PPServeLayer *serveLayer;
} 

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	[scene addChild: [self node]];
	
	return scene;
}

- (void)onEnter
{
	[super onEnter];
	
	// Adds layers
	PPBoardLayer *boardLayer = [PPBoardLayer node];
	[boardLayer setDelegate:self];
	[self addChild:boardLayer];
	
	scoreLayer = [PPScoreLayer node];
	[self addChild:scoreLayer];
	
	serveLayer = [PPServeLayer node];
	[self addChild:serveLayer];
	
	// Show how to serve
	[serveLayer showAtIndex:0];
}


#pragma mark - PPBoardLayerDelegate

- (void)boardLayerWantsToExit
{
	[[CCDirector sharedDirector] replaceScene:[PPMenuScene scene]];
}

- (void)boardLayer:(PPBoardLayer *)boardLayer goalByPlayerAtIndex:(NSInteger)index
{	
	PPPlayer *player;
	if (index == 0) {
		player = [[PPPlayers sharedStorage] player1];
	} else {
		player = [[PPPlayers sharedStorage] player2];
	}
	
	player.score++;
	[scoreLayer update];
	
	if (index == 1 && [[PPSettings settings] mode] == kPPMode_SinglePlayer) {
		return;
	} else {
		[serveLayer showAtIndex:index];
	}
}

@end
