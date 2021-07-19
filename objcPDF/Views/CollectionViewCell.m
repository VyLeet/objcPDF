//
//  CollectionViewCell.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 13.07.2021.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (nonatomic) UIImageView* entryImageView;
@property (nonatomic) UILabel* entryTitleLabel;

@end

@implementation CollectionViewCell

// MARK: - Requiered initWithFrame override

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _entryImageView = [UIImageView new];
        _entryTitleLabel = [UILabel new];
        
        [self.contentView addSubview:self.entryImageView];
        [self.contentView addSubview:self.entryTitleLabel];
        
        [self configureImageView];
        [self configureTitleLabel];
    }
    
    return self;
}

// MARK: - Sets data for the cell

-(void)setEntry:(Entry *)entry {
    NSString* imageName = (entry.itemType == EntryTypeDirectory) ? @"folder.fill" : @"doc.richtext.fill";
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
    
    [self setImageViewConstraints];
    [self setTitleLabelConstraints];
}

// MARK: - Sets constraints for the entryImageView

-(void)setImageViewConstraints {
    self.entryImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
            [self.entryImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [self.entryImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12],
            [self.entryImageView.heightAnchor constraintEqualToConstant:80],
            [self.entryImageView.widthAnchor constraintEqualToAnchor:self.entryImageView.heightAnchor]
    ]];
}

// MARK: - Sets constraints for the entryTitleLabel

-(void)setTitleLabelConstraints {
    self.entryTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.entryTitleLabel.centerYAnchor constraintEqualToAnchor:self.entryImageView.centerYAnchor],
        [self.entryTitleLabel.leadingAnchor constraintEqualToAnchor:self.entryImageView.leadingAnchor],
        [self.entryTitleLabel.heightAnchor constraintEqualToConstant:30],
        [self.entryTitleLabel.topAnchor constraintEqualToAnchor:self.entryImageView.centerYAnchor constant:40],
        [self.entryTitleLabel.trailingAnchor constraintEqualToAnchor:self.entryImageView.trailingAnchor]
    ]];
}

@end
