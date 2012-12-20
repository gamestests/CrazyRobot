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

#import "MainMenu.h"


@implementation MainMenu

- (id) init: (id<MainMenuDelegate>) _delegate {
	[super init];
	
	delegate = _delegate;
	
	Sprite *bg = [Sprite spriteWithFile:@"menu.png"];
	bg.anchorPoint = cpvzero;	
	[self addChild:bg z:0];			

	MenuItemImage *vm = [MenuItemImage itemFromNormalImage:@"b_machine.png" selectedImage:@"b_machine_s.png" target:self selector:@selector(startSingle:)];	
	Menu *vmm = [Menu menuWithItems: vm, nil];
	vmm.position = cpv(240, 110);
	[self addChild:vmm z:1];
	
    MenuItemImage *va = [MenuItemImage itemFromNormalImage:@"b_about.png" selectedImage:@"b_about_s.png" target:self selector:@selector(about:)];
	Menu *vaa = [Menu menuWithItems: va, nil];
	vaa.position = cpv(240, 40);
	[self addChild:vaa z:1];
	return self;
}



- (void)layerReplaced
{
}



-(void) startSingle: (id) sender
{	
	[delegate startSinglePlayer];
}


-(void)about: (id)sender{
    [delegate about];
}


@end
