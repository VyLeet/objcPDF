//
//  Entry.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import "Entry.h"

@implementation Entry

-(instancetype)initWithSelfID:(NSString *)selfID parentID:(NSString *)parentID itemType:(NSString *)itemType itemName:(NSString *)itemName {
    if (self = [super init]) {
        _selfID = [[NSUUID alloc] initWithUUIDString:selfID];
        if ([parentID length] > 0) {
            _parentID = [[NSUUID alloc] initWithUUIDString:parentID];
        }
        if ([itemType isEqualToString:@"d"]) {
            _itemType = EntryTypeDirectory;
        } else {
            _itemType = EntryTypeFile;
        }
        _itemName = itemName;
    }
    
    return self;
}

-(instancetype)initWithArray:(NSArray<NSString *>*)array {
    if ((self = [super init]) && array.count == 4) {
        _selfID = [[NSUUID alloc] initWithUUIDString:array[0]];
        if ([array[1] length] > 0) {
            _parentID = [[NSUUID alloc] initWithUUIDString:array[1]];
        }
        
        if ([array[2] isEqualToString:@"d"]) {
            _itemType = EntryTypeDirectory;
        } else {
            _itemType = EntryTypeFile;
        }
        _itemName = array[3];
    }
    
    return self;
}

@end
