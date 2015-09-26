//
//  UserDefaultsUtils.m
//  AlexGame
//
//  Created by Aleksandar Angelov on 8/11/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import "UserDefaultsUtils.h"

@implementation UserDefaultsUtils
+(id)sharedUserDefaultsUtils {
    static UserDefaultsUtils *sharedUserDefaultsUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserDefaultsUtils = [[self alloc] init];
    });
    return sharedUserDefaultsUtils;
}
-(void)setHighscore:(int)score{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int highscore = (int)[userDefaults integerForKey:@"highscore"];
    if (score > highscore) {
        [userDefaults setInteger:score forKey:@"highscore"];
        [userDefaults synchronize];
    }
}
-(int)highscore{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int highscore = (int)[userDefaults integerForKey:@"highscore"];
    return  highscore;
}
-(void)setMusic:(bool)state{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:state forKey:@"music"];
    [userDefaults synchronize];
}
-(bool)musicOn{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL musicOn = [userDefaults boolForKey:@"music"];
    return musicOn;
}
-(int)adsCounter{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return (int)[userDefaults integerForKey:@"adsCounter"];
}
-(void)incrementAdsCounter:(int)maxValue{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int adsCounter = [self adsCounter];
    if (adsCounter >= maxValue-1) {
        adsCounter = 0;
    }
    else {
        adsCounter++;
    }
    [userDefaults setInteger:adsCounter forKey:@"adsCounter"];
    [userDefaults synchronize];
}
-(void)setPurchased:(bool)purchased_{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:purchased_ forKey:@"purchased"];
    [userDefaults synchronize];
}
-(bool)purchased{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    bool purchased = [userDefaults boolForKey:@"purchased"];
    return purchased;
}
@end
