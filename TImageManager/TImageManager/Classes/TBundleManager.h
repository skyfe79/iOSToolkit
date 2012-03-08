//
//  TBundleManager.h
//  TBundleManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBundleManager : NSObject
{
    NSBundle    *bundle;
    NSString    *pathForBundle;
}
@property(nonatomic, readonly) NSString *pathForBundle;
+(id) sharedInstance;
@end
