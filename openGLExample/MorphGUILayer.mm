//
//  GUILayer.m
//  morphing
//
//  Created by Vlad on 13.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MorphGUILayer.h"
#import "MorphGameConfig.h"
#import "MorphGameLayer.h"
#import "MorphMainMenu.h"
#import "GameConfig.h"
#import "MainMenuLayer.h"

@implementation MorphGUILayer

@synthesize gameLayer;

- (void) dealloc
{
    [mistakesSpritesArray release];
    
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
        mistakes = 0;
        
        mistakesSpritesArray = [[NSMutableArray alloc] init];
        
        CCMenuItemImage *pauseBtn = [CCMenuItemImage itemFromNormalImage: @"pauseBtn.png"
                                                           selectedImage: @"pauseBtn.png"
                                                                  target: self
                                                                selector: @selector(showPauseMenu)
                                     ];
        
        pauseBtn.position = ccp(440, 280);
        pauseBtn.scale = 0.65;
        
        
        CCMenu *guiMenu = [CCMenu menuWithItems: pauseBtn, nil];
        guiMenu.position = ccp(0,0);
        
        [self addChild: guiMenu];
        
        /////////////////////////////
        
        remainingDistance = [CCLabelTTF labelWithString: @"" fontName: @"Arial" fontSize: 16];
        remainingDistance.position = ccp(240, 240);
        [self addChild: remainingDistance];
        
        runBtn = [CCMenuItemImage itemFromNormalImage: @"runBtn.png" selectedImage: @"runBtnOn.png"
                                                         target: self
                                                       selector: @selector(transmitNumberOfAction:)
                                  ];
        
        runBtn.position = ccp(50, 50);
        runBtn.tag = 0;
        
        swimBtn = [CCMenuItemImage itemFromNormalImage: @"swimBtn.png" selectedImage: @"swimBtnOn.png"
                                                          target: self
                                                        selector: @selector(transmitNumberOfAction:)
                                   ];
        
        swimBtn.position = ccp(145, 50);
        swimBtn.tag = 1;
        
        jumpBtn = [CCMenuItemImage itemFromNormalImage: @"jumpBtn.png" selectedImage: @"jumpBtnOn.png"
                                                          target: self
                                                        selector: @selector(transmitNumberOfAction:)
                                   ];
        
        jumpBtn.position = ccp(240, 50);
        jumpBtn.tag = 2;
        
        scramblBtn = [CCMenuItemImage itemFromNormalImage: @"upBtn.png" selectedImage: @"upBtnOn.png"
                                                             target: self
                                                           selector: @selector(transmitNumberOfAction:)
                                      ];
        
        scramblBtn.position = ccp(335, 50);
        scramblBtn.tag = 3;
        
        goDownBtn = [CCMenuItemImage itemFromNormalImage: @"downBtn.png" selectedImage: @"downBtnOn.png"
                                                            target: self
                                                          selector: @selector(transmitNumberOfAction:)
                                     ];
        
        goDownBtn.position = ccp(430, 50);
        goDownBtn.tag = 4;
        
        universalBtn = [CCMenuItemImage itemFromNormalImage: @"universalBtn.png" selectedImage: @"universalBtnOn.png"
                                                               target: self
                                                             selector: @selector(transmitNumberOfAction:)
                                        ];
        
        universalBtn.position = ccp(380, 50);
        universalBtn.tag = 999;
        universalBtn.scale = 0.7;
        
        if(CurrentDifficulty == 0)
        {
        
        CCMenu *buttonsMenu = [CCMenu menuWithItems: universalBtn, nil];
            buttonsMenu.position = ccp(0,0);
            [self addChild: buttonsMenu];
        }
        if(CurrentDifficulty == 1 || CurrentDifficulty == 2)
        {
            
            CCMenu *buttonsMenu = [CCMenu menuWithItems: runBtn, swimBtn, jumpBtn, scramblBtn, goDownBtn, nil];
            buttonsMenu.position = ccp(0,0);
            [self addChild: buttonsMenu];
        }
        
        currentActionLabel = [CCLabelBMFont labelWithString: @"" fntFile: @"font20.fnt"];
        currentActionLabel.position = ccp(240, 160);
        [currentActionLabel setOpacity: 0];
        [self addChild: currentActionLabel z: 20];
        
    }
    
    return self;
}

- (void) showCurrentActionLabel:(NSInteger)numb
{
    if(IsMorphGameActive == YES)
    {
        id spawnAction = [CCSpawn actions: [CCFadeTo actionWithDuration: 2 opacity: 255],
                          [CCScaleTo actionWithDuration: 2 scale: 1.5],
                          nil];
        
        id spawnActionTwo = [CCSpawn actions: [CCFadeTo actionWithDuration: 2 opacity: 0],
                             [CCScaleTo actionWithDuration: 2 scale: 1],
                             nil];

        
        if(numb == 1000)
        {
            currentActionLabel.string = @"Run, Coco! Run!";
        }
        if(numb == 1001)
        {
            currentActionLabel.string = @"Swim!!! Faster!!!";
        }
        if(numb == 1002)
        {
            currentActionLabel.string = @"Jump!!! Up!!!";
        }
        if(numb == 1003)
        {
            currentActionLabel.string = @"Scramble!!! Up!!!";
        }
        if(numb == 1004)
        {
            currentActionLabel.string = @"Get down!!!";
        }
        
        [currentActionLabel runAction:
                                    [CCSequence actions:
                                                spawnAction, spawnActionTwo,
                                     nil]];
    }
}

