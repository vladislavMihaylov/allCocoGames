//
//  GUILayer.h
//  morphing
//
//  Created by Vlad on 13.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MorphGameLayer;

@interface MorphGUILayer : CCNode
{
    MorphGameLayer *gameLayer;
    
    CCLabelTTF *remainingDistance;
    
    CCSprite *menuBg;
    
    CCLayerColor *pauseLayer;
    
    CCMenuItemImage *runBtn;
    CCMenuItemImage *swimBtn;
    CCMenuItemImage *jumpBtn;
    CCMenuItemImage *scramblBtn;
    CCMenuItemImage *goDownBtn;
    CCMenuItemImage *universalBtn;
    
    NSInteger mistakes;
    
    NSMutableArray *mistakesSpritesArray;
}

- (void) updateDistanceLabel: (NSInteger) distance;
- (void) blockAllButtons;
- (void) unlockAllButtons;
- (void) increaseMistake;
- (void) showGameOverMenu;

@property (nonatomic, assign) MorphGameLayer *gameLayer;

@end
