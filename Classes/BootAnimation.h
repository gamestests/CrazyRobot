//
//  BootAnimation.h
//  punchball
//
//  Created by ldci on 12-12-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"
#import "CCVideoPlayer.h"
#import "ReplaceLayerAction.h"

@protocol BootAnimationDelegate
-(void)  mainMenu;
@end
@interface BootAnimation : Layer <CCVideoPlayerDelegate,ReplaceLayerActionDelegate>{
    id<BootAnimationDelegate> delegate;
}
- (id) init: (id<BootAnimationDelegate>) _delegate;
@end
