//
//  MainMenuLayer.m
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "GameConfig.h"
#import "GameLayer.h"
#import "SettingsLayer.h"
#import "SimpleAudioEngine.h"

@implementation MainMenuLayer

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    MainMenuLayer *layer = [MainMenuLayer node];
    
    [scene addChild: layer];
    
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
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"bgMusic.mp3" loop: YES];
        
        CCMenuItemFont *play = [CCMenuItemFont itemFromString: @"PLAY" 
                                                       target: self 
                                                     selector: @selector(playGame:)
                                ];
        
        CCMenuItemFont *settings = [CCMenuItemFont itemFromString: @"SETTINGS" 
                                                       target: self 
                                                     selector: @selector(settingsLayer:)
                                ];
        
        play.position = ccp(GameCenterX, GameCenterY);
        settings.position = ccp(GameCenterX, GameCenterY - 100);
        
        CCMenu *mainMenu = [CCMenu menuWithItems: play, settings, nil];
        mainMenu.position = ccp(0,0);
        
        [self addChild: mainMenu];
    }
    return self;
}

- (void) playGame: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [GameLayer scene]]];
}

- (void) settingsLayer: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [SettingsLayer scene]]];
}


@end
