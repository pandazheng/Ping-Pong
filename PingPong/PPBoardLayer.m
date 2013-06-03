//
//  PPBoardLayer.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-30.
//  Copyright 2013 Marcus Brissman. All rights reserved.
//

#import "PPBoardLayer.h"
#import "CCSprite+rect.h"
#import <math.h>
#import "PPPlayers.h"

typedef enum{
    kHitObject_Wall	= 0,
    kHitObject_Racket	= 1
} kHitObject;

@implementation PPBoardLayer
{
	CGSize winSize;
	
	CGRect rightWall;
	CGRect leftWall;
	
	CGRect player1Zone;
	CGRect player2Zone;
	
	CCSprite *exitSign;
	CCSprite *racket1;
	CCSprite *racket2;
	CCSprite *ball;
	
	NSInteger serverIndex;

	CGPoint currentDirection;
	
	int enemySpeed;
	double ballSpeed;
	
	BOOL isRunning;
	BOOL onHitObject;
	BOOL automaticEnemy;
}

- (CCSprite *)serverRacket
{
	CCSprite *racket;
	if (serverIndex == 0) {
		racket = racket1;
	} else {
		racket = racket2;
	}
	
	return racket;
}

- (void)step
{
	// Check if ball hit wall or racket
	if (CGRectIntersectsRect([ball rect], [racket1 rect]))
	{
		[self ballHitRacket:racket1];
	}
	else if (CGRectIntersectsRect([ball rect], [racket2 rect]))
	{
		[self ballHitRacket:racket2];
	}
	else if (CGRectIntersectsRect([ball rect], rightWall) || CGRectIntersectsRect([ball rect], leftWall))
	{
		[self ballHitObject:kHitObject_Wall];
	}
	else if (!CGRectIntersectsRect([ball rect], CGRectMake(0, 0, winSize.width, winSize.height)))
	{
		[self goal];
	}
	else if (onHitObject)
	{
		onHitObject = false;
	}
	
	// Move enemu racket if single player
	if ([self mode] == kPPMode_SinglePlayer) {
		[self moveRacket:racket2 toX:ball.position.x];
	}
}

- (void)moveRacket:(CCSprite *)racket toX:(NSInteger)x
{
	[racket stopAllActions];
	
	int moveBy = x - racket.position.x;
	
	if (moveBy > enemySpeed) {
		moveBy = enemySpeed;
	} else if (moveBy < -enemySpeed) {
		moveBy = -enemySpeed;
	}
	
	racket.position = ccp(racket.position.x + moveBy, racket.position.y);
}

#pragma mark - Situations

- (void)ballHitObject:(kHitObject)hitObject
{
	if(onHitObject)
		return;
	
	onHitObject = true;

	[ball stopAllActions];
	CGPoint direction;
	switch (hitObject) {
		case kHitObject_Wall:
			// Ball hit a wall - reverse X of direction
			direction = CGPointMake(-(currentDirection.x), currentDirection.y);
			break;
			
		default:
			// Ball hit a racket - reverse Y of direction
			direction = CGPointMake(currentDirection.x, -(currentDirection.y));
			break;
	}
	
	[self hitBallWithDirection:direction];
}

- (void)ballHitRacket:(CCSprite *)racket
{
	if(onHitObject)
		return;
	
	onHitObject = true;
	
	[ball stopAllActions];
	
	CGPoint direction = CGPointMake(currentDirection.x, -(currentDirection.y));
	
	int hitX = ball.position.x - racket.position.x;
	
	
	direction = ccp(direction.x + hitX * 2, direction.y);
	NSLog(@"%f", direction.x);
	
	[self hitBallWithDirection:direction];	
}


- (void)goal
{	
	[self stopBall];
	
	NSInteger playerIndex;
	
	if (ball.position.y > racket2.position.y) {
		playerIndex = 0;
	} else {
		playerIndex = 1;
	}
	
	serverIndex = playerIndex;
	
	if ([self.delegate respondsToSelector:@selector(boardLayer:goalByPlayerAtIndex:)]) {
        [self.delegate boardLayer:self goalByPlayerAtIndex:playerIndex];
    }

	[self giveBallToServer];
}


#pragma mark - Ball controll functions

- (void)hitBallWithDirection:(CGPoint)direction
{
	// Sets duration using direction for ball animation
	double distance = sqrt(pow(direction.x - 0, 2) + pow(direction.y - 0, 2));
	double duration = distance * ballSpeed;
	
	CCMoveBy *fly = [CCMoveBy actionWithDuration:duration position:direction];
	[ball runAction:[CCRepeatForever actionWithAction:fly]];
	
	currentDirection = direction;
}

