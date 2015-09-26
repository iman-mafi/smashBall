//
//  AudioUtils.h
//  AlexGame
//
//  Created by Aleksandar Angelov on 8/11/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDefaultsUtils.h"
#import "ObjectAL.h"
@interface AudioUtils : NSObject
@property(nonatomic,assign) OALSimpleAudio *audioEngine;

+(id)sharedAudioUtils;
-(void)playBackgroundMusic;
-(void)stopBackgroundMusic;
-(void)playClickSound;
-(void)playErrorSound;
-(void)playTapSound;
-(void)playHitSound;

@end
