//
//  Ground.m
//  morphing
//
//  Created by Vlad on 09.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Ground.h"
#import "MorphGameConfig.h"

#import "MorphGUILayer.h"

@implementation Ground

- (void) dealloc
{
    [groundsArray release];
    [groundsToRemove release];
    
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
        groundsArray = [[NSMutableArray alloc] init];
        groundsToRemove = [[NSMutableArray alloc] init];
        
        currentGroundType = kIsGround;
        currentAction = kIsGround;
        direction = kIsHorizontalMove;
        
        isCanAddGroundTexture = NO;
        isTransferGround = NO;
        
        globalCount = 0;
        
        
        for (int i = 0; i < 6; i++)
        {
            ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
            ground.position = ccp(240 + 480 * i, 0);
            [self addChild: ground];
            
            [groundsArray addObject: ground];
        }
        
        [self scheduleUpdate];
    }
    
    return self;
}

+ (Ground *) create
{
    Ground *ground = [[[Ground alloc] init] autorelease];
    
    return ground;
}

- (void) restart
{
    for(CCSprite *currentSprite in groundsArray)
    {
        //[groundsToRemove addObject: currentSprite];
        [self removeChild: currentSprite cleanup: YES];
    }
    
    [groundsArray removeAllObjects];
    
    currentGroundType = 1000;
    currentAction = 1000;
    
    IsMoveDown = NO;
    IsMoveUp = NO;
    IsMoveRight = YES;
    
    globalCount = 0;
    speed = 0;
    
    for (int i = 0; i < 6; i++)
    {
        ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
        ground.position = ccp(240 + 480 * i, 0);
        [self addChild: ground];
        
        [groundsArray addObject: ground];
    }
    
    //for(CCSprite *currentSpriteToRemove in groundsToRemove)
    //{
    //    [groundsArray removeObject: currentSpriteToRemove];
    //}
    
    //[groundsToRemove release];
    
}

- (void) increaseSpeedAnimation: (float) currentSpeed
{
    speed = currentSpeed;
}


- (void) showNewGround: (NSInteger) groundType
{
    //CCLOG(@"groundType: %i", groundType);
    
    ItsNewGround = YES;
    
    if(currentGroundType == kIsGoUpMountain)
    {
        placeForNewSprite = ccp(720 , 160);
    }
    
    firstSpriteOfGround = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", groundType]];
    firstSpriteOfGround.position = placeForNewSprite;
    [self addChild: firstSpriteOfGround z: 1 tag: kFirstSpriteTag];
    
    [groundsArray addObject: firstSpriteOfGround];
    
    //isTransferGround = YES;
}

- (NSInteger) getCurrentDistance
{
    return distance;
}

- (NSInteger) getCurrentActionNumber
{
    return currentAction;
}

