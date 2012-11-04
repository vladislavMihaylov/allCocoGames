//
//  Francois.h
//  morphing
//
//  Created by Vlad on 14.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AnimationNode.h"

#import "RunningFrancois.h"
#import "SwimmingFrancois.h"
#import "ScramblingFrancois.h"
#import "GoingDownFrancois.h"


@interface MorphFrancois : CCNode
{
    RunningFrancois *runningFrancois;
    SwimmingFrancois *swimmingFrancois;
    ScramblingFrancois *scramblingFrancois;
    GoingDownFrancois *goingDownFrancois;
    
    AnimationNode *body;
    AnimationNode *head;
    AnimationNode *rightHand;
    AnimationNode *leftHand;
    AnimationNode *rightFoot;
    AnimationNode *leftFoot;
    
    NSInteger currentAction;
    float currentGroundSpeed;
}

+ (MorphFrancois *) createWithSpeed: (float) speed;

- (void) doAction: (NSInteger) numberOfAction withSpeed: (float) speed;
- (float) getCurrentGroundSpeed;

@end
