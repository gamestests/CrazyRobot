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

#import "GameOver.h"
#import "MainMenu.h"
#import "About.h"
#import "Game.h"
#import "State.h"
#import "Opponent.h"
#import "EnterName.h"
#import "BootAnimation.h"

@interface AppController : NSObject 
	<
	UIApplicationDelegate,
    BootAnimationDelegate,
	GameDelegate, 
	GameOverDelegate, 
	MainMenuDelegate,
    ReturnDelegate,
	OpponentDelegate,
	EnterNameDelegate
	> 
{
	UIWindow	*window;
	Scene		*scene;
	Layer		*currentLayer;
	State		*state;
	int			gameState;
	int			opponent;
	
	bool youWin;
	int score;
	NSString *opponentName;
	NSString *opponentID;
    UIViewController *rootViewController;
}

- (void) mainMenu;
- (void) enterName;

@end

