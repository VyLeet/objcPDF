//
//  TableViewCell.h
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 13.07.2021.
//

#import <UIKit/UIKit.h>
#import "Entry.h"


@interface TableViewCell : UITableViewCell

@property (nonatomic) UIImageView *entryImageView;
@property (nonatomic) UILabel *entryTitleLabel;
@property NSString *identifier;

-(void)setEntry:(Entry*)entry;

@end

