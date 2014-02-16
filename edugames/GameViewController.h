//
//  GameViewController.h
//  edugames
//
//  Created by Lucy Guo on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "MillionaireViewController.h"
#import <Firebase/Firebase.h>

#define firebaseURL @"https://edugames.firebaseio.com/"


@interface GameViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, strong) Firebase *firebase;
@property (nonatomic, strong) NSDictionary *myGames;
@property (nonatomic, strong) NSArray *gameKeys;

@end
