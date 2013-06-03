//
//  PPServeLayer.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-31.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import "PPServeLayer.h"
#import "PPPlayers.h"

@implementation PPServeLayer
{
	CGSize winSize;
	
	CCLabelTTF *label1;
	CCLabelTTF *label2;
}

- (void)showAtIndex:(NSInteger)index
{
	if(index == 0){
		self.rotation = 0;
	} else {
		self.rotation = 180;
	}
	CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.4];
	[label1 runAction:[fadeIn copy]];
	[label2 runAction:[fadeIn copy]];
	
	[self scheduleOnce:@selector(hide) delay:3.0];
}

- (void)hide
{
	CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.3];
	[label1 runAction:[fadeOut copy]];
	[label2 runAction:[fadeOut copy]];
}

- (void)addUI
{
	label1 = [CCLabelTTF labelWithString:@"YOUR SERVE!" fontName:@"Arial" fontSize:32];
	label1.position = ccp(winSize.width / 2, winSize.height / 2 - label1.fontSize * 5);
	label1.opacity = 0;
	[self addChild:label1];
	
	label2 = [CCLabelTTF labelWithString:@"Doubletap where you want to serve the ball" fontName:@"Arial" fontSize:18];
	label2.position = ccp(winSize.width / 2, label1.position.y - label2.fontSize * 2);
	label2.opacity = 0;
	[self addChild:label2];
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
