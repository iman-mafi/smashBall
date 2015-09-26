//
//  GameOverScene.m
//  SmashBall
//
//  Created by Viktor Todorov on 12/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOverScene.h"
#import "MainMenuScene.h"
#import "Constants.h"
#import "InAppUtils.h"

@implementation GameOverScene
+(id) scene
{
    CCScene *scene = [CCScene node];
    GameOverScene *layer = [GameOverScene node];
    [scene addChild: layer];
    return scene;
}
-(id)init {
    if(self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:[CCDirector sharedDirector] selector:@selector(hideButton) name:IAUtilsProductPurchasedNotification object:nil];
        
        isPurchased = [[NSUserDefaults standardUserDefaults]boolForKey:@"isPurchased"];
        [self addChild:[CCNodeColor nodeWithColor:[CCColor colorWithRed:211.f/255.f green:85.f/255.f blue:87.f/255.f]]];
         _winSize = [[CCDirector sharedDirector]viewSize];
        self.userInteractionEnabled = YES;
        
        CCLabelTTF* gameOver = [CCLabelTTF labelWithString:@"Game Over" fontName:gameFont fontSize:(IPAD?100:50)];
        gameOver.color = [CCColor whiteColor];
        gameOver.position = ccp(_winSize.width/2, _winSize.height/1.2);
        [self addChild:gameOver];
        
        CCButton *againButton = [CCButton buttonWithTitle:@"Again" fontName:gameFont fontSize:(IPAD?50:25)];
        [againButton setTarget:self selector:@selector(playAgain)];
        againButton.color = [CCColor whiteColor];
        againButton.position = ccp(_winSize.width/2, _winSize.height/4);
        [self addChild:againButton];
        
        CCButton *gameCenter = [CCButton buttonWithTitle:@"Game Center" fontName:gameFont fontSize:(IPAD?80:40)];
        [gameCenter setTarget:self selector:@selector(showGameCenter)];
        gameCenter.color = [CCColor whiteColor];
        gameCenter.position = ccp(_winSize.width/2, _winSize.height/6);
        [self addChild:gameCenter];
        
        CCLabelTTF* score = [CCLabelTTF labelWithString:@"" fontName:gameFont fontSize:(IPAD?50:25)];
        score.color = [CCColor whiteColor];
        score.position = ccp(_winSize.width/2, _winSize.height/1.5);
        NSString* scorePoints = [NSString stringWithFormat:@"Score: %li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"score"]];
        score.string = scorePoints;
        [self addChild:score];
        
        if([[NSUserDefaults standardUserDefaults]integerForKey:@"score"] > [[NSUserDefaults standardUserDefaults]integerForKey:@"bestScore"]) {
            [[NSUserDefaults standardUserDefaults]setInteger:[[NSUserDefaults standardUserDefaults]integerForKey:@"score"] forKey:@"bestScore"];
        }
        
        CCLabelTTF* bestScore = [CCLabelTTF labelWithString:@"" fontName:gameFont fontSize:(IPAD?50:25)];
        bestScore.color = [CCColor whiteColor];
        bestScore.position = ccp(_winSize.width/2, _winSize.height/1.8);
        NSString* scorePoints2 = [NSString stringWithFormat:@"Best: %li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"bestScore"]];
        bestScore.string = scorePoints2;
        [self addChild:bestScore];
        
        
        removeAds = [CCButton buttonWithTitle:@"Remove Ads" fontName:gameFont fontSize:(IPAD?30:15)];
        [removeAds setTarget:self selector:@selector(removeAds)];
        removeAds.color = [CCColor whiteColor];
        removeAds.position = ccp(_winSize.width/2-(IPAD?100:50), _winSize.height/2.5);
        
        if(isPurchased == NO) {
            [self addChild:removeAds];
        }
        
        CCButton *restorePurchases = [CCButton buttonWithTitle:@"Restore" fontName:gameFont fontSize:(IPAD?30:15)];
        [restorePurchases setTarget:self selector:@selector(restorePurchasesSel)];
        restorePurchases.color = [CCColor whiteColor];
        restorePurchases.position = ccp(_winSize.width/2+(IPAD?100:50), _winSize.height/2.5);
        [self addChild:restorePurchases];
        
        [[GCHelper defaultHelper] reportScore:[[NSUserDefaults standardUserDefaults]integerForKey:@"bestScore"] forLeaderboardID:gameCenterID];
    }
    return self;
}
-(void)hideButton {
    removeAds.visible = NO;
}
-(void)playAgain {
    [[NSNotificationCenter defaultCenter]removeObserver:[CCDirector sharedDirector]];
    [[CCDirector sharedDirector]replaceScene:[MainMenuScene scene]];
}
-(void)showGameCenter {
    [[GCHelper defaultHelper] showLeaderboardOnViewController:[CCDirector sharedDirector]];
}
-(void)removeAds {
    [[InAppUtils sharedInAppUtils]removeAds:inAppIdentifier];
}
-(void)restorePurchasesSel {
    [[InAppUtils sharedInAppUtils]restorePurchase];
}

@end