- (void)serveBallAtPoint:(CGPoint)point
{
	if (isRunning) {
		return;
	}
	
	isRunning = true;
	
	CCSprite *racket = [self serverRacket];
	CGPoint direction = ccp(point.x - racket.position.x, point.y - racket.position.y);
	
	[self hitBallWithDirection:direction];
	[self schedule:@selector(step) interval:1/60];
}

- (void)stopBall
{
	isRunning = false;
	
	[ball stopAllActions];
	[self unschedule:@selector(step)];
}

- (void)giveBallToServer
{
	CCSprite *serverRacket = [self serverRacket];

	CGPoint racketPosition = serverRacket.position;
	
	int margin = (serverRacket.contentSize.height / 2 + ball.contentSize.height / 2 + 2);;
	if(racketPosition.y > winSize.height / 2){
		margin = -margin;
	}
	
	ball.position = ccp(racketPosition.x, racketPosition.y + margin);
	
	// Automatic serve if single player
	if (automaticEnemy && serverRacket == racket2) {
		[self doAutomaticServe];
	}
}

- (void)doAutomaticServe
{
	CCDelayTime *delay = [CCDelayTime actionWithDuration:rand() % 5];
	CCCallBlock *block = [CCCallBlock actionWithBlock:^{
		int maxX = winSize.width;
		int x = rand() % maxX;
		
		[self serveBallAtPoint:ccp(x, winSize.height / 2)];
	}];
	CCSequence *sequence = [CCSequence actions:delay, block, nil];
	
	[self runAction:sequence];
	
}

#pragma mark - Layer initializer

- (id)init
{
	self = [super init];
    if (self) {
		winSize = [[CCDirector sharedDirector] winSize];
		
		player1Zone = CGRectMake(0, 0, winSize.width, winSize.height / 2);
		player2Zone = CGRectMake(0, winSize.height / 2, winSize.width, winSize.height / 2);
		
		_mode = [[PPSettings settings] mode];
		_difficulty = [[PPSettings settings] difficulty];
		
		if ([[PPSettings settings] mode] == kPPMode_SinglePlayer) {
			automaticEnemy = true;
		}
		
		switch ([[PPSettings settings] difficulty]) {
			case kPPDifficulty_Medium:
				enemySpeed = 6;
				ballSpeed = 0.0015;
				break;
			case kPPDifficulty_Hard:
				enemySpeed = 10.0;
				ballSpeed = 0.0012;
				break;
			default:
				enemySpeed = 3;
				ballSpeed = 0.0021;
				break;
		}

		// Sets walls as hit objects
		rightWall = CGRectMake(winSize.width, 0, 1, winSize.height);
		leftWall = CGRectMake(-1, 0, 1, winSize.height);
		
        [self addUI];
		[self giveBallToServer];
		
		[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }
    return self;
}

- (void)addUI
{
	// Add exit sign
	exitSign = [CCSprite spriteWithFile:@"exit.png"];
	exitSign.position = ccp(winSize.width / 2, winSize.height / 2);
	[self addChild:exitSign];
	
	// Adds rackets to layer
	racket1 = [CCSprite spriteWithFile:@"racket.png"];
	racket1.position = ccp(winSize.width / 2, 40);
	racket1.color = ccBLUE;
	[self addChild:racket1];
	
	racket2 = [CCSprite spriteWithFile:@"racket.png"];
	racket2.position = ccp(winSize.width / 2, winSize.height - 40);
	racket2.color = ccRED;
	[self addChild:racket2];
	
	// Adds ball to layer
	ball = [CCSprite spriteWithFile:@"ball.png"];
	[self addChild:ball];
}


#pragma mark - Touch events

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	// Indentify a serve
	if(touch.tapCount == 2 && !isRunning){
		CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
		[self serveBallAtPoint:touchLocation];
	}
	
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{	
	CGPoint location = [self convertTouchToNodeSpace:touch];
	
	// Sets max and min of Y
	if (location.x < 40){
		location.x = 40;
	}
	if (location.x > winSize.width - 40){
		location.x = winSize.width - 40;
	}
	
	if(CGRectContainsPoint(player1Zone, location)){
		racket1.position = ccp(location.x, racket1.position.y);
	} else {
		if (!automaticEnemy) {
			racket2.position = ccp(location.x, racket2.position.y);
		}
	}
	
	if (!isRunning) {
		[self giveBallToServer];
	}
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint location = [self convertTouchToNodeSpace:touch];
	if (CGRectContainsPoint([exitSign rect], location)) {
		[self.delegate boardLayerWantsToExit];
	}
}

- (void)draw
{
	ccDrawLine(ccp(40, winSize.height / 2), ccp(winSize.width - 40, winSize.height / 2));
}


@end
