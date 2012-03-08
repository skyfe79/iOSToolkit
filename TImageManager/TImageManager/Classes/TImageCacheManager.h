//
//  TImageManager.h
//  TImageManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 * @brief 이미지 캐쉬를 관리한다.
 */
@interface TImageCacheManager : NSObject
{
    NSMutableDictionary *cachedImages;
}
+(id)sharedInstance;
-(void)releaseCachedImages;
-(void)cacheImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;
@end


@interface UIImage(TImageCacheManager_Helper)
+(UIImage *)imageFromBundle:(NSString *)imageName;
@end
