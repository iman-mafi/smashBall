//
//  AudioUtils.m
//  AlexGame
//
//  Created by Aleksandar Angelov on 8/11/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import "AudioUtils.h"

@implementation AudioUtils
@synthesize audioEngine;
#pragma mark - Initialization -
+(id)sharedAudioUtils {
    static AudioUtils *sharedAudioUtils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAudioUtils = [[self alloc] init];
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio preloadBg:@""];
        [audio preloadEffect:@""];
        [audio preloadEffect:@""];
        [audio preloadEffect:@""];
        [audio preloadEffect:@""];
        [sharedAudioUtils setAudioEngine:audio];
    });
    return sharedAudioUtils;
}
-(void)playBackgroundMusic{
    if ([[UserDefaultsUtils sharedUserDefaultsUtils]musicOn]) {
        if (![audioEngine bgPlaying]) {
            [audioEngine playBg:@"" loop:YES];
        }
    }
}
-(void)stopBackgroundMusic{
    [audioEngine stopBg];
}
-(void)playClickSound{
    if ([[UserDefaultsUtils sharedUserDefaultsUtils] musicOn]) {
        [audioEngine playEffect:@""];
    }
}
-(void)playErrorSound{
    if ([[UserDefaultsUtils sharedUserDefaultsUtils] musicOn]) {
        [audioEngine playEffect:@""];
    }
}
-(void)playTapSound{
    if ([[UserDefaultsUtils sharedUserDefaultsUtils] musicOn]) {
        [audioEngine playEffect:@""];
    }
}
-(void)playHitSound{
    if ([[UserDefaultsUtils sharedUserDefaultsUtils] musicOn]) {
        [audioEngine playEffect:@""];
    }
}

@end
