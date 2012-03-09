//
//  TSoundManager.m
//  TSoundManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TSoundManager.h"
#import "SimpleAudioEngine.h"

static TSoundManager *g_instance_tsound_manager = nil;

@interface TSoundManager()
-(NSString *)pathForResourceInMainBundle:(NSString *)fileName;
@end

@implementation TSoundManager
+(id)sharedInstance
{
    if(g_instance_tsound_manager==nil)
    {
        g_instance_tsound_manager = [[self alloc]init];
    }
    return g_instance_tsound_manager;
}

-(id)init
{
    self = [super init];
    if(self!=nil)
    {}
    return self;
}
-(void)dealloc
{
    if(preloadedSounds!=nil)
    {
        [self unloadAllSounds];
        [preloadedSounds release]; preloadedSounds=nil;
    }
    [super dealloc];
}

/**
 * @brief plist에 정의된 사운드를 프리로드한다
 * plist 는 그룹별로 사운드 파일 이름을 정의한다.
 */
-(BOOL)preloadFromPlist:(NSString *)plistFileName
{
    if(preloadedSounds!=nil)
    {
        //: 우선 기존의 사운드를 모두 unload 한다
        [self unloadAllSounds];
        [preloadedSounds release]; preloadedSounds=nil;
    }
    
    NSString *plistFilePath = [self pathForResourceInMainBundle:
                               [plistFileName stringByAppendingPathExtension:@"plist"]];
    preloadedSounds = [[NSDictionary dictionaryWithContentsOfFile:plistFilePath] retain];
    if(preloadedSounds == nil)
        return NO;
    
    for(NSString *key in [preloadedSounds allKeys])
    {
        if([key isEqualToString:@"bg"])
        {
            NSString *bgPath = [self pathForResourceInMainBundle:[preloadedSounds valueForKey:key]];
            [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:bgPath];
        }
        else
        if([key rangeOfString:@"fx"].location != NSNotFound)
        {
            NSString *fxPath = [self pathForResourceInMainBundle:[preloadedSounds valueForKey:key]];
            [[SimpleAudioEngine sharedEngine] preloadEffect:fxPath];
        }
        else
        {
            continue;
        }
    }
    return YES;
}

/**
 * @brief 모든 효과음을 메모리에서 언로드한다. 배경음을 새로운 배경음을 로드하면 메모리에서 언로드된다
 */
-(void)unloadAllSounds
{
    //: 백그라운드 뮤직은 새로운 것을 preload하면 기존 것은 자동 unload 된다.
    if(preloadedSounds==nil)
        return ;
    
    for(NSString *key in [preloadedSounds allKeys])
    {
        if([key rangeOfString:@"fx"].location != NSNotFound)
        {
            NSString *fxPath = [self pathForResourceInMainBundle:[preloadedSounds valueForKey:key]];
            [[SimpleAudioEngine sharedEngine] unloadEffect:fxPath];
        }
        else
        {
            continue;
        }
    }
}

/**
 * @brief 배경음악을 재생한다. loop 여부는 plist 파일 설정에 따른다
 */
-(BOOL)playBG:(NSString *)backgroundMusicName
{
    if(preloadedSounds==nil)
        return NO;
    
    NSString *bgFileNameExt = [preloadedSounds valueForKey:backgroundMusicName];
    if(bgFileNameExt == nil)
        return NO;
    
    NSString *bgFileExt = [bgFileNameExt pathExtension];
    NSString *bgFileName= [bgFileNameExt stringByDeletingPathExtension];
    NSString *bgPath = [[NSBundle mainBundle] pathForResource:bgFileName ofType:bgFileExt];
    if(bgPath == nil)
        return NO;

    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:bgPath 
                                                     loop:[[preloadedSounds valueForKey:@"loop_bg"]boolValue]];
    return YES;
}

/**
 * @brief 배경음악을 재생한다. loop 여부를 설정할 수 있다.
 */
-(BOOL)playBG:(NSString *)backgroundMusicName loop:(BOOL)loop
{
    if(preloadedSounds==nil)
        return NO;
    
    NSString *bgFileNameExt = [preloadedSounds valueForKey:backgroundMusicName];
    if(bgFileNameExt == nil)
        return NO;
    
    NSString *bgPath = [self pathForResourceInMainBundle:bgFileNameExt];
    if(bgPath == nil)
        return NO;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:bgPath 
                                                     loop:loop];
    return YES;
}

/**
 * @brief 배경음을 stop 한다
 */
-(void)stopBG
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

/**
 * @brief 배경음을 pause 한다
 */
-(void)pauseBG
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

/**
 * @brief pause 한 배경음을 다시 재생한다
 */
-(void)resumeBG
{
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}

/**
 * @biref 효과음을 재생한다
 */
-(BOOL)playFX:(NSString *)effectSoundName
{
    NSString *fxPath = [self pathForResourceInMainBundle:
                        [preloadedSounds valueForKey:effectSoundName]];
    if(fxPath==nil)
        return NO;
    
    currentFxId = [[SimpleAudioEngine sharedEngine] playEffect:fxPath];
    return YES;
}

/**
 * @brief 현재 효과음을 멈춘다
 */
-(void)stopFX
{
    [[SimpleAudioEngine sharedEngine] stopEffect:currentFxId];
}

/**
 * 메인번들에서 리소스의 경로를 찾아 반환한다.
 */
-(NSString *)pathForResourceInMainBundle:(NSString *)fileNameExt
{
    NSString *fileExt = [fileNameExt pathExtension];
    NSString *fileName= [fileNameExt stringByDeletingPathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExt];
    return path;
}
@end
