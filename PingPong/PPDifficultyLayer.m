//
//  PPDifficultyLayer.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-06-02.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import "PPDifficultyLayer.h"

@implementation PPDifficultyLayer
{
	CGSize windowSize;
	
	CCMenuItemFont *easyButton;
	CCMenuItemFont *mediumButton;
	CCMenuItemFont *hardButton;
}

- (void)difficultyChoosen:(id)sender
{
	PPDifficulty difficulty;
	if (sender == easyButton)
	{
		difficulty = kPPDifficulty_Easy;
	}
	else if (sender == mediumButton)
	{
		difficulty = kPPDifficulty_Medium;
	}
	else if (sender == hardButton)
	{
		difficulty = kPPDifficulty_Hard;
	}
	
	if ([self.delegate respondsToSelector:@selector(difficultyLayer:didChooseDifficulty:)]) {
		[self.delegate difficultyLayer:self didChooseDifficulty:difficulty];
	}
}

- (void)addUI
{
	// Menu items
	easyButton = [CCMenuItemFont itemWithString:@"Easy" target:self selector:@selector(difficultyChoosen:)];
	mediumButton = [CCMenuItemFont itemWithString:@"Medium" target:self selector:@selector(difficultyChoosen:)];
	hardButton = [CCMenuItemFont itemWithString:@"Hard" target:self selector:@selector(difficultyChoosen:)];
	
	// Menu
	CCMenu *menu = [CCMenu menuWithItems:easyButton, mediumButton, hardButton, nil];
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
