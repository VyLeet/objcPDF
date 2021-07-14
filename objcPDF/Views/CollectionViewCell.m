//
//  CollectionViewCell.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 13.07.2021.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

// MARK: - Requiered initWithFrame override

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.entryImageView = [UIImageView new];
        self.entryTitleLabel = [UILabel new];
        
        [self.contentView addSubview:self.entryImageView];
        [self.contentView addSubview:self.entryTitleLabel];
        
        [self configureImageView];
        [self configureTitleLabel];
    }
    
    return self;
}

// MARK: - Sets data for the cell

-(void)setEntry:(Entry *)entry {
    NSString* imageName = ([entry.itemType isEqualToString:@"d"]) ? @"folder.fill" : @"doc.richtext.fill";
    UIImage* entryImage = [UIImage systemImageNamed:imageName];
    [self.entryImageView setImage:entryImage];
    self.entryTitleLabel.text = entry.itemName;
}

// MARK: - Configures the entryImageView

-(void)configureImageView {
    self.entryImageView.contentMode = UIViewContentModeScaleAspectFit;
}

// MARK: - Configures the entryTitleLabel

-(void)configureTitleLabel {
    self.entryTitleLabel.numberOfLines = 0;
    self.entryTitleLabel.adjustsFontSizeToFitWidth = YES;
    [self.entryTitleLabel setTextAlignment:NSTextAlignmentCenter];
}

// MARK: - layoutSubviews override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.entryTitleLabel.frame = CGRectMake(5, self.contentView.frame.size.height - 50, self.contentView.frame.size.width - 10, 50);
    self.entryImageView.frame = CGRectMake(5, 0, self.contentView.frame.size.width - 10, self.contentView.frame.size.height - 50);
}

@end
