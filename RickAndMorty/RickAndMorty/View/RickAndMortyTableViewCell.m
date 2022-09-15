//
//  RickAndMortyTableViewCell.m
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#import "RickAndMortyTableViewCell.h"

@implementation RickAndMortyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    
    return self;
}

-(void)setUp {
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setImage:[UIImage imageNamed:@"question-mark"]];
    
    UILabel* name = [[UILabel alloc] initWithFrame:CGRectZero];
    [name setTranslatesAutoresizingMaskIntoConstraints:NO];
    [name setNumberOfLines:0];
    [name setText:@"Name"];
    
    UILabel* species = [[UILabel alloc] initWithFrame:CGRectZero];
    [species setTranslatesAutoresizingMaskIntoConstraints:NO];
    [species setNumberOfLines:0];
    [species setText:@"species"];
    
    UILabel* gender = [[UILabel alloc] initWithFrame:CGRectZero];
    [gender setTranslatesAutoresizingMaskIntoConstraints:NO];
    [gender setNumberOfLines:0];
    [gender setText:@"gender"];
    
    self.image = imageView;
    self.name = name;
    self.species = species;
    self.gender = gender;
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:name];
    [self.contentView addSubview:species];
    [self.contentView addSubview:gender];
    
    [[imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8] setActive:YES];
    [[imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8] setActive:YES];
    [[imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8] setActive:YES];
    
    [[imageView.heightAnchor constraintEqualToConstant:150] setActive:YES];
    [[imageView.widthAnchor constraintEqualToConstant:150] setActive:YES];
    
    [[name.leadingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:8] setActive:YES];
    [[name.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8] setActive:YES];
    [[name.bottomAnchor constraintEqualToAnchor:species.topAnchor constant: -8] setActive:YES];
    
    [[species.leadingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:8] setActive:YES];
    [[species.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8] setActive:YES];
    [[species.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor] setActive:YES];
    
    [[gender.leadingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:8] setActive:YES];
    [[gender.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8] setActive:YES];
    [[gender.topAnchor constraintEqualToAnchor:species.bottomAnchor] setActive:YES];
    
}

@end
