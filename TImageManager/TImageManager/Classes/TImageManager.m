//
//  TImageManager.m
//  TImageManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TImageManager.h"

static TImageManager *g_instance_timage_manager = nil;

@implementation TImageManager
+(id)sharedInstance
{
    if(g_instance_timage_manager==nil)
    {
        g_instance_timage_manager = [[self alloc]init];
    }
    return g_instance_timage_manager;
}

-(id)init
{
    self = [super init];
    if(self!=nil)
    {
        
    }
    return self;
}

-(void)dealloc
{
    if(cachedImages!=nil)
    {
        [cachedImages release]; cachedImages=nil;
    }
    [super dealloc];
}
@end
