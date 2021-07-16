//
//  EntryListVC.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import "EntryListVC.h"

@interface EntryListVC ()

@property UITableView* tableView;
@property UICollectionView* collectionView;

@end

@implementation EntryListVC

NSString* tableCellID = @"tableViewCell";
NSString* collectionCellID = @"collectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [UITableView new];
    
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 100);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    if ([self.entryNode.value.itemName isEqualToString:@"Main Folder"]) {
        
        [DataFetcher getFileTree:self.entryNode completed:^{
            [self.tableView reloadData];
        }];
    }
    
    [self setTableViewDelegates];
    [self setCollectionViewDelegates];
    
    if (self.layoutType == LayoutTypeTable) {
        [self configureTableView];
    } else {
        [self configureCollectionView];
    }
    
    [self configureNavBarItems];
    
    [self setTitle:self.entryNode.value.itemName];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

// MARK: - tableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entryNode.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tableCellID];
    Entry* entry = ((EntryNode*)self.entryNode.children[indexPath.row]).value;
    [cell setEntry:entry];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryNode *nodeAtPath = (EntryNode*)_entryNode.children[indexPath.row];
    if (nodeAtPath.value.itemType == EntryTypeDirectory) {
        EntryListVC *newEntryListVC = [EntryListVC new];
        newEntryListVC.entryNode = nodeAtPath;
        newEntryListVC.layoutType = self.layoutType;
        
        [self.navigationController pushViewController:newEntryListVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryNode *nodeAtPath = (EntryNode*)self.entryNode.children[indexPath.row];
    return nodeAtPath.value.itemType == EntryTypeDirectory;
}

// MARK: - collectionView methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.entryNode.children.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    Entry* entry = ((EntryNode*)self.entryNode.children[indexPath.row]).value;
    [cell setEntry:entry];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EntryNode *nodeAtPath = (EntryNode*)_entryNode.children[indexPath.row];
    if (nodeAtPath.value.itemType == EntryTypeDirectory) {
        EntryListVC *newEntryListVC = [EntryListVC new];
        newEntryListVC.entryNode = nodeAtPath;
        newEntryListVC.layoutType = self.layoutType;
        
        [self.navigationController pushViewController:newEntryListVC animated:YES];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    EntryNode *nodeAtPath = (EntryNode*)_entryNode.children[indexPath.row];
    return nodeAtPath.value.itemType == EntryTypeDirectory;
}

// MARK: - Configures navigationBar

-(void)configureNavBarItems {
    NSString* navBarImageName = (self.layoutType == LayoutTypeTable ? @"square.grid.2x2.fill" : @"list.bullet");
    UIImage* navBarImage = [UIImage systemImageNamed:navBarImageName];
    UIBarButtonItem* layoutButton = [[UIBarButtonItem alloc] initWithImage:navBarImage style:(UIBarButtonItemStylePlain) target:self action:@selector(changeLayout)];
    
    self.navigationItem.rightBarButtonItem = layoutButton;
}

// MARK: - Toggles layout between tableView and collectionView

-(void)changeLayout {
    if (self.layoutType == LayoutTypeTable) {
        self.layoutType = LayoutTypeCollection;
        [self.tableView removeFromSuperview];
        [self configureCollectionView];
    } else {
        self.layoutType = LayoutTypeTable;
        [self.collectionView removeFromSuperview];
        [self configureTableView];
    }
    [self configureNavBarItems];
}

// MARK: - Configure views

-(void)configureTableView {
    [self.tableView setFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:TableViewCell.class forCellReuseIdentifier:@"tableViewCell"];
    [self.tableView setRowHeight:50];
}

-(void)configureCollectionView {
    [self.collectionView setFrame:self.view.bounds];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:CollectionViewCell.class forCellWithReuseIdentifier:@"collectionViewCell"];
}

// MARK: - SET DELEGATES

-(void)setTableViewDelegates {
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

-(void)setCollectionViewDelegates {
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
}

@end
