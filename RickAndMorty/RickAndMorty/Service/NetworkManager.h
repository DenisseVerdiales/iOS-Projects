//
//  NetworkManager.h
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#define BASE_RICKY_URL @"https://rickandmortyapi.com/api/character/?page="

#import <UIKit/UIKit.h>>
#import "PageResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

+(instancetype)sharedInstance;
-(void)fetchRickWithPageNumber: (NSInteger)pageNumber completion:(void(^)(PageResult*))completion;
-(void)fetchImageWithString:(NSString*)imageString completion:(void(^)(UIImage*)) completion;

@end

NS_ASSUME_NONNULL_END
