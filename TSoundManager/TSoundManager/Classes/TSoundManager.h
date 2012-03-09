//
//  TSoundManager.h
//  TSoundManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief   효과음 및 배경음을 재생하는 모듈
 *          cocos2d의 cocosDenshion lib을 사용한다.
 *          배경음악은 하나 밖에 플레이 할 수 없음.
 * @author  김성철(skyfe79@gmail.com)
 */

@interface TSoundManager : NSObject
{
    NSDictionary    *preloadedSounds;
    NSUInteger      currentFxId;
}
+(id)sharedInstance;
-(BOOL)preloadFromPlist:(NSString *)plistFileName;
-(void)unloadAllSounds;

-(BOOL)playBG:(NSString *)backgroundMusicName;
-(BOOL)playBG:(NSString *)backgroundMusicName loop:(BOOL)loop;
-(void)stopBG;
-(void)pauseBG;
-(void)resumeBG;


-(BOOL)playFX:(NSString *)effectSoundName;
-(void)stopFX;
@end
