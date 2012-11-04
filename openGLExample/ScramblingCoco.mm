//
//  JumpingCoco.m
//  morphing
//
//  Created by Vlad on 12.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScramblingCoco.h"


@implementation ScramblingCoco


- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {
        CGPoint positionBody = ccp(240, 240);
        CGPoint anchorBody = ccp(0.5, 0.4);
        NSInteger zBody = 2;
        
        CGPoint positionHead = ccp(25, 85);
        CGPoint anchorHead = ccp(0.5, 0.0);
        
        CGPoint positionRightHand = ccp(25, 65);
        CGPoint anchorRightHand = ccp(0.5, 1.0);
        
        CGPoint positionLeftHand = ccp(25, 65);
        CGPoint anchorLeftHand = ccp(0.5, 1.0);
        
        CGPoint positionRightFoot = ccp(25, 15);
        CGPoint anchorRightFoot = ccp(0.5, 1.0);
        
        CGPoint positionLeftFoot = ccp(25, 15);
        CGPoint anchorLeftFoot = ccp(0.5, 1.0);
        
        body = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"body.png"] position: positionBody anchorPoint: anchorBody andSpeed: speed];
        [body addFrame: AFrame(0, 0)];
        [body addFrame: AFrame(1, 3)];
        [body addFrame: AFrame(2, 0)];
        [body addFrame: AFrame(3, -2)];
        [body addFrame: AFrame(4, 0)];
        
        head = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"head.png"]  position: positionHead anchorPoint: anchorHead andSpeed: speed];
        [head addFrame: AFrame(0, 0)];
        [head addFrame: AFrame(1, 5)];
        [head addFrame: AFrame(2, 0)];
        [head addFrame: AFrame(3, -5)];
        [head addFrame: AFrame(4, 0)];
        
        rightHand = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"rightHand.png"]  position: positionRightHand anchorPoint: anchorRightHand andSpeed: speed];
        [rightHand addFrame: AFrame(0, -75)];
        [rightHand addFrame: AFrame(1, -90)];
        [rightHand addFrame: AFrame(2, -105)];
        [rightHand addFrame: AFrame(3, -90)];
        [rightHand addFrame: AFrame(4, -75)];
        
        leftHand = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"leftHand.png"]  position: positionLeftHand anchorPoint: anchorLeftHand andSpeed: speed];
        [leftHand addFrame: AFrame(0, -105)];
        [leftHand addFrame: AFrame(1, -90)];
        [leftHand addFrame: AFrame(2, -75)];
        [leftHand addFrame: AFrame(3, -90)];
        [leftHand addFrame: AFrame(4, -105)];
        
        rightFoot = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"rightFoot.png"]  position: positionRightFoot anchorPoint: anchorRightFoot andSpeed: speed];
        [rightFoot addFrame: AFrame(0, 0)];
        [rightFoot addFrame: AFrame(1, -15)];
        [rightFoot addFrame: AFrame(2, 0)];
        
        leftFoot = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"leftFoot.png"]  position: positionLeftFoot anchorPoint: anchorLeftFoot andSpeed: speed];
        [leftFoot addFrame: AFrame(0, -15)];
        [leftFoot addFrame: AFrame(1, 0)];
        [leftFoot addFrame: AFrame(2, -15)];
        
        body.position = positionBody;
        head.position = positionHead;
        rightHand.position = positionRightHand;
        leftHand.position = positionLeftHand;
        rightFoot.position = positionRightFoot;
        leftFoot.position = positionLeftFoot;
        
        
        [self addChild: body z: zBody];
        [body addChildToNode: head withZ: 1];
        [body addChildToNode: rightHand withZ: 1];
        [body addChildToNode: leftHand withZ: -1];
        [body addChildToNode: rightFoot withZ: 1];
        [body addChildToNode: leftFoot withZ: -1];
    }
    
    return self;
}

- (void) increaseSpeed
{
    [body increaseSpeedAnimation];
    [head increaseSpeedAnimation];
    [rightHand increaseSpeedAnimation];
    [leftHand increaseSpeedAnimation];
    [rightFoot increaseSpeedAnimation];
    [leftFoot increaseSpeedAnimation];
}

- (float) getCurrentCocoSpeed
{
    currentSpeed = [body getCurrentSpeed];
    //CCLOG(@"currentSpeed = %f", currentSpeed);
    
    return currentSpeed;
    
}

+ (ScramblingCoco *) createWithSpeed: (float) speed
{
    ScramblingCoco *scramblingCoco = [[[ScramblingCoco alloc] initWithSpeed: speed] autorelease];
    
    return scramblingCoco;
}



@end
