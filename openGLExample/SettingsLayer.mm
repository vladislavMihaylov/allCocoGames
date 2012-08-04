//
//  SettingsLayer.m
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsLayer.h"
#import "GameConfig.h"
#import "MainMenuLayer.h"

@implementation SettingsLayer

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    SettingsLayer *layer = [SettingsLayer node];
    
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
        CCLabelTTF *settingsLabel = [CCLabelTTF labelWithString: @"Settings layer" fontName: @"Arial" fontSize: 32];
        settingsLabel.position = ccp(GameCenterX, GameCenterY);
        [self addChild: settingsLabel];
        
        CCMenuItemFont *backInMenu = [CCMenuItemFont itemFromString: @"Menu"
                                                             target: self 
                                                           selector: @selector(backInMenu:)
                                      ];
        
        backInMenu.position = ccp(GameCenterX, GameCenterY - 100);
        
        CCMenu *settingsMenu = [CCMenu menuWithItems: backInMenu, nil];
        settingsMenu.position = ccp(0,0);
        [self addChild: settingsMenu];
        
    }
    
    return self;
}

- (void) backInMenu: (id) sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [MainMenuLayer scene]]];
}

@end
