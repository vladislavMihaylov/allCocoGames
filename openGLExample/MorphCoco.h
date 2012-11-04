//
//  Coco.h
//  testApp
//
//  Created by Mac on 30.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AnimationNode.h"

#import "RunningCoco.h"
#import "SwimmingCoco.h"
#import "ScramblingCoco.h"
#import "GoingDownCoco.h"

@interface MorphCoco : CCNode
{
    RunningCoco *runningCoco;
    SwimmingCoco *swimmingCoco;
    ScramblingCoco *scramblingCoco;
    GoingDownCoco *goingDownCoco;
    
    AnimationNode *body;
    AnimationNode *head;
    AnimationNode *rightHand;
    AnimationNode *leftHand;
    AnimationNode *rightFoot;
    AnimationNode *leftFoot;
    
    NSInteger currentAction;
    float currentGroundSpeed;
}

+ (MorphCoco *) createWithSpeed: (float) speed;

- (void) doAction: (NSInteger) numberOfAction withSpeed: (float) speed;
- (float) getCurrentGroundSpeed;
- (void) stopCoco;


@end
