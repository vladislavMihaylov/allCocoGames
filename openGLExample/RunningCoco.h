

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AnimationNode.h"

@interface RunningCoco : CCNode 
{
    AnimationNode *body;
    AnimationNode *head;
    AnimationNode *rightHand;
    AnimationNode *leftHand;
    AnimationNode *rightFoot;
    AnimationNode *leftFoot;
    
    float currentSpeed;
}

+ (RunningCoco *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (void) setSpeed: (float) speedParam;
- (float) getCurrentCocoSpeed;

@end
