//
//  About.h
//  punchball
//
//  Created by Kid on 12-12-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ReplaceLayerAction.h"

@protocol ReturnDelegate

-(void)return_menu;

@end


@interface About : Layer <ReplaceLayerActionDelegate>{
    id<ReturnDelegate> delegate;
}
- (id) init: (id<ReturnDelegate>) _delegate;

@end
