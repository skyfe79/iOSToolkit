//
//  TPaintBoard.m
//  FirstMath
//
//  Created by skyfe79 on 12. 3. 14..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "TPaintBoard.h"
#import "common.h"

@implementation TPaintBoard
@synthesize brushWidth;
@synthesize brushColor;

+(id)whitePaintBoardWithSize:(CGSize)size
{
    return [[[self alloc]initWithColor:ccc4(255,
                                            255,
                                            255,
                                            255)
                                 width:size.width
                                height:size.height]autorelease];
}
+(id)colorPaintBoardWithColor:(ccColor4B)color size:(CGSize)size
{
    return [[[self alloc]initWithColor:color
                                 width:size.width
                                height:size.height]autorelease];
}
-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
    self = [super initWithColor:ccc4(0, 0, 0, 0) width:w height:h];
    if(self!=nil)
    {
        board = [CCRenderTexture renderTextureWithWidth:w
                                                 height:h];
        [board clear:color.r
                   g:color.g
                   b:color.b
                   a:color.a];
        
        [board retain];
        [board setPosition:ccp(w/2, h/2)];
        [self addChild:board];        
        self.isTouchEnabled = YES;
        self.brushWidth = 5.0f;
        boardColor = color;
        brushColor = ccc4(0, 0, 0, 255);
    }
    return self;
}

-(void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                     priority:0
                                              swallowsTouches:YES];
    [super onEnter];
}

-(void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

-(void)dealloc
{
    if(board!=nil)
    {
        [board release]; board=nil;
    }
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

-(void)clear
{
    [board clear:boardColor.r
               g:boardColor.g
               b:boardColor.b
               a:boardColor.a];
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView:touch.view];
    location = [[CCDirector sharedDirector] convertToGL:location];
    if(CGRectContainsPoint(self.boundingBox, location))
    {
        return YES;
    }
    return NO;
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint start  = [touch locationInView:touch.view];
    start = [[CCDirector sharedDirector] convertToGL:start];
    start = [self convertToNodeSpace:start];
    CGPoint end = [touch previousLocationInView:touch.view];
    end = [[CCDirector sharedDirector] convertToGL:end];
    end = [self convertToNodeSpace:end];
    
    [board begin];
    float distance = ccpDistance(start, end);
    if(distance > 1)
    {
        glEnable(GL_LINE_SMOOTH);
        int d = (int)distance;
        for(int i=0; i<d; i++)
        {
            float difx = end.x - start.x;
            float dify = end.y - start.y;
            float delta= (float)i / distance;
            
            glLineWidth(3);
            glColor4ub(brushColor.r, brushColor.g, brushColor.b, brushColor.a);
            ccDrawFilledCircle(ccp(start.x + (difx * delta), 
                                   start.y + (dify * delta)),
                               ccw(self.brushWidth),
                               2*M_PI,
                               10,
                               40);            
            
        }
        glDisable(GL_LINE_SMOOTH);
    }
    [board end];
}
@end
