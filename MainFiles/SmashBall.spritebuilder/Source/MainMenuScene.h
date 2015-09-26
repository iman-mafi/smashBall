//
//  GameOverScene.h
//  SmashBall
//
//  Created by Viktor Todorov on 12/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCScene.h"
#import "GCHelper.h"
#import <iAd/iAd.h>

@interface MainMenuScene : CCScene <ADBannerViewDelegate> {
    
    ADBannerView *bannerView;

    
    CCSprite* _mainBall;
    CCSprite* _squareEnemy1;
    CCSprite* _squareEnemy2;
    CCSprite* _squareEnemy3;
    CCSprite* _squareEnemy4;
    CCSprite* _touchArea;
    CCSprite* _fingerPrint;
    
    CCLabelTTF* _touchToStart;
    CCLabelTTF* _pointsLabel;
    
    CGSize _winSize;
    CGPoint oldTouchPoint;
    BOOL enableMoving;
    BOOL isTouched;
    BOOL isFinished;
    int enemySpeedX;
    int enemySpeedY;
    
    int enemySpeedX2;
    int enemySpeedY2;
    
    int enemySpeedX3;
    int enemySpeedY3;
    
    int enemySpeedX4;
    int enemySpeedY4;
    int points;
}
@property (nonatomic,retain) ADBannerView *bannerView;

+(id) scene;
@end
