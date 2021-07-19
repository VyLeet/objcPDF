//
//  DataFetcher.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import "DataFetcher.h"

@implementation DataFetcher

// MARK: - Constants

static NSString* const spreadSheetID = @"1wDg1ZvDxA7nFzUJcl8B9Q5JiyIyny_44xwiOqNhYxZw";
static NSString* const apiKey = @"AIzaSyDSE21FBc2H_Z-O8kqsHPAYhmGOCypi2wg";
static NSString* const queryRange = @"PDFexpert!A2:D38";

NSMutableArray<NSArray<NSString*>*>* fetchedResponse = nil;

// MARK: - Fetches Google Sheets API data using GoogleAPIClientForREST

+(void) getFileTree:(EntryNode*)entryNode completed:(CompletionBlock)completion {
    GTLRSheetsService *service = [GTLRSheetsService new];
    service.APIKey = apiKey;
    
    GTLRSheetsQuery_SpreadsheetsValuesGet *query = [GTLRSheetsQuery_SpreadsheetsValuesGet queryWithSpreadsheetId:spreadSheetID range:queryRange];
    
    [service executeQuery:query completionHandler:^(GTLRServiceTicket * _Nonnull callbackTicket, id  _Nullable object, NSError * _Nullable callbackError) {
        if (callbackError != nil) {
            NSLog(@"%@", callbackError.localizedDescription);
        } else {
            GTLRSheets_ValueRange *data = (GTLRSheets_ValueRange*)object;
            fetchedResponse = [data.values mutableCopy];
            
            NSMutableDictionary* dictionary = [self dictionaryFromResponse];
            [entryNode growTreeFromDictionary:dictionary];
            
            completion();
        }
    }];
}

// MARK: - Converts fetchedResponse NSArray into NSDictionary
/// Key: parentID;  Value: array of children nodes
+(NSMutableDictionary*) dictionaryFromResponse {
    NSMutableDictionary* dictionary = [NSMutableDictionary new];
    
    for (NSArray<NSString*>* array in fetchedResponse) {
        @autoreleasepool {
            Entry* childEntry = [[Entry alloc] initWithArray:array];
            EntryNode* childEntryNode = [[EntryNode alloc] initWithEntry:childEntry];
            
            NSString* dictionaryKey = [EntryNode nonNilStringFromUUID:childEntry.parentID];
            
            if (dictionary[dictionaryKey]) {
                [dictionary[dictionaryKey] addObject:childEntryNode];
            } else {
                NSMutableArray<EntryNode*>* nodeArray = [NSMutableArray new];
                [nodeArray addObject:childEntryNode];
                [dictionary setObject:nodeArray forKey:dictionaryKey];
            }
        }
    }
    
    return dictionary;
}

@end
