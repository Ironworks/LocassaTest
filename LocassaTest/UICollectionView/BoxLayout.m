//
//  BoxLayout.m
//  LocassaTest
//
//  Created by Trevor Doodes on 07/03/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import "BoxLayout.h"

static NSString * const BoxCellKind = @"BoxCell";

@interface BoxLayout ()

//CollectionView item size
@property (nonatomic) CGSize itemSize;

//Horizontal spacing between CollectionView items
@property (nonatomic) CGFloat interItemSpacingX;

//Vertical spacing between CollectionView items
@property (nonatomic) CGFloat interItemSpacingY;

//NSDictionary to cache the layout info
@property (nonatomic,strong) NSDictionary *layoutInfo;

@end

@implementation BoxLayout

//Override init methods to setup initial values
-(instancetype)init {
    
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

//Setup initial values
-(void)setup {
    
    self.itemSize = CGSizeMake(100.0, 100.0);
    self.interItemSpacingX = 10.0;
    self.interItemSpacingY = 10.0;
    
}

#pragma mark -
#pragma mark - Layout
-(void)prepareLayout {
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForBoxAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[BoxCellKind] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;

}

- (NSInteger)numberOfColumns {
    
    //Get max number of cells per row.
    
    //Calculate number of columns without separating space
    NSInteger initialNumbeOfColumns = self.collectionView.bounds.size.width / self.itemSize.width;
    
    //Calculate the number of spaces required based in initial number of columns
    NSInteger numberOfSpaces = initialNumbeOfColumns - 1;
    
    //Adjust the width to take account of spacing
    CGFloat adjustedWidth = self.collectionView.bounds.size.width - (numberOfSpaces * self.interItemSpacingX);
    
    //Return adjusted number of columns
    return adjustedWidth / self.itemSize.width;
    
    
}

- (CGRect)frameForBoxAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger numberOfColumns = [self numberOfColumns];

    
    NSLog(@"Number of colums: %ld", numberOfColumns);
    
    NSInteger row = indexPath.row / numberOfColumns;
    NSInteger column;
    if (row == 0) {
        column = indexPath.row;
    } else {
        column = indexPath.row - (numberOfColumns * row);
    }
    
    
    CGFloat originX = floorf((self.itemSize.width + self.interItemSpacingX) * column);
    CGFloat originY = floor ((self.itemSize.height + self.interItemSpacingY) * row);
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementInfo,
                                                         BOOL *stop) {
        [elementInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                         UICollectionViewLayoutAttributes *attributes,
                                                         BOOL *stop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutInfo[BoxCellKind][indexPath];
}

-(CGSize)collectionViewContentSize {
    
    NSInteger numberOfColumns = [self numberOfColumns];
    NSInteger rowCount = [self.collectionView numberOfItemsInSection:0] / numberOfColumns;
    //Make sure you count another row if one is partially filled
    if (rowCount % numberOfColumns != 0) {
        rowCount++;
    }
    CGFloat height = rowCount * (self.itemSize.height + self.interItemSpacingY);
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
    
}


@end
