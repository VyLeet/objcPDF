//
//  EntryNode.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import "EntryNode.h"

@interface EntryNode()

@property (readonly) NSMutableArray<EntryNode*>* mutableChildren;

@end

@implementation EntryNode

-(NSArray<EntryNode *> *)children {
    return self.mutableChildren;
}

/// Caches key for a future use, nil UUID (Main Folder) gets empty string
/// @param baseNSUUID – NSUUID to convert
+(NSString*)nonNilStringFromUUID:(NSUUID*)baseNSUUID {
    NSString* stringRepresentation = baseNSUUID.UUIDString;
    if (!stringRepresentation) {
        stringRepresentation = @"";
    }
    
    return stringRepresentation;
}

/// Adds children to a node
/// @param arrayOfChildren – children nodes to add
-(void)addChildren:(NSMutableArray<EntryNode*>*)arrayOfChildren {
    [self.mutableChildren addObjectsFromArray:arrayOfChildren];
}

/// Grows the entryNode tree from dictionary
/// @param dictionary – key: parentID;  value: array of nodes
-(void)growTreeFromDictionary:(NSMutableDictionary*)dictionary {
    // Caches key for a future use
    NSString* dictionaryKey = [EntryNode nonNilStringFromUUID:self.value.selfID];
    
    // Adds children for current node
    NSMutableArray* nodeChildren = [dictionary objectForKey:dictionaryKey];
    [self addChildren:nodeChildren];
    
    // Recursively calls function again
    for (int i = 0; i < self.children.count; i++) {
        if (self.children[i].value.itemType == EntryTypeDirectory) {
            [self.children[i] growTreeFromDictionary:dictionary];
        }
    }
}

// MARK: - Initializers

-(instancetype)initWithEntry:(Entry *)entry {
    
    if (self = [super init]) {
        _value = entry;
        _mutableChildren = [NSMutableArray new];
    }
    
    return self;
}

-(instancetype)init {
    if (self = [self initWithEntry:nil]) { }
    
    return self;
}

@end
