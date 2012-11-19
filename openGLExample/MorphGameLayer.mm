//
//  MyCocos2DClass.m
//  morphing
//
//  Created by Vlad on 09.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MorphGameLayer.h"
#import "MorphGameConfig.h"
#import "GameConfig.h"


@implementation MorphGameLayer

@synthesize guiLayer;

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    MorphGameLayer *layer = [MorphGameLayer node];
    
    MorphGUILayer *gui = [MorphGUILayer node];
    
    [scene addChild: layer];

    [scene addChild: gui];
    
    layer.guiLayer = gui;
    gui.gameLayer = layer;
        
    return scene;
}

- (void) dealloc
{
    [super dealloc];
}

- (void) finishGame
{
    [coco stopAllActions];
    [coco pauseAll];
    [guiLayer showGameOverMenu];
}

- (void) showAnimationOfTransition
{
    
    CCLOG(@"actNum %i", [ground getCurrentActionNumber]);
    [guiLayer blockAllButtons];
    
    
        
    //if(curAction == 1001)
    //{
    [self reorderChild: coco z: -2];
    
    if(curAction >= 1003)
    {
        [self reorderChild: coco z: 10];
    }
    
    [coco rotate: curAction andCurrentGround: [ground getCurrentActionNumber]];

    
    [ground increaseSpeedAnimation: 7];
    
    NSInteger delayTime;
    
    //CCLOG(@"currebtGround %i", currentGround );
    
    if(curAction == 1002 || [ground getCurrentActionNumber] == 1004 || [ground getCurrentActionNumber] == 1005 )
    {
        delayTime = 0;
    }
    else
    {
        delayTime = 2;
    }
    
    [coco runAction: [CCSequence actions:
                            [CCDelayTime actionWithDuration: delayTime],
                            [CCCallFunc actionWithTarget: self
                                                selector: @selector(doNextAction)], nil]];

}

- (void) hideCoco
{
    [coco hideCoco];
}

- (void) doNextAction
{
    //[coco hideCoco];
    
    //CCLOG(@"curAction: %i curGround: %i", curAction, currentGround);
    [guiLayer showCurrentActionLabel: curAction];
    
    if(curAction == 1002)
    {
        [self fuckingJump]; //[self doAction: 1002];
        [coco stopCoco];
    }
    if(curAction == 1000)// && currentGround == kIsRunOnMountain)
    {
        [self runGround];
    }
    if(curAction == 1004)
    {
        [coco setPosition: ccp(coco.position.x, coco.position.y + 40)];
    }
    //if()
    
    [coco doAction: curAction - 1000 withSpeed: currentSpeed];
    [guiLayer unlockAllButtons];
}

- (id) init
{
    if (self = [super init])
    {
        IsMorphGameActive = YES;
        
        IsMoveRight = YES;
        IsMoveUp = NO;
        IsMoveDown = NO;
        
        CCSprite *back = [CCSprite spriteWithFile: @"allBack.png"];
        back.position = ccp(240, 160);
        [self addChild: back z: -50];
                
        /*[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"backgroundSprites.plist"];
        
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode
                                          batchNodeWithFile:@"backgroundSprites.png"];
        [self addChild:spriteSheet z: -50];
        
        CCSprite *backgroundSprite = [CCSprite spriteWithSpriteFrameName:@"background.png"];
        backgroundSprite.position = ccp(240, 160);
        [spriteSheet addChild: backgroundSprite];
        
        CCSprite *farTrees = [CCSprite spriteWithSpriteFrameName: @"farTrees.png"];
        farTrees.position = ccp(240, 160);
        [spriteSheet addChild: farTrees];
        
        CCSprite *trees = [CCSprite spriteWithSpriteFrameName: @"trees.png"];
        trees.position = ccp(240, 120);
        [spriteSheet addChild: trees];

        CCSprite *bushes = [CCSprite spriteWithSpriteFrameName: @"bushes.png"];
        bushes.position = ccp(240, 110);
        [spriteSheet addChild: bushes];*/

                
        ground = [Ground create];
        ground.gameLayer = self;
        [self addChild: ground z: 0];
        
        if(typeCharacter == 0)
        {
            coco = [MorphCoco createWithSpeed: currentSpeed];
            [self addChild: coco z: 1];
            
            //coco.scale = 0.3;
            coco.position =ccp(0, 0);
            
            [coco doAction: 0 withSpeed: 0];
            
            coco.gameLayer = self;
        }
        else if(typeCharacter == 1)
        {
            francois = [MorphFrancois createWithSpeed: currentSpeed];
            [self addChild: francois];
            
            francois.scale = 0.3;
            francois.position =ccp(100, 105);
            
            [francois doAction: 0 withSpeed: 0];
        }
        
        leftDistance = [CCLabelTTF labelWithString: @"" fontName: @"Arial" fontSize: 14];
        leftDistance.position = ccp(240, 160);
        //[leftDistance retain];
        [self addChild: leftDistance];

        
        currentSpeed = 0;
        
        // Buttons 
        
        [guiLayer showCurrentActionLabel: 1000];
        
        [self scheduleUpdate];
    }
    
    return self;
}

