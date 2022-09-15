//
//  RickAndMortyTableViewCell.h
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#import <UIKit/UIKit.h>>

NS_ASSUME_NONNULL_BEGIN

@interface RickAndMortyTableViewCell : UITableViewCell
@property(nonatomic, weak) UIImageView* image;
@property(nonatomic, weak) UILabel* name;
@property(nonatomic, weak) UILabel* species;
@property(nonatomic, weak) UILabel* gender;

@end

NS_ASSUME_NONNULL_END
