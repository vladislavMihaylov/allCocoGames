//
//  MyCocos2DClass.h
//  morphing
//
//  Created by Vlad on 09.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Ground.h"
#import "MorphCoco.h"
#import "MorphFrancois.h"

#import "MorphGUILayer.h"

@interface MorphGameLayer: CCNode
{
    MorphGUILayer *gui;
    
    Ground *ground;
    MorphCoco *coco;
    MorphFrancois *francois;
    
    float currentSpeed;
    NSInteger currentGround;
    NSInteger curAction;
        
    CCLabelTTF *leftDistance;
}

+ (CCScene *) scene;

- (void) restartGame;
- (void) showAnimationOfTransition;
- (void) finishGame;

- (void) doAction: (NSInteger) numberOfAction;

@property (nonatomic, assign) MorphGUILayer *guiLayer;

@end
