//
//  HelloWorldLayer.h
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Coco.h"
#import "GUILayer.h"

#import "Box2D.h"
#import "GLES-Render.h"



@class Fish;
@class Coco;

@interface GameLayer : CCLayer
{
    GUILayer *gui;
    
    Coco *coco;
    
    b2World *world;
    b2Body *groundBody;
    GLESDebugDraw *m_debugDraw;
    
    b2Body *DNIWE;
    b2BodyDef DNIWEDef;
    b2PolygonShape DNIWEShape;
    b2FixtureDef DNIWEFixture;
    
    b2Body *leftWall;
    b2BodyDef leftWallDef;
    b2PolygonShape leftWallShape;
    b2FixtureDef leftWallFixture;
    
    b2Body *rightWall;
    b2BodyDef rightWallDef;
    b2PolygonShape rightWallShape;
    b2FixtureDef rightWallFixture;
    
    b2Body *ceiling;
    b2BodyDef ceilingDef;
    b2PolygonShape ceilingShape;
    b2FixtureDef ceilingFixture;
    
    b2Body *fishBody;
    b2BodyDef fishDef;
    b2PolygonShape fishShape;
    b2FixtureDef fishFixture;
    
    
    b2RevoluteJoint *_revolJoint;
    
   
    CCSprite *curFish;
    CCSprite *waveBack;
    CCSprite *waveFront;
    CCSprite *bubblesSprite;
    
    NSInteger score;
    NSInteger time;
    NSInteger fishCount;
    NSInteger waveBackSpeed;
    NSInteger waveFrontSpeed;
    
    float intervalForFishSpawn;
    float waveBackOffSetX;
    float waveFrontOffSetX;
    
    NSMutableArray *fishesArray;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

- (void) spawnFish;
- (void) removeFish: (Fish *) currentFish;
- (void) updateIntervalForFishSpawn;

- (void) startGame;
- (void) doPauseGame;
- (void) unPauseGame;

@property (nonatomic, assign) CGPoint pos; 
@property (nonatomic, assign) GUILayer *guiLayer;

@end
