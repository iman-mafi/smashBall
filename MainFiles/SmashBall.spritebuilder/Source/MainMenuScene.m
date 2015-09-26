#import "MainMenuScene.h"
#import "GameOverScene.h"
#import "Constants.h"
#import <RevMobAds/RevMobAds.h>


@implementation MainMenuScene
@synthesize bannerView;
+(id) scene
{
    CCScene *scene = [CCScene node];
    MainMenuScene *layer = [MainMenuScene node];
    [scene addChild: layer];
    return scene;
}

-(id)init {
    if(self = [super init]) {
        
        [self addChild:[CCNodeColor nodeWithColor:[CCColor whiteColor]]];
        isPurchased = [[NSUserDefaults standardUserDefaults]boolForKey:@"isPurchased"];
        
        if(isPurchased == NO) {
            [self loadBanner];
            if(enableRevmob == YES) {
                [[RevMobAds session] showFullscreen];
            }
        }

        isTouched = NO;
        isFinished = NO;
        self.userInteractionEnabled = YES;
        
        _winSize = [[CCDirector sharedDirector]viewSize];
        
        _mainBall = [CCSprite spriteWithImageNamed:(IPAD?mainCharacterImageiPad:mainCharacterImage)];
        _mainBall.position = ccp(_winSize.width / 2, _winSize.height / 1.5);
        [self addChild:_mainBall];
        
        _touchArea = [CCSprite spriteWithImageNamed:(IPAD?touchAreaImageIpad:touchAreaImage)];
        _touchArea.position = ccp(0,0);
        _touchArea.userInteractionEnabled = YES;
        [self addChild:_touchArea];

        _squareEnemy1 = [CCSprite spriteWithImageNamed:(IPAD?enemyImageIpad:enemyImage)];
        _squareEnemy1.position = ccp(0+_squareEnemy1.boundingBox.size.width/2, _touchArea.boundingBox.size.height/2 + _squareEnemy1.boundingBox.size.height/2);
        [self addChild:_squareEnemy1];
        
        _squareEnemy2 = [CCSprite spriteWithImageNamed:(IPAD?enemyImageIpad:enemyImage)];
        _squareEnemy2.position = ccp(0+_squareEnemy1.boundingBox.size.width/2, _winSize.height - _squareEnemy1.boundingBox.size.height/2);
        [self addChild:_squareEnemy2];
        
        _squareEnemy3 = [CCSprite spriteWithImageNamed:(IPAD?enemyImageIpad:enemyImage)];
        _squareEnemy3.position = ccp(_winSize.width-_squareEnemy1.boundingBox.size.width/2, _winSize.height - _squareEnemy1.boundingBox.size.height/2);
        [self addChild:_squareEnemy3];
        
        _squareEnemy4 = [CCSprite spriteWithImageNamed:(IPAD?enemyImageIpad:enemyImage)];
        _squareEnemy4.position = ccp(_winSize.width-_squareEnemy1.boundingBox.size.width/2, _touchArea.boundingBox.size.height/2 + _squareEnemy1.boundingBox.size.height/2);
        [self addChild:_squareEnemy4];

        enableMoving = NO;
        
        enemySpeedX = 2;
        enemySpeedY = 1;
        
        enemySpeedX2 = 2;
        enemySpeedY2 = 2;
        
        enemySpeedX3 = 2;
        enemySpeedY3 = 3;
        
        enemySpeedX4 = 2;
        enemySpeedY4 = 1;
        
        _touchToStart = [CCLabelTTF labelWithString:@"Touch To Start" fontName:gameFont fontSize:IPAD?50:25];
        _touchToStart.color = [CCColor whiteColor];
        _touchToStart.position = ccp(_winSize.width/2, _winSize.height/6);
        [self addChild:_touchToStart];
        
        _fingerPrint = [CCSprite spriteWithImageNamed:fingerPrintImage];
        _fingerPrint.position = ccp(_winSize.width/2, _winSize.height / 3.5);
        [self addChild:_fingerPrint];
        
        id moveForward = [CCActionMoveTo actionWithDuration:0.5 position:ccp(_fingerPrint.position.x-10, _fingerPrint.position.y+10)];
        id moveForward2 = [CCActionMoveTo actionWithDuration:0.5 position:ccp(_fingerPrint.position.x+10, _fingerPrint.position.y+10)];
        id moveForward3 = [CCActionMoveTo actionWithDuration:0.5 position:ccp(_fingerPrint.position.x+10, _fingerPrint.position.y-10)];
        id moveForward4 = [CCActionMoveTo actionWithDuration:0.5 position:ccp(_fingerPrint.position.x-10, _fingerPrint.position.y-10)];
        [_fingerPrint runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:moveForward,moveForward2,moveForward3,moveForward4, nil]]];
        
        _pointsLabel = [CCLabelTTF labelWithString:@"" fontName:gameFont fontSize:IPAD?100:50];
        _pointsLabel.color = [CCColor whiteColor];
        _pointsLabel.position = ccp(_winSize.width/2, _winSize.height/5);
        [self addChild:_pointsLabel];
        _pointsLabel.visible = NO;
    }
    return self;
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
   
    oldTouchPoint = [self convertTouchToNodeSpace:touch layer:self];
    enableMoving = YES;
    _touchToStart.visible = NO;
    [_fingerPrint stopAllActions];
    [_fingerPrint setVisible:NO];
    _pointsLabel.visible = YES;
    if(isTouched == NO) {
        [self schedule:@selector(updatePoints) interval:0.5];
        isTouched = YES;
    }
}
-(void)updatePoints {
    points++;
    NSString* points2 = [NSString stringWithFormat:@"%i",points];
    _pointsLabel.string = points2;
}
-(void)update:(CCTime)delta {
    
    if(enableMoving == YES) {
        _squareEnemy1.position = ccp(_squareEnemy1.position.x+enemySpeedX, _squareEnemy1.position.y + enemySpeedY);
        _squareEnemy2.position = ccp(_squareEnemy2.position.x+enemySpeedX2, _squareEnemy2.position.y + enemySpeedY2);
        _squareEnemy3.position = ccp(_squareEnemy3.position.x+enemySpeedX3, _squareEnemy3.position.y + enemySpeedY3);
        _squareEnemy4.position = ccp(_squareEnemy4.position.x+enemySpeedX4, _squareEnemy4.position.y + enemySpeedY4);
        
        if (_squareEnemy1.position.x <= 0+_squareEnemy1.boundingBox.size.width / 2) {
            enemySpeedX = 2;
        }
        if (_squareEnemy1.position.x >= _winSize.width - _squareEnemy1.boundingBox.size.width / 2) {
            enemySpeedX = -3;
        }
        if (_squareEnemy1.position.y <= _touchArea.boundingBox.size.height/2+_squareEnemy1.boundingBox.size.height / 2) {
            enemySpeedY = 3;
        }
        if (_squareEnemy1.position.y >= _winSize.height - _squareEnemy1.boundingBox.size.height / 2) {
            enemySpeedY = -3;
        }
        
        if (_squareEnemy2.position.x <= 0+_squareEnemy2.boundingBox.size.width / 2) {
            enemySpeedX2 = 2;
        }
        if (_squareEnemy2.position.x >= _winSize.width - _squareEnemy2.boundingBox.size.width / 2) {
            enemySpeedX2 = -1;
        }
        if (_squareEnemy2.position.y <= _touchArea.boundingBox.size.height/2+_squareEnemy2.boundingBox.size.height / 2) {
            enemySpeedY2 = 1;
        }
        if (_squareEnemy2.position.y >= _winSize.height - _squareEnemy2.boundingBox.size.height / 2) {
            enemySpeedY2 = -2;
        }

        
        if (_squareEnemy3.position.x <= 0+_squareEnemy3.boundingBox.size.width / 2) {
            enemySpeedX3 = 3;
        }
        if (_squareEnemy3.position.x >= _winSize.width - _squareEnemy3.boundingBox.size.width / 2) {
            enemySpeedX3 = -2;
        }
        if (_squareEnemy3.position.y <= _touchArea.boundingBox.size.height/2+_squareEnemy3.boundingBox.size.height / 2) {
            enemySpeedY3 = 2;
        }
        if (_squareEnemy3.position.y >= _winSize.height - _squareEnemy3.boundingBox.size.height / 2) {
            enemySpeedY3 = -1;
        }

        
        if (_squareEnemy4.position.x <= 0+_squareEnemy4.boundingBox.size.width / 2) {
            enemySpeedX4 = 2;
        }
        if (_squareEnemy4.position.x >= _winSize.width - _squareEnemy4.boundingBox.size.width / 2) {
            enemySpeedX4 = -1;
        }
        if (_squareEnemy4.position.y <= _touchArea.boundingBox.size.height/2+_squareEnemy4.boundingBox.size.height / 2) {
            enemySpeedY4 = 3;
        }
        if (_squareEnemy4.position.y >= _winSize.height - _squareEnemy4.boundingBox.size.height / 2) {
            enemySpeedY4 = -1;
        }
        
        if([self ballsColliding:_mainBall.boundingBox ball2:_squareEnemy1.boundingBox position1:_mainBall.position position2:_squareEnemy1.position] == true) {
            [self gameOverAnimation];
        }
        if([self ballsColliding:_mainBall.boundingBox ball2:_squareEnemy2.boundingBox position1:_mainBall.position position2:_squareEnemy2.position] == true) {
            [self gameOverAnimation];
        }
        if([self ballsColliding:_mainBall.boundingBox ball2:_squareEnemy3.boundingBox position1:_mainBall.position position2:_squareEnemy3.position] == true) {
            [self gameOverAnimation];
        }
        if([self ballsColliding:_mainBall.boundingBox ball2:_squareEnemy4.boundingBox position1:_mainBall.position position2:_squareEnemy4.position] == true) {
            [self gameOverAnimation];
        }
    }
}
-(void)gameOverAnimation {
    [self moveBannerOffScreen];
    enableMoving = NO;
    isFinished = YES;
    [self setUserInteractionEnabled:NO];
    [self unscheduleAllSelectors];
    __block int gameOverCounter = 0;
    id fadeOut = [CCActionFadeOut actionWithDuration:0.4];
    id fadeIn = [CCActionFadeIn actionWithDuration:0.4];
    id block = [CCActionCallBlock actionWithBlock:^{
         gameOverCounter = gameOverCounter + 1;
        if(gameOverCounter == 4) {
            [self saveScore];
            [[CCDirector sharedDirector]replaceScene:[GameOverScene scene]];
        }
    }];
    [_mainBall runAction:[CCActionRepeat actionWithAction:[CCActionSequence actions:fadeOut,fadeIn,block, nil] times:4]];
}
-(void)saveScore {
    [[NSUserDefaults standardUserDefaults]setInteger:points forKey:@"score"];
}
-(bool)ballsColliding:(CGRect)ball1BoundingBox ball2:(CGRect)ball2BoundingBox position1:(CGPoint)position1 position2:(CGPoint)position2 {
    float radius1 = ball1BoundingBox.size.width/2-6;
    float radius2 = ball2BoundingBox.size.width/2;
    float distance = ccpDistance(position1, position2);
    if (distance < (radius1+radius2)) {
        return true;
    }
    else {
        return false;
    }
}
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    
    if(isFinished == NO) {
        CGPoint touchLocation = [self convertTouchToNodeSpace:touch layer:self];
        
        if(CGRectContainsPoint(_touchArea.boundingBox,touchLocation)) {
            CGPoint difference = ccpSub(oldTouchPoint, touchLocation);
            _mainBall.position = ccpSub(_mainBall.position, ccpMult(difference, 1.5));
            oldTouchPoint = touchLocation;
        }
        if (_mainBall.position.x <= 0+_mainBall.boundingBox.size.width / 2) {
            _mainBall.position = ccp(0+_mainBall.boundingBox.size.width / 2,_mainBall.position.y);
        }
        if (_mainBall.position.x >= _winSize.width - _mainBall.boundingBox.size.width / 2) {
            _mainBall.position = ccp(_winSize.width - _mainBall.boundingBox.size.width / 2,_mainBall.position.y);
        }
        if (_mainBall.position.y <= _touchArea.boundingBox.size.height/2+_mainBall.boundingBox.size.height / 2) {
            _mainBall.position = ccp(_mainBall.position.x, _touchArea.boundingBox.size.height/2+_mainBall.boundingBox.size.height / 2);
        }
        if (_mainBall.position.y >= _winSize.height - _mainBall.boundingBox.size.height / 2) {
            _mainBall.position = ccp(_mainBall.position.x, _winSize.height - _mainBall.boundingBox.size.height / 2);
        }
    }
}
- (CGPoint)convertTouchToNodeSpace:(CCTouch *)touch layer:(CCNode*)layer
{
    CGPoint point = [touch locationInView: [touch view]];
    point = [[CCDirector sharedDirector] convertToGL: point];
    return [layer convertToNodeSpace:point];
}
-(void)loadBanner {
    static NSString * const kADBannerViewClass = @"ADBannerView";
    
    if (NSClassFromString(kADBannerViewClass) != nil) {
        
        CGRect adFrame = self.bannerView.frame;
        adFrame.origin.y = [CCDirector sharedDirector].view.frame.size.height-self.bannerView.frame.size.height;
    
        self.bannerView = [[ADBannerView alloc] initWithFrame:adFrame];
        [self.bannerView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
        [self.bannerView setDelegate:self];
        [self.bannerView setFrame:adFrame];
        [[CCDirector sharedDirector].view addSubview:self.bannerView];
        [self moveBannerOnScreen];
    }
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"bannerViewDidLoadAd");
    [self moveBannerOnScreen];
}
-(void) moveBannerOnScreen
{
    CGRect adFrame = self.bannerView.frame;
    adFrame.origin.y = [CCDirector sharedDirector].view.frame.size.height-self.bannerView.frame.size.height;
    [self.bannerView setFrame:adFrame];
}
-(void) moveBannerOffScreen

{
    CGSize windowSize = [[CCDirector sharedDirector] viewSize];
    self.bannerView.frame = CGRectMake(0, (-1) * windowSize.height, 320, 50);
}

@end
