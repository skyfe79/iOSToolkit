//
//  UIView+Helper.m
//  UIViewExtension
//
//  Created by KIM SUNG CHEOL on 12. 1. 9..
//  Copyright (c) 2012 individual. All rights reserved.
//

#import "UIViewUtility.h"


@implementation UIViewUtilty
#pragma mark -
#pragma mark 뷰계층구조
/**
 * @brief   레벨을 늘려가며 재귀적으로 뷰 트리를 탐색해 내려간다
 * @param   aView : 탐색을 시작할 뷰
 * @param   atIndent : 뷰 계층의 깊이
 * @param   into : 결과를 받을 스트링
 * @return  none
 * @remark  none
 * @see     displayViews:
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
+(void) dumpView:(UIView *)aView 
        atIndent:(int)indent 
            into:(NSMutableString *)outString
{
    for(int i=0; i<indent; i++)
    {
        [outString appendString:@"\t"];
    }
    [outString appendFormat:@"[%2d] %@\n", indent, [[aView class] description]];
    for(UIView *view in [aView subviews])
        [self dumpView:view atIndent:indent+1 into:outString];
}

/**
 * @brief   레벨 0인 루트 뷰에서붙 트리를 재귀적으로 탐색한다
 * @param   aView : 탐색을 시작할 뷰
 * @return  NSString* : 탐색 결과 뷰의 계층 구조를 담은 문자열
 * @remark  none
 * @see     dumpView:atIndent:into:
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 * @exeample
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addSubview:[UIButton buttonWithType:UIButtonTypeCustom]];
    [self.view addSubview:button];
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom]];
    NSLog(@"\n%@",[self.view displayViews:self.view]);
 * @out
    [ 0] UIView
        [ 1] UIButton
            [ 2] UIButton
        [ 1] UIButton
 */
+(NSString *)displayViews:(UIView *)aView
{
    NSMutableString *outString= [[NSMutableString alloc] init];
    [self dumpView:aView atIndent:0 into:outString];
    return [outString autorelease];
}


#pragma mark - 
#pragma mark 뷰탐색
/**
 * @brief   뷰의 하위 뷰에 해당하는 모든 자손을 배열로 반환한다
 * @param   aView : 시작할 뷰
 * @return  NSArray : 모든 자손 뷰 배열
 * @remark  none
 * @see     none
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
+(NSArray *)allSubViews:(UIView *)aView
{
    NSArray *result = [aView subviews];
    for(UIView *view in [aView subviews])
    {
        NSArray *subviews = [UIViewUtilty allSubViews:view];
        if(subviews)
        {
            result = [result arrayByAddingObjectsFromArray:subviews];
        }
    }
    return result;
}
/**
 * @brief   애플리케이션의 모든 뷰를 반환한다
 * @param   void
 * @return  애플리케이션의 모든 뷰를 담은 배열
 * @remark  none
 * @see     none
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
+(NSArray *)allApplicationViews
{
    NSArray *result = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        NSArray *subviews = [UIViewUtilty allSubViews:window];
        if(subviews)
        {
            result = [result arrayByAddingObjectsFromArray:subviews];
        }
    }
    return result;
}
/**
 * @brief   UIWindow로부터 해당 뷰까지 부모 뷰의 배열을 반환한다
 * @param   aView : 경로를 얻을 뷰
 * @return  경로를 담은 배열
 * @remark  none
 * @see     none
 * @author  Sungcheol Kim(skyfe79@gmail.com)
 */
+(NSArray *)pathToView:(UIView *)aView
{
    NSMutableArray *array = [NSMutableArray arrayWithObject:aView];
    UIView      *view = aView;
    UIWindow    *window = aView.window;
    while (view!=window)
    {
        view = [view superview];
        [array insertObject:view atIndex:0];
    }
    return array;
}
@end