- (void) restartGame
{
    [guiLayer showCurrentActionLabel: 1000];
    //[self removeChild: ground cleanup: YES];
    [ground restart];
    
    if(typeCharacter == 0)
    {
        //[coco doAction: 0 withSpeed: 0];
        [self removeChild: coco cleanup: YES];
        currentSpeed = 0;
        curAction = 1000;
        
        coco = [MorphCoco createWithSpeed: currentSpeed];
        [self addChild: coco];
        
        //coco.scale = 0.3;
        coco.position = ccp(0,0);//ccp(100, 105);
        
        [coco doAction: 0 withSpeed: 0];

    }
    if(typeCharacter == 1)
    {
        [francois doAction: 0 withSpeed: 0];
    }
    
}

- (void) runGround
{
    [coco doAction: 0 withSpeed: 7];
    [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];

}

- (void) fuckingJump
{
    if(typeCharacter == 0)
    {
        
        [coco doAction: 0 withSpeed: 7];//currentSpeed];
        [coco doAction: 1002 withSpeed: 7]; //currentSpeed];
        [ground increaseSpeedAnimation: 7];//[coco getCurrentGroundSpeed]];
    }
    else if(typeCharacter == 1)
    {
        [francois doAction: 0 withSpeed: currentSpeed];
        [francois doAction: 1002 withSpeed: currentSpeed];
        [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];
        
    }

}

- (void) doAction: (NSInteger) numberOfAction
{
    //CCLOG(@"Current Action: %i", curAction);
    
    if(numberOfAction == 999)
    {
        //[coco doAction: 4 withSpeed: currentSpeed];
        
        if(curAction == 1001)
        {
            [self reorderChild: coco z: -10];
        }
        else
        {
            [self reorderChild: coco z: 1];
        }
        
        if(curAction == 1002)
        {
            if(ICanJump)
            {
                //currentSpeed = 5.5;
                
                if(typeCharacter == 0)
                {
                    
                    [coco doAction: 0 withSpeed: currentSpeed];
                    [coco doAction: 2 withSpeed: currentSpeed];
                    [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];
                }
                else if(typeCharacter == 1)
                {
                    [francois doAction: 0 withSpeed: currentSpeed];
                    [francois doAction: 2 withSpeed: currentSpeed];
                    [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];
                    
                }
            }
            
        }
        else
        {
            currentSpeed += 0.5;
            
            if(typeCharacter == 0)
            {
                [coco doAction: curAction - 1000 withSpeed: currentSpeed];
                [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];
                
            }
            else if(typeCharacter == 1)
            {
                [francois doAction: curAction - 1000 withSpeed: currentSpeed];
                [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];
                
            }
        }
    }
    
    if (curAction != 1002)
    {
        if ((curAction - 1000) != numberOfAction)
        {
            if(CurrentDifficulty == 2)
            {
                CCLOG(@"PZDC!!!");
                [guiLayer increaseMistake];
            }
        }
        else
        {
            currentSpeed += 0.5;
            
            if(typeCharacter == 0)
            {
                if(numberOfAction == 1)
                {
                    [self reorderChild: coco z: -10];
                }
                else
                {
                    [self reorderChild: coco z: 1];
                }
                [coco doAction: numberOfAction withSpeed: currentSpeed];
                [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];

            }
            else if(typeCharacter == 1)
            {
                [francois doAction: numberOfAction withSpeed: currentSpeed];
                [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];

            }
        }
    }
    else if(curAction == 1002)
    {
        if ((curAction - 1000) != numberOfAction)
        {
            if(CurrentDifficulty == 2)
            {
            CCLOG(@"PZDC!!!");
                [guiLayer increaseMistake];
            }
        }
        else
        {
            if(ICanJump)
            {
                //currentSpeed = 5.5;
                
                if(typeCharacter == 0)
                {
                    
                    [coco doAction: 0 withSpeed: currentSpeed];
                    [coco doAction: numberOfAction withSpeed: currentSpeed];
                    [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];
                }
                else if(typeCharacter == 1)
                {
                    [francois doAction: 0 withSpeed: currentSpeed];
                    [francois doAction: numberOfAction withSpeed: currentSpeed];
                    [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];

                }
            }
        }
    }
}


- (void) update: (float) dt
{
    curAction = [ground getCurrentActionNumber];
    
    //[guiLayer updateDistanceLabel: 500 - [ground getCurrentDistance]];
    
    currentSpeed -= 1.5 * dt;
    
    
    
    if(currentSpeed <= 0)
    {
        currentSpeed = 0;
    }
    if(currentSpeed > 9)
    {
        currentSpeed = 9;
    }
}

@end
