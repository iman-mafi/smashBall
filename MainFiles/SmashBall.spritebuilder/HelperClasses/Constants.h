//
//  Constants.h
//  CirclePong
//
//  Created by Aleksandar Angelov on 15/12/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

//Game Font
static NSString* gameFont = @"Futura-CondensedExtraBold";

//Your Game Center ID which you generate from iTunes Connect
static NSString* gameCenterID = @"Your Game Center ID HERE";

//Your IN-APP Purchase ID -> created in iTunes Connect
static NSString* inAppIdentifier = @"Your IN-App Purchase ID";

//Enable REVMOB Ads
static BOOL enableRevmob = YES;
//You RevMob ID
static NSString* revMobID = @"5106be9d0639b41100000052";


//Graphics

//Main Character - iPhone
static NSString* mainCharacterImage = @"mainBallImage.png";
//Main Character - iPad
static NSString* mainCharacterImageiPad = @"mainBallImageiPad.png";

//Enemy - iPhone
static NSString* enemyImage = @"enemyImg.png";
//Enemy - iPad
static NSString* enemyImageIpad = @"enemyImgiPad.png";

//Touch Area Background - iPhone
static NSString* touchAreaImage = @"touchArea.png";
//Touch Area Background - iPad
static NSString* touchAreaImageIpad = @"touchAreaiPad.png";

//FingerPrint
static NSString* fingerPrintImage = @"Fingerprint.png";

//DO NOT EDIT !!!
BOOL isPurchased;
#define IPAD     UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad