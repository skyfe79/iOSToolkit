//
//  UIView+Helper.m
//  UIViewExtension
//
//  Created by KIM SUNG CHEOL on 12. 1. 9..
//  Copyright (c) 2012 individual. All rights reserved.
//

#import "UIView+Helper.h"

/**
 * @brief   ???? ??? ????
 * @param   rect : ??? ?? ???
 * @return  ???? ???
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
 * @brief   ???? center ???? ??? ?? ???
 * @param   rect : ?? ???
 * @param   center : ??? ??
 * @return  ??? ??? ??
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

#pragma mark - ?????
/**
 * @brief   ?? ??? ????
 * @return  ?? ??
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGPoint)origin
{
    return self.frame.origin;
}
/**
 * @brief   ?? ??? ?? ????
 * @param   newOrigin : ??? ??
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
 * @brief   ? ??? ??? ????
 * @return  ? ??? ??
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGSize)size
{
    return self.frame.size;
}

/**
 * @brief   ? ??? ??? ?? ????
 * @param   newSize : ??? ??
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(void)setSize:(CGSize)newSize
{
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    self.frame = newFrame;
}

/**
 * @brief   ???? top-left ?? ??? ????
 * @return  top-left point
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(CGPoint)topLeft
{
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

/**
 * @brief   ???? top-right ?? ??? ????
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
 * @brief   ???? bottom-left ?? ??? ????
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
 * @brief   ???? bottom-right ?? ??? ????
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

#pragma mark - ????
/**
 * @brief   ?? ??? ?? ????
 * @param   newSize : ?? ??? ??
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
 * @brief   inSize? ?? ?? ???? ???? ??? ???
 * @param   inSize : ?? ??
 * @return  void
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
-(void) fitInSize:(CGSize)inSize
{
    CGFloat scale;
    CGRect  newFrame = self.frame;
    
    //: ??
    if(newFrame.size.height > inSize.height)
    {
        scale = inSize.height / newFrame.size.height;
        newFrame.size.width *= scale;
        newFrame.size.height *= scale;
    }
    
    //: ??
    if(newFrame.size.width >= inSize.width)
    {
        scale = inSize.width / newFrame.size.width;
        newFrame.size.width *= scale;
        newFrame.size.height *= scale;
    }
    
    self.frame = newFrame;
}
@end
