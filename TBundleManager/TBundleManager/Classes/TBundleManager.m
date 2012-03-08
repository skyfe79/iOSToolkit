//
//  TBundleManager.m
//  TBundleManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TBundleManager.h"

static TBundleManager *g_instance_tbundle_manager = nil;

@interface TBundleManager()
-(BOOL)findBundle;
-(NSString *)findBundlePath:(NSString *)bundleName;
@end

@implementation TBundleManager
@synthesize pathForBundle;

/**
 * @brief   번들매니져 인스턴스를 반환한다.
 * @return  번들매니져의 인스턴스
 */
+(id) sharedInstance
{
    if(g_instance_tbundle_manager == nil)
    {
        g_instance_tbundle_manager = [[self alloc] init];
    }
    return g_instance_tbundle_manager;
}

/**
 * @brief 메모리 해지 메서드
 */
-(void)dealloc
{
    if(pathForBundle!=nil)
    {
        [pathForBundle release]; pathForBundle=nil;
    }
    if(bundle!=nil)
    {
        [bundle release]; bundle=nil;
    }
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if(self!=nil)
    {
        pathForBundle=nil;
        if(NO == [self findBundle])
        {
            bundle = nil;
            pathForBundle = nil;
        }
    }
    return self;
}

#pragma mark -
#pragma mark Private Methods
#pragma mark -
/**
 * @brief   각 디바이스에 맞는 번들을 찾는다.
 * @return  번들 찾기에 성공하면 YES 아니면 NO
 */
-(BOOL)findBundle
{
    //: 아이패드인지 검사한다
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        //: Bundle_iPad.bundle 을 찾는다
        NSString *path = [self findBundlePath:@"Bundle_iPad"];
        if(path == nil)
            return NO;
        pathForBundle = [path copy];
    }
    //: 아이폰계열이면
    else
    {
        //: 레티나 지원 기기인지 살펴본다
        if([[UIScreen mainScreen] respondsToSelector:@selector(scale)] &&
           [[UIScreen mainScreen] scale] == 2)
        {
            //: Bundle_Retina.bundle 을 찾는다
            NSString *path = [self findBundlePath:@"Bundle_Retina"];
            if(path == nil)
                return NO;
            pathForBundle = [path copy];
        }
        else
        {
            //: Bundle_Normal.bundle 을 찾는다
            NSString *path = [self findBundlePath:@"Bundle_Normal"];
            if(path == nil)
                return NO;
            pathForBundle = [path copy];
        }
    }
    
    //: 번들을 찾는다.
    bundle = [[NSBundle alloc]initWithPath:pathForBundle];
    return YES;
}

/**
 * @brief   번들 경로를 반환한다
 * @return  bundleName에 해당하는 번들의 경로를 반환한다
 */
-(NSString *)findBundlePath:(NSString *)bundleName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    return path;
}

/**
 * @brief   현재 번들에서 리소스의 경로를 반환한다.
 * @return  리소스의 경로 없으면 nil
 */
-(NSString *)pathForResource:(NSString *)name type:(NSString *)type
{
    if(bundle==nil)
        return nil;
    return [bundle pathForResource:name ofType:type];
}
@end
