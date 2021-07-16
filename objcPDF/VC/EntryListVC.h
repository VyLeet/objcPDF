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
#import "Entry.h"


typedef NS_ENUM(NSUInteger, LayoutType) {
    LayoutTypeTable,
    LayoutTypeCollection
};

@interface EntryListVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property EntryNode* entryNode;
@property LayoutType layoutType;

@end

