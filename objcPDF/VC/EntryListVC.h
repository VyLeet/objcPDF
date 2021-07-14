//
//  EntryListVC.h
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import <UIKit/UIKit.h>
#import "EntryNode.h"
#import "Entry.h"
#import "DataFetcher.h"
#import "TableViewCell.h"
#import "CollectionViewCell.h"

@interface EntryListVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property UITableView *tableView;
@property UICollectionView *collectionView;
@property EntryNode *entryNode;

@property NSString *layoutType;
@property UICollectionViewFlowLayout* layout;


@end

