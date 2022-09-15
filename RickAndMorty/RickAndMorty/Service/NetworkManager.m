//
//  NetworkManager.m
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#import "NetworkManager.h"

@implementation NetworkManager

+(instancetype)sharedInstance{
    static NetworkManager* _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    return _sharedInstance;
}

-(instancetype)init{
    self = [super self];
    return self;
}

-(void)fetchRickWithPageNumber:(NSInteger)pageNumber completion:(void(^)(PageResult* _Nullable))completion{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld", BASE_RICKY_URL, (long)pageNumber]];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if(error){
            completion(nil);
            return;
        }
        
        if(data == nil){
            completion(nil);
            return;
        }
        
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if([object isKindOfClass:[NSDictionary class]]){
            NSDictionary* dictionary = object;
            PageResult* page = [[PageResult alloc] initWithJsonDictionary:dictionary];
            completion(page);
            return;
        }
    }] resume];
    
}

-(void)fetchImageWithString:(NSString *)imageString completion:(void (^)(UIImage * _Nonnull))completion{
    NSURL* url = [NSURL URLWithString: [NSString stringWithFormat:@"%@", imageString]];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if(error){
            completion(nil);
            return;
        }

        if(data == nil){
            completion(nil);
            return;
        }
                
        UIImage* image = [UIImage imageWithData:data];
        completion(image);
    }]resume];
}


@end
