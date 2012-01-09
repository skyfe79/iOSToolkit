//
//  UIView+Helper.h
//  UIViewExtension
//
//  Created by KIM SUNG CHEOL on 12. 1. 9..
//  Copyright (c) 2012 individual. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewUtilty
#pragma mark - 뷰계층구조
+(void) dumpView:(UIView *)aView 
        atIndent:(int)indent 
            into:(NSMutableString *)outString;
+(NSString *)displayViews:(UIView *)aView;
#pragma mark - 뷰탐색
+(NSArray *)allSubViews:(UIView *)aView;
+(NSArray *)allApplicationViews;
+(NSArray *)pathToView:(UIView *)aView;
@end
