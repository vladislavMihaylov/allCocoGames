//
//  Coco.m
//  testApp
//
//  Created by Mac on 30.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MorphCoco.h"

#import "MorphGameConfig.h"

@implementation MorphCoco

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {
        swimmingCoco = [SwimmingCoco createWithSpeed: 0];
        runningCoco = [RunningCoco createWithSpeed: 0];
        scramblingCoco = [ScramblingCoco createWithSpeed: 0];
        goingDownCoco = [GoingDownCoco createWithSpeed: 0];
        
        [swimmingCoco retain];
        swimmingCoco.tag = kSwimmingAction;
        
        [runningCoco retain];
        runningCoco.tag = kRunningAction;
        
        [scramblingCoco retain];
        scramblingCoco.tag = kScramblingAction;
        
        [goingDownCoco retain];
        goingDownCoco.tag = kGoingDownAction;
        //goingDownCoco.scaleX = -1;
        
        currentGroundSpeed = 0;
    }
    
    return self;
}

- (void) doAction: (NSInteger) numberOfAction withSpeed: (float) speed
{
    if(numberOfAction == 0)
    {
        if(currentAction != kRunningAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: runningCoco];
            currentAction = kRunningAction;
        }
        
        [runningCoco increaseSpeed];
        currentGroundSpeed = [runningCoco getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 1)
    {        
        if(currentAction != kSwimmingAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: swimmingCoco];
            currentAction = kSwimmingAction;
        }
        
        [swimmingCoco increaseSpeed];
        currentGroundSpeed = [swimmingCoco getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 2)
    {
        if(currentAction == kRunningAction)
        {
            ICanJump = NO;
            currentGroundSpeed = 5;//[runningCoco getCurrentCocoSpeed];
            [runningCoco setSpeed: currentGroundSpeed];
            [self runAction: [CCJumpTo actionWithDuration: 0.7 position: self.position height: 50 jumps: 1]];
            [self runAction:
                    [CCSequence actions:
                                [CCDelayTime actionWithDuration: 0.7],
                                [CCCallFunc actionWithTarget: self
                                                    selector: @selector(solveJump)],
                     nil]
             ];
        }
    }
    else if(numberOfAction == 3)
    {
        if(currentAction != kScramblingAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: scramblingCoco];
            currentAction = kScramblingAction;
        }
        
        [scramblingCoco increaseSpeed];
        currentGroundSpeed = [scramblingCoco getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 4)
    {
        if(currentAction != kGoingDownAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: goingDownCoco];
            currentAction = kGoingDownAction;
        }
        
        [goingDownCoco increaseSpeed];
        currentGroundSpeed = [goingDownCoco getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }

}

- (float) getCurrentGroundSpeed
{
    return currentGroundSpeed;
}

- (void) solveJump
{
    ICanJump = YES;
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

- (void) stopCoco
{
    [body setSpeed: 0];
    [head setSpeed: 0];
    [rightHand setSpeed: 0];
    [leftHand setSpeed: 0];
    [rightFoot setSpeed: 0];
    [leftFoot setSpeed: 0];
}


+ (MorphCoco *) createWithSpeed: (float) speed
{
    MorphCoco *coco = [[[MorphCoco alloc] initWithSpeed: speed] autorelease];
    
    return coco;
}

@end