- (void) update: (float) dt
{
    if(IsMorphGameActive)
    {
    
        //CCLOG(@"Count groundsArray: %i , count arrayToRemove: %i", groundsArray.count, groundsToRemove.count);
        
        //CCLOG(@"Current ground: %i, Current Action: %i", currentGroundType, currentAction);
        
       /* if(IsMoveUp)
        {
            placeForNewSprite = ccp(480, 480);
        }
        else if(IsMoveRight)
        {
            placeForNewSprite = ccp(720, 0);
        }*/
        
        speed -= 1.5 * dt;
        
        if(speed < 0)
        {
            speed = 0;
        }
        
        distance += speed / 5;
        
        if(distance > 500)
        {
            distance = 0;
            //currentGroundType += 1;
            //[self showNewGround: currentGroundType];
        }
        
        if(speed <= 0)
        {
            speed = 0;
        }
        if(speed > 9)
        {
            speed = 9;
        }
        
        float multiplier = dt * 28 * speed;
        
        time += multiplier;
        
        if(time < 0)
        {
            time = 0;
        }
        
        for(CCSprite *currentSprite in groundsArray)
        {
            if(IsMoveRight)
            {
                currentSprite.position = ccp(currentSprite.position.x - multiplier, currentSprite.position.y);
                
                if(currentSprite.position.x < -240)
                {
                    [groundsToRemove addObject: currentSprite];
                    [self removeChild: currentSprite cleanup: YES];
                }
            }
            if(IsMoveUp)
            {
                currentSprite.position = ccp(currentSprite.position.x, currentSprite.position.y - multiplier);
                
                if(currentSprite.position.y < -160)
                {
                    [groundsToRemove addObject: currentSprite];
                    [self removeChild: currentSprite cleanup: YES];
                }

            }
            if(IsMoveDown)
            {
                currentSprite.position = ccp(currentSprite.position.x, currentSprite.position.y + multiplier);
                
                if(currentSprite.position.y > 480)
                {
                    [groundsToRemove addObject: currentSprite];
                    [self removeChild: currentSprite cleanup: YES];
                }

            }
        }
        
        for(CCSprite *currentSpriteToRemove in groundsToRemove)
        {
            globalCount++;
            
            CCLOG(@"Count: %i", globalCount);
            
            [groundsArray removeObject: currentSpriteToRemove];
            
            if(globalCount % 5 == 0)
            {
                if(globalCount == 35)
                {
                    currentGroundType = 1007;
                    INeedNextAction = YES;
                }
                else
                {
                    currentGroundType++;
                    INeedNextAction = YES;
                }
                
                    for (int i = 1; i < 6; i++)
                    {
                        ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
                        
                        if(currentGroundType == kIsGoUpMountain)
                        {
                            yPositionForSprites = 160;
                            
                            ground.position = ccp(720, yPositionForSprites + (320 * (i-1)));
                        }
                        else if(currentGroundType == kIsRunOnMountain)
                        {
                            yPositionForSprites = 480;
                            
                            ground.position = ccp(480 + 480 * (i - 1), yPositionForSprites);
                        }
                        else if(currentGroundType == kIsGoDownMountain)
                        {
                            yPositionForSprites = 0;
                            
                            ground.position = ccp(720, yPositionForSprites - (320 * (i-1)));
                        }
                        else if(currentGroundType == kIsFinishRun)
                        {
                            yPositionForSprites = -160;
                            
                            ground.position = ccp(240 + 480 * (i - 1), yPositionForSprites);
                        }
                        else if(currentGroundType == 1007)
                        {
                            yPositionForSprites = 160;
                            
                            ground.position = ccp(240 + 480 * i, yPositionForSprites);
                        }
                        else
                        {
                            yPositionForSprites = 0;
                            
                            ground.position = ccp(240 + 480 * i, yPositionForSprites);
                        }
                        
                        [self addChild: ground];
                        
                        [groundsArray addObject: ground];
                    }
                
            }
        }
        
        [groundsToRemove removeAllObjects];
        
        if(INeedNextAction)
        {
            CCSprite *firstSprite = [groundsArray objectAtIndex: 1];
            
            if(IsMoveRight)
            {
                if(currentGroundType == kIsGoDownMountain)
                {
                    xPositionForSprites = 240;
                }
                else
                {
                    xPositionForSprites = 480;
                }
                
                if(firstSprite.position.x < xPositionForSprites)
                {
                    INeedNextAction = NO;
                    
                    if(currentGroundType == 1007)
                    {
                        CCLOG(@"FINISH");
                    }
                    
                    if(currentGroundType == kIsGoDownMountain)
                    {
                        currentAction = 1004;
                        
                        IsMoveRight = NO;
                        IsMoveDown = YES;
                    }
                    else
                    {
                        currentAction++;
                        
                        if(currentGroundType == kIsGoUpMountain)
                        {
                            IsMoveRight = NO;
                            IsMoveUp = YES;
                        }
                    }
                    
                    CCLOG(@"OPA");
                    
                    
                }
            }
            if(IsMoveUp)
            {
                if(firstSprite.position.y < 160)
                {
                    INeedNextAction = NO;
                    currentAction = kIsGround;
                    CCLOG(@"OPA");
                    
                    if(currentGroundType == kIsRunOnMountain)
                    {
                        IsMoveRight = YES;
                        IsMoveUp = NO;
                    }
                }
            }
            if(IsMoveDown)
            {
                if(firstSprite.position.y > 0)
                {
                    INeedNextAction = NO;
                    currentAction = kIsGround;
                    CCLOG(@"OPA");
                    
                    if(currentGroundType == kIsFinishRun)
                    {
                        IsMoveRight = YES;
                        IsMoveDown = NO;
                    }
                }
            }
        }
    }
    
    /*if([self getChildByTag: kFirstSpriteTag])
    {
        if(IsMoveRight)
        {
            //firstSpriteOfGround.position = ccp(firstSpriteOfGround.position.x - multiplier, firstSpriteOfGround.position.y);
        
            if(firstSpriteOfGround.position.x < 480)
            {
                if(ItsNewGround == YES)
                {
                    if(currentGroundType == kIsGoUpMountain)
                    {
                        IsMoveRight = NO;
                        IsMoveDown = NO;
                        IsMoveUp = YES;
                        
                        ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
                        ground.position = ccp(480, 480);
                        [self addChild: ground];
                        
                        [groundsArray addObject: ground];

                    }

                    
                    currentAction++;
                    ItsNewGround = NO;
                    CCLOG(@"Next action");
                }
            }
            
            //if(firstSpriteOfGround.position.x < -240)
            //{
            //    [self removeChildByTag: kFirstSpriteTag cleanup: YES];
            //    CCLOG(@"First sprite deleted");
            //}
        }

        else if (IsMoveUp)
        {
            //firstSpriteOfGround.position = ccp(firstSpriteOfGround.position.x, firstSpriteOfGround.position.y - multiplier);
            
            if(firstSpriteOfGround.position.y < 160)
            {
                if(ItsNewGround == YES)
                {
                    if(currentGroundType == kIsRunOnMountain)
                    {
                        IsMoveRight = YES;
                        IsMoveDown = NO;
                        IsMoveUp = NO;
                        
                        ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
                        ground.scale = 1.5;
                        ground.position = ccp(480, 160);
                        [self addChild: ground];
                        
                        [groundsArray addObject: ground];
                    }
                    
                    
                    currentAction++;
                    ItsNewGround = NO;
                    CCLOG(@"Next action");
                }
            }
            
            //if(firstSpriteOfGround.position.y < -160)
            //{
            //    [self removeChildByTag: kFirstSpriteTag cleanup: YES];
            //    CCLOG(@"First sprite deleted");
            //}
        }

    }
    
            
    
    for(CCSprite *currentSprite in groundsArray)
    {
        if(IsMoveRight == YES)
        {
            currentSprite.position = ccp(currentSprite.position.x - multiplier, currentSprite.position.y);
        }
        else if (IsMoveUp == YES)
        {
            currentSprite.position = ccp(currentSprite.position.x, currentSprite.position.y - multiplier);
        }
        else if (IsMoveDown == YES)
        {
            
        }
        
        if(currentSprite.position.y < -160)
        {
            
            [groundsToRemove addObject: currentSprite];
            [self removeChild: currentSprite cleanup: YES];
        }
        
        if(currentSprite.position.x < -240)
        {
            [groundsToRemove addObject: currentSprite];
            [self removeChild: currentSprite cleanup: YES];
        }
        
    }
    
    for(CCSprite *currentSprite in groundsToRemove)
    {
        [groundsArray removeObject: currentSprite];
        
        if(groundsArray.count < 4)
        {
            ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
            ground.position = placeForNewSprite;
            [self addChild: ground];
            
            [groundsArray addObject: ground];
        }
    }
    
    [groundsToRemove removeAllObjects];*/
    
     /*if([self getChildByTag: kFirstSpriteTag])
    {
        if(currentGroundType != kIsScrambleMountain + 1)
        {
            borderForSprite = -240;
        }
        else
        {
            borderForSprite = 480;
        }
    }
    
    if (firstSpriteOfGround.position.x < borderForSprite)
    {
        if(currentGroundType == kIsScrambleMountain + 1)
        {
            IsMoveUp = YES;
            
            //firstSpriteOfGround.position = ccp(borderForSprite, firstSpriteOfGround.position.y - multiplier);
        }
        else
        {
            [self removeChild: firstSpriteOfGround cleanup: YES];
        }
    }
    
    if(firstSpriteOfGround.position.x < 480 && isTransferGround == YES)
    {
        currentAction += 1;
        isTransferGround = NO;
    }
    
            firstSpriteOfGround.position = ccp(firstSpriteOfGround.position.x - multiplier, firstSpriteOfGround.position.y);
            
            if(firstSpriteOfGround.position.x < 480 && isTransferGround == YES)
            {
                currentAction += 1;
                isTransferGround = NO;
            }
            
            if (firstSpriteOfGround.position.x < borderForSprite)
            {
                if(currentGroundType == kIsScrambleMountain + 1)
                {
                    IsMoveUp = YES;
                                        
                    firstSpriteOfGround.position = ccp(borderForSprite, firstSpriteOfGround.position.y - multiplier);
                }
                else
                {
                    [self removeChild: firstSpriteOfGround cleanup: YES];
                }
            }
        
    }*/
    
    /*for (CCSprite *currentSprite in groundsArray)
    {
        if(IsMoveUp)
        {
            currentSprite.position = ccp(currentSprite.position.x, currentSprite.position.y - multiplier);
            
            if(currentSprite.position.y < -160)
            {
                [groundsToRemove addObject: currentSprite];
                isCanAddGroundTexture = YES;
            }

        }
        else if(IsMoveDown)
        {
            currentSprite.position = ccp(currentSprite.position.x, currentSprite.position.y + multiplier);
            
            if(currentSprite.position.y < -160)
            {
                [groundsToRemove addObject: currentSprite];
                isCanAddGroundTexture = YES;
            }
        }
        else
        {
            currentSprite.position = ccp(currentSprite.position.x - multiplier, currentSprite.position.y);
            
            if(currentSprite.position.x < -240)
            {
                [groundsToRemove addObject: currentSprite];
                isCanAddGroundTexture = YES;
            }
        }
        
        
    }
    
    for (CCSprite *spriteGroundToRemove in groundsToRemove)
    {
        if(isCanAddGroundTexture == YES)
        {
            isCanAddGroundTexture = NO;
            
            ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
            ground.position = placeForNewSprite;
            [self addChild: ground];
            
            [groundsArray addObject: ground];
        }
        
        [self removeChild: spriteGroundToRemove cleanup: YES];
        [groundsArray removeObject: spriteGroundToRemove];
    }
    
    [groundsToRemove removeAllObjects];*/
}



@end
