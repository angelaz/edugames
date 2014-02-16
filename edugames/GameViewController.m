//
//  GameViewController.m
//  edugames
//
//  Created by Lucy Guo on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//


#import "GameViewController.h"
#import "ConquerViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Set up games with Firebase
        self.firebase = [[Firebase alloc] initWithUrl:firebaseURL];
        
        
        //  TODO: Need to populate this properly with teacher's games.
        //  Would be nice if teacher games could be stored with format [Title, Image Name, Game ID] (or if necessary we can
        //    have numbers that correspond to different game templates and associate those)
        /*myGames = [[NSMutableArray alloc] initWithObjects:@[@"Simple Addition", @1, @12345], @[@"Chapter 1 History", @2, @12345], @[@"Hydrogen Facts", @3, @12345], @[@"Millionaire Test", @0, @1342], nil];*/
    }
    return self;
}

//  Collection view methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    Firebase* gamesRef = [self.firebase childByAppendingPath:@"games"];
    [gamesRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
         self.myGames = snapshot.value;
         self.gameKeys = self.myGames.allKeys;
        [_collectionView reloadData];
    }];
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20); //  Top, left, bottom, right
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height-100, frame.size.width)  collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1.0]];
    
    [self.view addSubview:_collectionView];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.gameKeys count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"card-millionaire.png"]];
    
    //  TODO: This is temporary before we associate either image names directly or use IDs for templates
    /*if ([[[myGames objectAtIndex:indexPath.row] objectAtIndex:1] isEqual:@2]) {
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"card-millionaire-alt.png"]];
    }*/
    
    UILabel *gameNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, 280, 25)];
    gameNameLabel.text = self.myGames[[self.gameKeys objectAtIndex:indexPath.row]][@"title"];
    gameNameLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:gameNameLabel];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //MillionaireViewController *mvc = [[MillionaireViewController alloc] initWithNibName:nil bundle:nil];
    //[self presentViewController:mvc animated:YES completion:nil];
    
    //[self.navigationController pushViewController:mvc animated:YES];
    
    // TODO: case on games
    NSString* key = [self.gameKeys objectAtIndex:indexPath.row];
    NSDictionary* game = self.myGames[key];
    
    if ([game[@"template"] isEqualToString:@"conqueror"]) {
        
        ConquerViewController *conquerViewController = [[ConquerViewController alloc] initWithKey:key andGameInfo:game];
        [self.navigationController presentViewController:conquerViewController animated:YES completion:nil];
    }
    
    /*NSLog(@"%@", [[myGames objectAtIndex:indexPath.row] objectAtIndex:1]);
    if ([[[myGames objectAtIndex:indexPath.row] objectAtIndex:1] isEqual:@0]) {
        MillionaireViewController *mvc = [[MillionaireViewController alloc] init];
        //[self presentViewController:mvc animated:YES completion:nil];
        //[self.navigationController presentViewController:mvc animated:YES completion:nil];
    }
    
    
    // TODO: what is this?*/
    [collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(280, 325);
}

/*

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentGCTurnViewController:(id)sender
{
    [[GCTurnBasedMatchHelper sharedInstance]
     findMatchWithMinPlayers:2 maxPlayers:3 viewController:self];
}*/

@end