- (void) increaseMistake
{
    mistakes++;
    
    CCSprite *mistakeSprite = [CCSprite spriteWithFile: @"mistake.png"];
    mistakeSprite.position = ccp(35 * mistakes - 10 , 290);
    mistakeSprite.scale = 0.2;
    [self addChild: mistakeSprite];
    
    [mistakesSpritesArray addObject: mistakeSprite];
    
    if(mistakes == 3)
    {
        [self removeAllMistakeSprites];
        mistakes = 0;
        [self showGameOverMenu];
    }
}

- (void) removeAllMistakeSprites
{
    for(CCSprite *curMistSprite in mistakesSpritesArray)
    {
        [self removeChild: curMistSprite cleanup: YES];
    }
    
    [mistakesSpritesArray removeAllObjects];
}

- (void) blockAllButtons
{
    if(CurrentDifficulty == 1 || CurrentDifficulty == 2)
    {
    runBtn.isEnabled = NO;
    swimBtn.isEnabled = NO;
    jumpBtn.isEnabled = NO;
    scramblBtn.isEnabled = NO;
    goDownBtn.isEnabled = NO;
    }
    else if(CurrentDifficulty == 0)
    {
    universalBtn.isEnabled = NO;
    }
}

- (void) unlockAllButtons
{
    if(CurrentDifficulty == 1 || CurrentDifficulty == 2)
    {
    runBtn.isEnabled = YES;
    swimBtn.isEnabled = YES;
    jumpBtn.isEnabled = YES;
    scramblBtn.isEnabled = YES;
    goDownBtn.isEnabled = YES;
    }
    else if(CurrentDifficulty == 0)
    {
    universalBtn.isEnabled = YES;
    }

}

- (void) showPauseMenu
{
    if(IsMorphGameActive)
    {
        IsMorphGameActive = NO;
        
        pauseLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 200)];
        pauseLayer.position = ccp(0,0);
        [self addChild: pauseLayer];
        
        menuBg = [CCSprite spriteWithFile: @"pauseMenuBg.png"];
        menuBg.position = ccp(240, 480);
        [self addChild: menuBg];
        
        
        CCMenuItemImage *playMenuBtn = [CCMenuItemImage itemFromNormalImage: @"playBtn.png"
                                                              selectedImage: @"playBtn.png"
                                                                      block: ^(id sender) {
                                                                          IsMorphGameActive = YES;
                                                                          [self removeChild: menuBg cleanup: YES];
                                                                          [self removeChild: pauseLayer cleanup: YES];
                                                                      }
                                        ];
        
        CCMenuItemImage *exitMenuBtn = [CCMenuItemImage itemFromNormalImage: @"exitBtn.png"
                                                              selectedImage: @"exitBtn.png"
                                                                      block: ^(id sender) {
                                                                          [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [MainMenuLayer scene]]];
                                                                      }
                                        ];
        
        CCMenuItemImage *restartGameBtn = [CCMenuItemImage itemFromNormalImage: @"replayBtn.png"
                                                                 selectedImage: @"replayBtn.png"
                                                                        target: self
                                                                      selector: @selector(restartGame)
                                           ];
        
        exitMenuBtn.position = ccp(75, 40);
        playMenuBtn.position = ccp(275, 40);
        restartGameBtn.position = ccp(175, 40);
        
        CCMenu *menu = [CCMenu menuWithItems: exitMenuBtn, playMenuBtn, restartGameBtn, nil];
        menu.position = ccp(0,0);
        
        [menuBg addChild: menu];
        
        
        [menuBg runAction: [CCEaseBackInOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: ccp(240, 160)] ]];
    }
}

- (void) showGameOverMenu
{
    if(IsMorphGameActive)
    {
        IsMorphGameActive = NO;
        
        pauseLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 200)];
        pauseLayer.position = ccp(0,0);
        [self addChild: pauseLayer];
        
        menuBg = [CCSprite spriteWithFile: @"pauseMenuBg.png"];
        menuBg.position = ccp(240, 480);
        [self addChild: menuBg];

        
        CCMenuItemImage *exitMenuBtn = [CCMenuItemImage itemFromNormalImage: @"exitBtn.png"
                                                              selectedImage: @"exitBtn.png"
                                                                      block: ^(id sender) {
                                                                          [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [MainMenuLayer scene]]];
                                                                      }
                                        ];
        
        CCMenuItemImage *restartGameBtn = [CCMenuItemImage itemFromNormalImage: @"replayBtn.png"
                                                                 selectedImage: @"replayBtn.png"
                                                                        target: self
                                                                      selector: @selector(restartGame)
                                           ];
        
        exitMenuBtn.position = ccp(120, 40);
        restartGameBtn.position = ccp(240, 40);
        
        CCMenu *menu = [CCMenu menuWithItems: exitMenuBtn, restartGameBtn, nil];
        menu.position = ccp(0,0);
        
        [menuBg addChild: menu];
        
        
        [menuBg runAction: [CCEaseBackInOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: ccp(240, 160)] ]];
    }
}

- (void) restartGame
{
    IsMorphGameActive = YES;
    
    [gameLayer restartGame];
    [self removeChild: menuBg cleanup: YES];
    [self removeChild: pauseLayer cleanup: YES];
}

- (void) updateDistanceLabel: (NSInteger) distance
{
    //remainingDistance.string = [NSString stringWithFormat: @"Remaining distance: %i", distance];
}

- (void) transmitNumberOfAction: (CCMenuItemFont *) sender
{
    [gameLayer doAction: sender.tag];
}

@end
