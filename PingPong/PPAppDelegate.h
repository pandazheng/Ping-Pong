//
//  PPAppDelegate.h
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-29.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface PPAppDelegate : UIResponder <UIApplicationDelegate, CCDirectorDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CCDirectorIOS *director;
@property (strong, nonatomic) UINavigationController *navController;

@end
