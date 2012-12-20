//
//  BootAnimation.m
//  punchball
//
//  Created by ldci on 12-12-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BootAnimation.h"
#import "MainMenu.h"
@implementation BootAnimation

- (id) init: (id<BootAnimationDelegate>) _delegate {
    if (self = [super init]) {
        delegate = _delegate;
        CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
        [CCVideoPlayer setDelegate:self];   // 得到委托
        [CCVideoPlayer playMovieWithFile:@"gandam_touch.MP4"];//播放MP4视频
        self.isTouchEnabled = YES;
    }
    return self;
}

-(void) movieStartsPlaying{ // 视频开始播放
    CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
}

-(void) moviePlaybackFinished{
    CCLOG(@"moviePlaybackFinished");  //视频结束后自动进入游戏主菜单场景
    [delegate mainMenu];
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{ //通过触摸跳过开机视频
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [CCVideoPlayer setNoSkip:YES];//视频是否可以跳过
    return YES;
}

- (void)layerReplaced
{
}

-(void) dealloc{     //退出时调用释放方法
    CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
    [super dealloc];
}

@end

