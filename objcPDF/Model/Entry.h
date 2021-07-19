//
//  Entry.h
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EntryType) {
    EntryTypeDirectory,
    EntryTypeFile
};

@interface Entry : NSObject

@property (nonatomic) NSUUID *selfID;
@property (nonatomic) NSUUID *parentID;
@property (nonatomic) EntryType itemType;
@property (nonatomic) NSString *itemName;

-(instancetype)initWithSelfID:(NSString*)selfID parentID:(NSString*)parentID itemType:(NSString*)itemType itemName:(NSString*)itemName;

-(instancetype)initWithArray:(NSArray<NSString*>*)array;

@end

//NS_ASSUME_NONNULL_END
