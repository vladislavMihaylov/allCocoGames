//
//  GameConfig.h
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

#define PTM_RATIO 32
#define ptm2cc(a)           ((a) * PTM_RATIO)
#define cc2ptm(a)           ((a) / PTM_RATIO)
#define cc2ptmVec2(x, y)    (b2Vec2(cc2ptm(x), cc2ptm(y)))

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

//
// Define here the type of autorotation that you want for your game
//

// 3rd generation and newer devices: Rotate using UIViewController. Rotation should be supported on iPad apps.
// TIP:
// To improve the performance, you should set this value to "kGameAutorotationNone" or "kGameAutorotationCCDirector"
#if defined(__ARM_NEON__) || TARGET_IPHONE_SIMULATOR
#define GAME_AUTOROTATION kGameAutorotationUIViewController

// ARMv6 (1st and 2nd generation devices): Don't rotate. It is very expensive
#elif __arm__
#define GAME_AUTOROTATION kGameAutorotationNone


// Ignore this value on Mac
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)

#else
#error(unknown architecture)
#endif

#define kZBackGroundPic  0
#define kZWaveBack       1
#define kZWaveFront      2

#define GameWidth  480
#define GameHeight 320

#define kMaxScoreKey @"maxScoreKey"

extern float GameCenterX;
extern float GameCenterY;

extern BOOL IsHookActive;
extern BOOL IsFishCauth;
extern BOOL IsGameActive;
extern BOOL IsCanSpawnFish;
extern BOOL IsRestartGame; 

#endif // __GAME_CONFIG_H

