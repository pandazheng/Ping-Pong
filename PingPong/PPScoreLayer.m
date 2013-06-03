//
//  PPScoreLayer.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-31.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import "PPScoreLayer.h"
#import "PPPlayers.h"
#import "PPSettings.h"

@implementation PPScoreLayer
{
	CGSize winSize;
	
	CCLabelTTF *label1;
	CCLabelTTF *label2;
}

- (void)update
{
	int player1_score = [[[PPPlayers sharedStorage] player1] score];
	int player2_score = [[[PPPlayers sharedStorage] player2] score];
	
	[label1 setString:[NSString stringWithFormat:@"%d", player1_score]];
	[label2 setString:[NSString stringWithFormat:@"%d", player2_score]];
}

- (void)addUI
{
	label1 = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:72];
	label1.color = ccGRAY;
	label1.position = ccp(winSize.width / 2, winSize.height / 2 - label1.fontSize);
	[self addChild:label1];
	
	label2 = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:72];
	label2.position = ccp(winSize.width / 2, winSize.height / 2 + label2.fontSize);
	label2.color = ccGRAY;	
	[self addChild:label2];
	
	if ([[PPSettings settings] mode] == kPPMode_Multiplayer) {
		label2.rotation = 180;
	}
}

- (id)init
{
    self = [super init];
    if (self) {
		winSize = [[CCDirector sharedDirector] winSize];

        [self addUI];
    }
    return self;
}

@end
