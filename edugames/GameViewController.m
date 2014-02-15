//
//  GameViewController.m
//  edugames
//
//  Created by Lucy Guo on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController {
    NSArray *games;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setItemSize:CGSizeMake(100, 100)];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setCollectionViewLayout:flow];
    
    // Set up games with Firebase
    games = [NSArray arrayWithObject:@"login-button.png"]; // TODO: change icons
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [games count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *gameImageView = [[UIImageView alloc] init];
    [gameImageView setImage:[UIImage imageNamed:[games objectAtIndex:indexPath.row]]];
    gameImageView.frame = CGRectMake(30, 10, 124, 30);
    [cell addSubview:gameImageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: case on games
    //if ([games objectAtIndex:indexPath.row] isEqualToString:@"conqueror") {
        Game* conquerorGame = [[Game alloc] initWithTitle:@"conqueror"];
    //}
    
    [self.collectionView reloadData];
}

/*- (IBAction)presentGCTurnViewController:(id)sender {
    [[GCTurnBasedMatchHelper sharedInstance]
     findMatchWithMinPlayers:2 maxPlayers:3 viewController:self];
}*/

@end
