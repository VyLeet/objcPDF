//
//  EntryNode.h
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

//NS_ASSUME_NONNULL_BEGIN

@interface EntryNode : NSObject

@property Entry *value;
@property (weak) EntryNode *parent;
@property (readonly) NSArray<EntryNode*>* children;

-(void)addChildren:(NSMutableArray<EntryNode*>*)arrayOfChildren;

-(void)growTreeFromDictionary:(NSMutableDictionary*)dictionary;

+(NSString*)nonNilStringFromUUID:(NSUUID*)baseNSUUID;

-(instancetype)initWithEntry:(Entry*)entry;

@end

//NS_ASSUME_NONNULL_END
