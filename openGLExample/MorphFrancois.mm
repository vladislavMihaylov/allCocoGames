//
//  Francois.m
//  morphing
//
//  Created by Vlad on 14.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MorphFrancois.h"

#import "MorphGameConfig.h"

@implementation MorphFrancois

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {
        swimmingFrancois = [SwimmingFrancois createWithSpeed: 0];
        runningFrancois = [RunningFrancois createWithSpeed: 0];
        scramblingFrancois = [ScramblingFrancois createWithSpeed: 0];
        goingDownFrancois = [GoingDownFrancois createWithSpeed: 0];
        
        [swimmingFrancois retain];
        swimmingFrancois.tag = kSwimmingAction;
        
        [runningFrancois retain];
        runningFrancois.tag = kRunningAction;
        
        [scramblingFrancois retain];
        scramblingFrancois.tag = kScramblingAction;
        
        [goingDownFrancois retain];
        goingDownFrancois.tag = kGoingDownAction;
        goingDownFrancois.scaleX = -1;
        
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
            [self addChild: runningFrancois];
            currentAction = kRunningAction;
        }
        
        [runningFrancois increaseSpeed];
        currentGroundSpeed = [runningFrancois getCurrentCocoSpeed];
        
    }
    else if(numberOfAction == 1)
    {
        if(currentAction != kSwimmingAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: swimmingFrancois];
            currentAction = kSwimmingAction;
        }
        
        [swimmingFrancois increaseSpeed];
        currentGroundSpeed = [swimmingFrancois getCurrentCocoSpeed];
        
    }
    else if(numberOfAction == 2)
    {
        if(currentAction == kRunningAction)
        {
            ICanJump = NO;
            
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
            [self addChild: scramblingFrancois];
            currentAction = kScramblingAction;
        }
        
        [scramblingFrancois increaseSpeed];
        currentGroundSpeed = [scramblingFrancois getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 4)
    {
        if(currentAction != kGoingDownAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: goingDownFrancois];
            currentAction = kGoingDownAction;
        }
        
        [goingDownFrancois increaseSpeed];
        currentGroundSpeed = [goingDownFrancois getCurrentCocoSpeed];
        
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

+ (MorphFrancois *) createWithSpeed: (float) speed
{
    MorphFrancois *francois = [[[MorphFrancois alloc] initWithSpeed: speed] autorelease];
    
    return francois;
}

@end
