//
//  UserDefaultsUtils.h
//  AlexGame
//
//  Created by Aleksandar Angelov on 8/11/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

+(id)sharedUserDefaultsUtils;

-(void)setHighscore:(int)score;

-(int)highscore;

-(void)setMusic:(bool)state;

-(bool)musicOn;

-(int)adsCounter;

-(void)incrementAdsCounter:(int)maxValue;

-(void)setPurchased:(bool)purchased_;

-(bool)purchased;

@end
