//
//  TableViewCell.m
//  objcPDF
//
//  Created by Nazariy Vysokinskyi on 13.07.2021.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@property (nonatomic) UIImageView* entryImageView;
@property (nonatomic) UILabel* entryTitleLabel;

@end

@implementation TableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

// MARK: - Requiered initWithStyle override

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _entryImageView = [UIImageView new];
        _entryTitleLabel = [UILabel new];
        
        [self.contentView addSubview:self.entryImageView];
        [self.contentView addSubview:self.entryTitleLabel];
        
        [self configureTitleLabel];
        
        [self setImageViewConstraints];
        [self setTitleLabelConstraints];
    }
    return self;
}

// MARK: - Sets data for the cell

-(void)setEntry:(Entry *)entry {
    NSString* imageName = (entry.itemType == EntryTypeDirectory) ? @"folder.fill" : @"doc.richtext.fill";
    UIImage* entryImage = [UIImage systemImageNamed:imageName];
    [self.entryImageView setImage:entryImage];
    [self.entryTitleLabel setText:entry.itemName];
}

// MARK: - Configures the entryTitleLabel

-(void)configureTitleLabel {
    self.entryTitleLabel.numberOfLines = 0;
    self.entryTitleLabel.adjustsFontSizeToFitWidth = YES;
}

// MARK: - Sets constraints for the entryImageView

-(void)setImageViewConstraints {
    self.entryImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
            [self.entryImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [self.entryImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12],
            [self.entryImageView.heightAnchor constraintEqualToConstant:40],
            [self.entryImageView.widthAnchor constraintEqualToAnchor:self.entryImageView.heightAnchor]
    ]];
}

// MARK: - Sets constraints for the entryTitleLabel

-(void)setTitleLabelConstraints {
    self.entryTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.entryTitleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.entryTitleLabel.leadingAnchor constraintEqualToAnchor:self.entryImageView.trailingAnchor constant: 5],
        [self.entryTitleLabel.heightAnchor constraintEqualToConstant:40],
        [self.entryTitleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];
}

@end
