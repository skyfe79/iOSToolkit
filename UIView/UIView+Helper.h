//
//  UIView+Helper.h
//  UIViewExtension
//
//  Created by KIM SUNG CHEOL on 12. 1. 9..
//  Copyright (c) 2012 individual. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 기하 도움 함수
CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);


@interface UIView(Helper)
#pragma mark - 뷰기하관련
@property CGPoint origin;
@property CGSize size;
@property (readonly) CGPoint topLeft;
@property (readonly) CGPoint topRight;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property CGFloat height;
@property CGFloat width;
@property CGFloat top;
@property CGFloat left;
@property CGFloat bottom;
@property CGFloat right;
-(void) moveBy:(CGPoint)delta;
-(void) scaleBy:(CGFloat)scaleFactor;
#pragma mark - 크기조정
-(void) setSize:(CGSize)newSize;
-(void) fitInSize:(CGSize)inSize;
@end

