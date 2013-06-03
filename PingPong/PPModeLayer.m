//
//  PPModeLayer.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-06-02.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import "PPModeLayer.h"
#import "PPSettings.h"

@implementation PPModeLayer
{
	CGSize windowSize;
	
	CCMenuItemFont *singlePlayerButton;
	CCMenuItemFont *multiplayerButton;
}

- (void)modeChoosen:(id)sender
{
	PPMode mode;
	if (sender == singlePlayerButton)
	{
		mode = kPPMode_SinglePlayer;
	} 
	else if (sender == multiplayerButton)
	{
		mode = kPPMode_Multiplayer;
	}
	
	if ([self.delegate respondsToSelector:@selector(modeLayer:didChooseMode:)]) {
		[self.delegate modeLayer:self didChooseMode:mode];
	}
}

- (void)addUI
{
	// Menu items
	singlePlayerButton = [CCMenuItemFont itemWithString:@"Single player" target:self selector:@selector(modeChoosen:)];
	multiplayerButton = [CCMenuItemFont itemWithString:@"Multiplayer" target:self selector:@selector(modeChoosen:)];
	
	// Menu
	CCMenu *menu = [CCMenu menuWithItems:singlePlayerButton, multiplayerButton, nil];
	menu.position = ccp(windowSize.width / 2, windowSize.height / 2);
	[menu alignItemsVerticallyWithPadding: 60];

	[self addChild:menu];
}

- (id)init
{
    self = [super init];
    if (self) {
		windowSize = [[CCDirector sharedDirector] winSize];
		
        [self addUI];
    }
    return self;
}

@end
