//
//  PPAppDelegate.m
//  PingPong
//
//  Created by Marcus Brissman on 2013-05-29.
//  Copyright (c) 2013 Marcus Brissman. All rights reserved.
//

#import "PPAppDelegate.h"
#import "PPMenuScene.h"

@implementation PPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	CCGLView *glView = [CCGLView viewWithFrame:[_window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
	
	[glView setMultipleTouchEnabled:YES];
	
	_director = (CCDirectorIOS*) [CCDirector sharedDirector];
	[_director setWantsFullScreenLayout:YES];
	
	// Display FSP and SPF
	[_director setDisplayStats:NO];
	
	// set FPS at 60
	[_director setAnimationInterval:1.0/60];
	
	// attach the openglView to the director
	[_director setView:glView];
	
	// for rotation and other messages
	[_director setDelegate:self];
	
	// 2D projection
	[_director setProjection:kCCDirectorProjection2D];
	
	if( ! [_director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[_director pushScene: [PPMenuScene scene]];

	_navController = [[UINavigationController alloc] initWithRootViewController:_director];
	[_navController setNavigationBarHidden:YES];
	
	[_window setRootViewController:_navController];
	
    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
