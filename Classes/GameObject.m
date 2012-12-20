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

#import "GameObject.h"


@implementation GameObject

- (void)updatePosition {
}



-(void) step: (ccTime) delta {
}

@end



@implementation GameObjectWrapper

@synthesize target;

- (id)initWithTarget:(GameObject*)_target
{
	target = _target;
	return [super init];
}


@end