//
//  DataFetcher.h
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import <Foundation/Foundation.h>
#import "EntryNode.h"
#import <GoogleAPIClientForREST-umbrella.h>
#import <GTMSessionFetcher.h>

//NS_ASSUME_NONNULL_BEGIN

@interface DataFetcher : NSObject

typedef void(^completionBlock)(void);

-(void)getFileTree:(EntryNode*)entryNode completed: (completionBlock)completion;

@end

//NS_ASSUME_NONNULL_END
