//
//  TImageManager.h
//  TImageManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TImageManager : NSObject
{
    NSDictionary *cachedImages;
}
+(id)sharedInstance;
@end
