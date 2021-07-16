//
//  CollectionViewCell.h
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 13.07.2021.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell {
    UIImageView* _entryImageView;
    UILabel* _entryTitleLabel;
}

@property (nonatomic, readonly) UIImageView* entryImageView;
@property (nonatomic, readonly) UILabel* entryTitleLabel;

@property NSString *identifier;

-(void)setEntry:(Entry*)entry;

@end

NS_ASSUME_NONNULL_END
