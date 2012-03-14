//
//  TPaintBoard.h
//  FirstMath
//
//  Created by skyfe79 on 12. 3. 14..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/** 
 * @brief   그림그리기가 가능한 레이어
 * @author  김성철(skyfe79@gmail.com)
 */
@interface TPaintBoard : CCLayerColor 
{
    CCRenderTexture *board;
    CGFloat         brushWidth;
    ccColor4B       boardColor;
    ccColor4B       brushColor;
}
@property(nonatomic, readwrite) CGFloat brushWidth;
@property(nonatomic, readwrite) ccColor4B brushColor;
+(id)whitePaintBoardWithSize:(CGSize)size;
+(id)colorPaintBoardWithColor:(ccColor4B)color size:(CGSize)size;
-(void)clear;
@end
