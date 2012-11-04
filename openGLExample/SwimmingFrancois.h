//
//  SwimmingFrancois.h
//  morphing
//
//  Created by Vlad on 14.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AnimationNode.h"

@interface SwimmingFrancois : CCNode
{
    AnimationNode *body;
    AnimationNode *head;
    AnimationNode *rightFoot;
    AnimationNode *leftFoot;
    
    float currentSpeed;
}

+ (SwimmingFrancois *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (float) getCurrentCocoSpeed;

@end
