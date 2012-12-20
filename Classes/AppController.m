/*
 Copyright 2009 Kaspars Dancis
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "AppController.h"
#import "ReplaceLayerAction.h"
#import "SinglePlayerGame.h"
#import "About.h"
#import "PASoundMgr.h"
#import "Empty.h"
#import "Splash.h"

typedef enum {
	StateNone,
    StateBoot,
	StateMenu,
    StateAbout,
	StateControls,
	StateSingleOpponent,
	StateSingle,
	StateSingleOver,
} AppState;


@implementation AppController

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	application.idleTimerDisabled = YES; // we don't want the screen to sleep during our game 
	

	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window setMultipleTouchEnabled:YES];
	
	//[Director useFastDirector]; // causing prblems with GKPeerPicker

	// before creating any layer, set the landscape mode
	[[Director sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
	
	[[Director sharedDirector] attachInView:window];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[Texture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];	
	
	
	// add layer
	scene = [Scene node];
	
	Sprite *bg = [Sprite spriteWithFile:@"bg.png"];
	bg.anchorPoint = cpvzero;	
	[scene addChild:bg z:0];		
	
	currentLayer = nil;
	
	[MenuItemFont setFontSize:40];
	
	[PASoundMgr sharedSoundManager];
	
	[window makeKeyAndVisible];
	
	[[Director sharedDirector] runWithScene: scene];
	
	Splash *splash = [Splash node];
	[scene addChild:splash z:1];
	currentLayer = splash;
	
	gameState = StateNone;
	
	state = [[State alloc] init];

	//[self mainMenu];
    [self bootAnimation];
   
}

-(NSString*)adPositionId
{
	return @"90017037";
}

// AdView Parameters Setting (Optional)
// Set Ad Refresh Interval
-(NSTimeInterval)adInterval
{
    // Default 60 Seconds
    return 20;
}

//// Set Developer Define Ad Measure
//-(AdMeasureType)adMeasure
//{
//    // Default not set;
//}



- (void) dealloc
{
	[opponentID release];
	[opponentName release];
	[state release];
	[window release];
	[super dealloc];
}



// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	[[Director sharedDirector] pause];
}



// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	[[Director sharedDirector] resume];
}



// purge memroy
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[TextureMgr sharedTextureMgr] removeAllTextures];
}



// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[Director sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) bootAnimation{
    if (gameState != StateBoot) {
        gameState = StateBoot;
        BootAnimation *boot = [[[BootAnimation alloc]init:self]autorelease];
        ReplaceLayerAction *replaceScreen = [[[ReplaceLayerAction alloc] initWithScene:scene layer:boot replaceLayer:currentLayer]autorelease];
        replaceScreen.reverse = true;
        [scene runAction: replaceScreen];
		currentLayer = boot;
    }
}

- (void) mainMenu {
		gameState = StateMenu;
		
		MainMenu *menu = [[[MainMenu alloc] init:self] autorelease];	
		ReplaceLayerAction *replaceScreen = [[[ReplaceLayerAction alloc] initWithScene:scene layer:menu replaceLayer:currentLayer] autorelease];
		replaceScreen.reverse = true;
		[scene runAction: replaceScreen];
		currentLayer = menu;
	
}



- (void) opponentSelected:(int)_opponent {
	opponent = _opponent;
	
	gameState = StateSingle;
	
	SinglePlayerGame *game = [[[SinglePlayerGame alloc] initWithDelegate:self opponent:_opponent] autorelease];	
	ReplaceLayerAction *replaceScreen = [[[ReplaceLayerAction alloc] initWithScene: scene layer:game replaceLayer:currentLayer] autorelease];
	[scene runAction: replaceScreen];
	currentLayer = game;	
}



- (void) startSinglePlayer {
	gameState = StateSingleOpponent;
	
	Opponent *o = [[[Opponent alloc] init:self] autorelease];
	ReplaceLayerAction *replaceScreen = [[[ReplaceLayerAction alloc] initWithScene: scene layer:o replaceLayer:currentLayer] autorelease];
	[scene runAction: replaceScreen];
	currentLayer = o;	
}



- (void) about {
	gameState = StateAbout;
	
	About *a = [[[About alloc] init:self] autorelease];
	ReplaceLayerAction *replaceScreen = [[[ReplaceLayerAction alloc] initWithScene: scene layer:a replaceLayer:currentLayer] autorelease];
	[scene runAction: replaceScreen];
	currentLayer = a;
}


- (void) return_menu {
    [self mainMenu];
}


- (void) gameOver: (bool)_youWin score:(int)_score opponentName:(NSString*)_opponentName
{
  
	youWin = _youWin;
	score = _score;
	opponentName = [_opponentName copy];
	
	if (!state.name) {
		[self enterName];
		return;
	} 
	
	
	
 if (gameState == StateSingle) {
		opponentID = [[NSString stringWithFormat:@"ID_0_%@", opponentName] retain];
		
		gameState = StateSingleOver;
	}
	
	GameOver *go = [[[GameOver alloc] initWithDelegate:self youWin:youWin score:score opponentName:opponentName] autorelease];
		
	ReplaceLayerAction *replaceScreen = [[[ReplaceLayerAction alloc] initWithScene:scene layer:go replaceLayer:currentLayer] autorelease];
	[scene runAction: replaceScreen];
	currentLayer = go;
}



-(void) onGameOverReplay {
if (gameState == StateSingleOver) {
		[self opponentSelected:opponent];
		
	}
   
}



-(void) onGameOverMenu {
	
	[self mainMenu];
}



- (void) enterName {
	EnterName *l = [[[EnterName alloc] initWithDelegate:self window:window] autorelease];	
	ReplaceLayerAction *replaceScreen = [[[ReplaceLayerAction alloc] initWithScene:scene layer:l replaceLayer:currentLayer] autorelease];
	[scene runAction: replaceScreen];
	currentLayer = l;
}



- (void) nameEntered: (NSString*)name {
	state.name = name;
	if (gameState == StateSingle) {
		[self gameOver:youWin score:score opponentName:opponentName];
	} 		
}

@end
