//
//  SelectGameLayer.m
//  openGLExample
//
//  Created by Mac on 05.08.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectGameLayer.h"
#import "CocoGameLayer.h"
#import "MainMenuLayer.h"
#import "GameConfig.h"
#import "GameLayer.h"


@implementation SelectGameLayer

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    SelectGameLayer *selectLayer = [SelectGameLayer node];
    
    [scene addChild: selectLayer];
    
    return scene;
}

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if((self = [super init]))
    {
        CCSprite *bgSprite = [CCSprite spriteWithFile: @"settingsBg.jpg"];
        bgSprite.position = ccp(GameCenterX, GameCenterY);
        [self addChild: bgSprite];
        
        labelSprite = [CCSprite spriteWithFile: @"selectGameLogo.png"];
        labelSprite.position = ccp(GameCenterX, GameHeight - 50);
        [self addChild: labelSprite];
        
        CCMenuItemImage *fishingGame = [CCMenuItemImage itemFromNormalImage: @"cocoFishingPlayBtn.png" 
                                                              selectedImage: @"cocoFishingPlayBtnTap.png"
                                                                     target: self 
                                                                   selector: @selector(playFishingGame:)];
        
        CCMenuItemImage *catchCocoGame = [CCMenuItemImage itemFromNormalImage: @"catchCocoPlayBtn.png" 
                                                                selectedImage: @"catchCocoPlayBtnTap.png"
                                                                       target: self 
                                                                     selector: @selector(playCatchCocoGame:)];
        
        CCMenuItemImage *BackToMainMenu = [CCMenuItemImage itemFromNormalImage: @"backBtn.png" 
                                                                 selectedImage: @"backBtnOn.png"
                                                                        target: self 
                                                                      selector: @selector(goToMainMenu:)];
        
        
        fishingGame.position = ccp(GameCenterX, GameCenterY + 40);
        catchCocoGame.position = ccp(GameCenterX, GameCenterY - 80);
        BackToMainMenu.position = ccp(GameWidth * 0.04, GameHeight * 0.05);
        
        selectGameMenu = [CCMenu menuWithItems: fishingGame, catchCocoGame, BackToMainMenu, nil];
        selectGameMenu.position = ccp(0,0);
        selectGameMenu.scale = 0.8;
        [self addChild: selectGameMenu];
    }
    
    return self;
}

- (void) playFishingGame: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [GameLayer scene]]];
}

- (void) playCatchCocoGame: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [CocoGameLayer scene]]];
}

- (void) goToMainMenu: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [MainMenuLayer scene]]];
}

@end
