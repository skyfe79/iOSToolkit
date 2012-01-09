//
//  UIView+Helper.m
//  UIViewExtension
//
//  Created by KIM SUNG CHEOL on 12. 1. 9..
//  Copyright (c) 2012 individual. All rights reserved.
//

#import "UIView+Helper.h"

/**
 * @brief   사각형의 중점을 반환한다
 * @param   rect : 중점을 구할 사각형
 * @return  사각형의 중심점
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

/**
 * @brief   사각형을 center 포인터가 중심이 되게 옮긴다
 * @param   rect : 옮길 사각형
 * @param   center : 새로운 센터
 * @return  옮겨진 사각형 영역
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newRect = CGRectZero;
    newRect.origin.x = center.x - CGRectGetMidX(rect);
    newRect.origin.y = center.y - CGRectGetMidY(rect);
    newRect.size = rect.size;
    return newRect;
}

@implementation UIView(Helper)

#pragma mark - 뷰기하관련
/**
 * @brief   뷰의 원점을 반환한다
 * @return  뷰의 원점
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGPoint)origin
{
    return self.frame.origin;
}
/**
 * @brief   뷰의 원점을 새로 지정한다
 * @param   newOrigin : 새로운 원점
 * @return  void
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(void)setOrigin:(CGPoint)newOrigin
{
    CGRect newFrame = self.frame;
    newFrame.origin = newOrigin;
    self.frame = newFrame;
}

/**
 * @brief   뷰 영역의 크기를 반환한다
 * @return  뷰 영역의 크기
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGSize)size
{
    return self.frame.size;
}

/**
 * @brief   뷰 영역의 크기를 새로 지정한다
 * @param   newSize : 새로운 크기
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(void)setSize:(CGSize)newSize
{
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    self.frame = newFrame;
}

/**
 * @brief   뷰영역의 top-left 영역 위치를 반환한다
 * @return  top-left point
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGPoint)topLeft
{
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

/**
 * @brief   뷰영역의 top-right 영역 위치를 반환한다
 * @return  top-right point
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGPoint)topRight
{
    CGFloat x = self.frame.origin.x + self.frame.origin.size.height;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

/**
 * @brief   뷰영역의 bottom-left 영역 위치를 반환한다
 * @return  bottom-left point
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGPoint)bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

/**
 * @brief   뷰영역의 bottom-right 영역 위치를 반환한다
 * @return  bottom-right point
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGPoint)bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)newHeight
{
    CGRect newFrame = self.frame;
    newFrame.size.height = newHeight;
    self.frame = newFrame;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)newWidth
{
    CGRect newFrame = self.frame;
    newFrame.size.width = newWidth;
    self.frame = newFrame;
}

-(void)top
{
    return self.frame.origin.y;
}

-(void)setTop:(CGFloat)newTop
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newTop;
    self.frame = newFrame;
}

-(CGFloat)left
{
    return self.frame.origin.x;
}

-(void)setLeft:(CGFloat)newLeft
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newLeft;
    self.frame = newFrame;
}

-(CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setBottom:(CGFloat)newBottom
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newBottom - self.frame.size.height;
    self.frame = newFrame;
}

-(CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setRight:(CGFloat)newRight
{
    CGFloat delta = newRight - [self.frame.origin.x + self.frame.size.width];
    CGRect newFrame = self.frame;
    newFrame.origin.x += delta;
    self.frame = newFrame;
}

#pragma mark - 크기조정
/**
 * @brief   뷰의 크기를 새로 지정한다
 * @param   newSize : 뷰의 새로운 크기
 * @return  void
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(void) setSize:(CGSize)newSize
{
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    self.frame = newFrame;
}

/**
 * @brief   inSize에 맞게 뷰를 종횡비를 지켜가며 크기를 줄인다
 * @param   inSize : 기준 크기
 * @return  void
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(void) fitInSize:(CGSize)inSize
{
    CGFloat scale;
    CGRect  newFrame = self.frame;
    
    //: 높이
    if(newFrame.size.height > inSize.height)
    {
        scale = inSize.height / newFrame.size.height;
        newFrame.size.width *= scale;
        newFrame.size.height *= scale;
    }
    
    //: 너비
    if(newFrame.size.width >= inSize.width)
    {
        scale = inSize.width / newFrame.size.width;
        newFrame.size.width *= scale;
        newFrame.size.height *= scale;
    }
    
    self.frame = newFrame;
}
@end
