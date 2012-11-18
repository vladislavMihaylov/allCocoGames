

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AnimationNode.h"

@interface RunningCoco : CCNode 
{
    AnimationNode *body;
    AnimationNode *head;
    AnimationNode *tail;
    AnimationNode *rightHandUp;
    AnimationNode *rightHandDown;
    AnimationNode *leftHandUp;
    AnimationNode *leftHandDown;
    AnimationNode *rightFootUp;
    AnimationNode *rightFootMiddle;
    AnimationNode *rightFootDown;
    AnimationNode *leftFootUp;
    AnimationNode *leftFootMiddle;
    AnimationNode *leftFootDown;
    
    float currentSpeed;
}

+ (RunningCoco *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (void) setSpeed: (float) speedParam;
- (float) getCurrentCocoSpeed;
- (void) showTransitionAnimation;
- (void) setNormalOrientation;
- (void) doUnvisible;
- (void) doVisible;
- (void) hide;
- (void) show;
- (void) jumpFromMountain;
- (void) setLastYPosition;




@end
