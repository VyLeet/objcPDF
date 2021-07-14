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
@property NSMutableArray *children;

-(void)addChild:(EntryNode*)node;
-(EntryNode*)findParentFor:(EntryNode*)entryNode;

@end

//NS_ASSUME_NONNULL_END
