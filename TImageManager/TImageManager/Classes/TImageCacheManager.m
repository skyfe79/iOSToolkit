//
//  TImageManager.m
//  TImageManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TImageCacheManager.h"
#import "TBundleManager.h"
static TImageCacheManager *g_instance_timage_manager = nil;

@implementation TImageCacheManager
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
        cachedImages = [[NSMutableDictionary alloc]init];
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

/**
 * @brief 캐쉬된 이미지를 지운다. 주로 메모리 경고가 발생할 때 사용한다.
 *          따라서 UIViewController 의 메모리 경고 노티처리 메서드에서 사용한다
 */
-(void)releaseCachedImages
{
    //: 캐쉬사전이 가지고 있는 모든 이미지의 retain count를 -1한다
    //: 0이 되는 것은 메모리에서 지워질 것이고 현재 화면에 있는 이미지는 retain count가 0이 
    //: 아니므로 지워지지 않는다.
    [cachedImages removeAllObjects];
}

/**
 * @brief UIImage 인스턴스를 key이름으로 캐쉬한다
 */
-(void)cacheImage:(UIImage *)image forKey:(NSString *)key
{
    [cachedImages setObject:image forKey:key];
}

/**
 * @brief  캐쉬된 이미지를 반환한다
 * @return 캐쉬된 이미지가 있으면 해당 인스턴스 포인터 아니면 nil
 */
-(UIImage *)imageForKey:(NSString *)key
{
    return [cachedImages objectForKey:key];
}
@end



@implementation UIImage(TImageCacheManager_Helper)
/**
 * @brief imageName이 캐쉬되어 있으면 해당 이미지 인스턴스 포인터를 넘긴다.
 *        아니면 번들에서 이미지를 찾아서 이미지를 캐쉬하고 해당 이미지를 넘긴다
 */          
+(UIImage *)imageFromBundle:(NSString *)imageName
{
    UIImage *image = [[TImageCacheManager sharedInstance] imageForKey:imageName];
    if(image==nil)
    {
        //: 번들에서 이미지의 경로를 찾는다.
        NSString *type = [imageName pathExtension];
        NSString *fileName = [imageName stringByDeletingPathExtension];
        
        //: 레티나이면 @2x를 붙여주고
        //: iPad이면 _ipad를 붙여준다.
        //: 아이패드인지 검사한다
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            fileName = [fileName stringByAppendingString:@"_ipad"];
        }
        //: 아이폰계열이면
        else
        {
            //: 레티나 지원 기기인지 살펴본다
            if([[UIScreen mainScreen] respondsToSelector:@selector(scale)] &&
               [[UIScreen mainScreen] scale] == 2)
            {
                fileName = [fileName stringByAppendingString:@"@2x"];
            }
            else
            {}
        }
        
        //: 이미지를 로드한다.
        NSString *imagePath = [[TBundleManager sharedInstance] pathForResource:fileName type:type];
        image = [UIImage imageWithContentsOfFile:imagePath];
        NSLog(@"imagePath : %@", imagePath);
        //: image 로드가 성공하면 이미지 이름으로 캐쉬한다.
        if(image!=nil)
        {
            [[TImageCacheManager sharedInstance] cacheImage:image forKey:imageName];
        }
    }
    return image;
}
@end