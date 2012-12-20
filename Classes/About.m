//
//  About.m
//  punchball
//
//  Created by Kid on 12-12-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "About.h"


@implementation About
- (id) init: (id<ReturnDelegate>) _delegate{
    [super init];
    
    delegate = _delegate;
    
    [self initInterface];

    return self;
}



-(void)initInterface{
    CGSize screen = [[Director sharedDirector] winSize];
    Label* label1 = [Label labelWithString:@"团队名称: " fontName:@"Helvetica-BoldOblique" fontSize:20];
    label1.position = ccp(screen.width * 0.3, screen.height * 0.8);
    [self addChild:label1 z:1];
    
    Label* label2 = [Label labelWithString:@"TEAM 3 " fontName:@"Helvetica-BoldOblique" fontSize:21];
    label2.position = ccp(screen.width * 0.5, screen.height * 0.8);
    [self addChild:label2 z:1];
    
    Label* label3 = [Label labelWithString:@"团队成员: " fontName:@"Helvetica-BoldOblique" fontSize:20];
    label3.position = ccp(screen.width * 0.3, screen.height * 0.6);
    [self addChild:label3 z:1];
    
    Label* label4 = [Label labelWithString:@"盛绍斌、王永鑫、樊慧斌 " fontName:@"Helvetica-BoldOblique" fontSize:21];
    label4.position = ccp(screen.width * 0.65, screen.height * 0.6);
    [self addChild:label4 z:1];
    
    Label* label5 = [Label labelWithString:@"鸣谢: " fontName:@"Helvetica-BoldOblique" fontSize:20];
    label5.position = ccp(screen.width * 0.3, screen.height * 0.4);
    [self addChild:label5 z:1];
    
    Label* label6 = [Label labelWithString:@"杨皓云 and so on " fontName:@"Helvetica-BoldOblique" fontSize:21];
    label6.position = ccp(screen.width * 0.60, screen.height * 0.4);
    [self addChild:label6 z:1];
    
    
    
    
    
    MenuItemImage *va = [MenuItemImage itemFromNormalImage:@"b_back.png" selectedImage:@"b_back_s.png" target:self selector:@selector(return_menu:)];
	Menu *vaa = [Menu menuWithItems: va, nil];
	vaa.position = cpv(240, 50);
	[self addChild:vaa z:1];
}



-(void)return_menu : (id)sender{
    [delegate return_menu];
}


- (void)layerReplaced
{
}


@end
