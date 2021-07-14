//
//  Entry.h
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 12.07.2021.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface Entry : NSObject

@property NSUUID *selfID;
@property NSUUID *parentID;
@property NSString *itemType;
@property NSString *itemName;

@end

//NS_ASSUME_NONNULL_END
