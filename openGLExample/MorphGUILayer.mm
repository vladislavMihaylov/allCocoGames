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

#import "MainMenuLayer.h"

@implementation MorphGUILayer

@synthesize gameLayer;

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
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
        
        CCMenuItemFont *runBtn = [CCMenuItemFont itemFromString: @"Run!"
                                                         target: self
                                                       selector: @selector(transmitNumberOfAction:)
                                  ];
        
        runBtn.position = ccp(50, 30);
        runBtn.tag = 0;
        
        CCMenuItemFont *swimBtn = [CCMenuItemFont itemFromString: @"Swim!"
                                                          target: self
                                                        selector: @selector(transmitNumberOfAction:)
                                   ];
        
        swimBtn.position = ccp(130, 30);
        swimBtn.tag = 1;
        
        CCMenuItemFont *jumpBtn = [CCMenuItemFont itemFromString: @"Jump!"
                                                          target: self
                                                        selector: @selector(transmitNumberOfAction:)
                                   ];
        
        jumpBtn.position = ccp(210, 30);
        jumpBtn.tag = 2;
        
        CCMenuItemFont *scramblBtn = [CCMenuItemFont itemFromString: @"Scrambl!"
                                                             target: self
                                                           selector: @selector(transmitNumberOfAction:)
                                      ];
        
        scramblBtn.position = ccp(310, 30);
        scramblBtn.tag = 3;
        
        CCMenuItemFont *goDownBtn = [CCMenuItemFont itemFromString: @"Go down!"
                                                            target: self
                                                          selector: @selector(transmitNumberOfAction:)
                                     ];
        
        goDownBtn.position = ccp(400, 30);
        goDownBtn.tag = 4;
        
        CCMenuItemFont *universalBtn = [CCMenuItemFont itemFromString: @"Action!"
                                                               target: self
                                                             selector: @selector(transmitNumberOfAction:)
                                        ];
        
        universalBtn.position = ccp(240, 280);
        universalBtn.tag = 999;
        
        CCMenu *buttonsMenu = [CCMenu menuWithItems: runBtn, swimBtn, jumpBtn, scramblBtn, goDownBtn, universalBtn, nil];
        buttonsMenu.position = ccp(0,0);
        [self addChild: buttonsMenu];
    }
    
    return self;
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
        playMenuBtn.position = ccp(175, 40);
        restartGameBtn.position = ccp(275, 40);
        
        CCMenu *menu = [CCMenu menuWithItems: exitMenuBtn, playMenuBtn, restartGameBtn, nil];
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
