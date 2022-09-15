//
//  RickAndMorty.h
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RickAndMorty : NSObject

@property(nonatomic, assign)NSInteger identifier;
@property(nonatomic, copy) NSString* name;
@property(nonatomic, copy) NSString* status;
@property(nonatomic, copy) NSString* gender;
@property(nonatomic, copy) NSString* image;
@property(nonatomic, copy) NSString* species;

-(instancetype)initWithDictionary: (NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END
