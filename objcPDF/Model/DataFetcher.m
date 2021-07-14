//
//  DataFetcher.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import "DataFetcher.h"

@implementation DataFetcher

// MARK: - Constants

NSString *spreadSheetID = @"1wDg1ZvDxA7nFzUJcl8B9Q5JiyIyny_44xwiOqNhYxZw";
NSString *apiKey = @"AIzaSyDSE21FBc2H_Z-O8kqsHPAYhmGOCypi2wg";
NSString *queryRange = @"PDFexpert!A2:D38";

NSMutableArray *fetchedResponse = nil;

// MARK: - Fetches Google Sheets API data using GoogleAPIClientForREST

-(void) getFileTree:(EntryNode*)entryNode completed:(completionBlock)completion {
    GTLRSheetsService *service = [GTLRSheetsService new];
    service.APIKey = apiKey;
    
    GTLRSheetsQuery_SpreadsheetsValuesGet *query = [GTLRSheetsQuery_SpreadsheetsValuesGet queryWithSpreadsheetId:spreadSheetID range:queryRange];
    
    [service executeQuery:query completionHandler:^(GTLRServiceTicket * _Nonnull callbackTicket, id  _Nullable object, NSError * _Nullable callbackError) {
        if (callbackError != nil) {
            NSLog(@"%@", callbackError.localizedDescription);
        } else {
            GTLRSheets_ValueRange *data = (GTLRSheets_ValueRange*)object;
            fetchedResponse = (NSMutableArray*)data.values;
            [self treeFromJSONResponse:entryNode];
            
            completion();
        }
    }];
}

// MARK: - Builds tree from [[NSString]]
-(void) treeFromJSONResponse:(EntryNode*)entryNode {
    
    while (fetchedResponse.count != 0) {
        NSUInteger fetchedResponseCount = fetchedResponse.count;
        
        for (int i = 0; i < fetchedResponseCount; i++) {
            Entry *childEntry = [Entry new];
            childEntry.selfID = [[NSUUID alloc] initWithUUIDString:fetchedResponse[i][0]];
            
            if ([fetchedResponse[i][1] isEqualToString:@""]) {
                childEntry.parentID = nil;
            } else {
                childEntry.parentID = [[NSUUID alloc] initWithUUIDString:fetchedResponse[i][1]];
            }
            childEntry.itemType = fetchedResponse[i][2];
            childEntry.itemName = fetchedResponse[i][3];
            
            EntryNode *childNode = [EntryNode new];
            childNode.children = [NSMutableArray new];
            childNode.value = childEntry;
            
            EntryNode *parent = [entryNode findParentFor:childNode];
            if (parent != nil) {
                [parent addChild:childNode];
                [fetchedResponse removeObjectAtIndex:i];
                fetchedResponseCount -= 1;
            }
        }
    }
}

@end
