//
//  CCSprite+rect.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-30.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import "CCSprite+rect.h"

@implementation CCSprite (rect)

- (CGRect)rect
{
	CGRect rect = CGRectMake(self.position.x - self.contentSize.width / 2,
							 self.position.y - self.contentSize.height / 2,
							 self.contentSize.width,
							 self.contentSize.height);
	return rect;
}

@end
