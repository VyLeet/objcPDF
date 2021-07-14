//
//  EntryNode.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import "EntryNode.h"

@implementation EntryNode

// MARK: - Adds child to a node

-(void)addChild:(EntryNode*)node {
    [self.children addObject:node];
    node.parent = self;
}

// MARK: - Finds a parent for a node using NSUUID. Otherwise returns nil

-(EntryNode*)findParentFor:(EntryNode*)entryNode {
    NSUUID* parentID = entryNode.value.parentID;
    
    EntryNode* foundParent = nil;
    
    if (parentID == nil || [parentID isEqual:self.value.selfID]) {
        foundParent = self;
    } else {
        for (EntryNode* child in self.children) {
            foundParent = [child findParentFor:entryNode];
            if (foundParent != nil) {
                return foundParent;
            }
        }
    }
    
    return foundParent;
}

@end
