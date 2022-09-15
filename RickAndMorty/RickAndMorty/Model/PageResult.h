//
//  PageResult.h
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageResult : NSObject

@property(nonatomic,assign) NSInteger pages;
@property(nonatomic,assign) NSString* next;
@property(nonatomic,assign) NSString* prev;
@property(nonatomic,strong) NSArray* RickAndMorty;

-(instancetype)initWithJsonDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
