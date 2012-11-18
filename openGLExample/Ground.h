//
//  Ground.h
//  morphing
//
//  Created by Vlad on 09.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MorphGameLayer;

@interface Ground: CCNode
{
    MorphGameLayer *gameLayer;
    
    CCSprite *ground;
    CCSprite *firstSpriteOfGround;
    
    NSMutableArray *groundsArray;
    NSMutableArray *groundsToRemove;
    
    NSInteger currentAction;
    NSInteger borderForSprite;
    NSInteger direction;
    
    float time;                         // Счетчик времени
    NSInteger nextFrameNumber;          // Номер следующего кадра
    
    float speed;                        // Скорость анимации
        
    NSInteger currentGroundType;
    NSInteger globalCount;
        
    //float distance;

    BOOL isCanAddGroundTexture;
    BOOL isTransferGround;
    
    CGPoint placeForNewSprite;
    
    NSInteger yPositionForSprites;
    NSInteger xPositionForSprites;
}

+ (Ground *) create;

- (void) restart;

- (void) increaseSpeedAnimation: (float) speed;
//- (NSInteger) getCurrentDistance;
- (NSInteger) getCurrentActionNumber;
- (void) showNewGround: (NSInteger) groundType;

@property (nonatomic, assign) MorphGameLayer *gameLayer;


@end
