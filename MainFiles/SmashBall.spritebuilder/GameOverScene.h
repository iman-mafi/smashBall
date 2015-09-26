//
//  GameOverScene.h
//  SmashBall
//
//  Created by Viktor Todorov on 12/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCScene.h"
#import "GCHelper.h"
@interface GameOverScene : CCScene {
    CGSize _winSize;
    CCButton *removeAds;
}
+(id) scene;
@end
