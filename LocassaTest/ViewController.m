//
//  ViewController.m
//  LocassaTest
//
//  Created by Trevor Doodes on 07/03/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import "ViewController.h"
#import "Box.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)repopulatePressed:(id)sender;
@end

@implementation ViewController {
    
    //Array to hold the boxes to display
    NSMutableArray *_itemsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Populate the collectionView for the first time
    [self setupCollectionViewObjects];
    
    //Reload the collectionView
    [self.collectionView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupCollectionViewObjects {
    
    if (_itemsArray) {
        [_itemsArray removeAllObjects];
    } else {
        _itemsArray = [NSMutableArray array];
    }
    
    //Get random number of boxes for collection view
    //Design decision: Max 30 boxes
    NSInteger numberOfBoxes = arc4random() % 31;
    
    for (int i = 0; i < numberOfBoxes; i++) {
        
        //Create new box
        Box *newBox = [[Box alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        //Add box to box array
        [_itemsArray addObject:newBox];
         
    }
    
    //Reload the collection view
    [self.collectionView reloadData];
    
}

#pragma mark - 
#pragma mark - Action Methods
- (IBAction)repopulatePressed:(id)sender {
    
    //Re-populate the collectionView
    [self setupCollectionViewObjects];
    
}

#pragma mark - 
#pragma mark - UICollectionView Datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    //We only need one section to complete this task
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _itemsArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //Get cell
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"BoxCell" forIndexPath:indexPath];
    
    //Add box to cell
    Box *box = _itemsArray[indexPath.row];
    [cell addSubview:box];
    
    return cell;
    
}
#pragma mark - 
#pragma mark - UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self.collectionView performBatchUpdates:^{
        
        [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:_itemsArray.count -1 inSection:indexPath.section]];
        
        
    } completion:^(BOOL finished) {
        //Update the array to relflect the changes to the collectionView. 
        Box *box = _itemsArray[indexPath.row];
        [_itemsArray removeObjectAtIndex:indexPath.row];
        [_itemsArray addObject:box];
        
    }];
    
    
    [self.collectionView reloadData];
    
    
}


@end
