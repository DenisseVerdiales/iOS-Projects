//
//  PageResult.m
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#import "PageResult.h"
#import "RickAndMorty.h"

@implementation PageResult

-(instancetype)initWithJsonDictionary:(NSDictionary *)dictionary{
    self = [super self ];
    
    if(self){
        self.pages = [[dictionary valueForKey:@"pages"] integerValue];
        self.next = [dictionary valueForKey:@"next"];
        self.prev = [dictionary valueForKey:@"prev"];
        
        NSMutableArray* rickAndMorty = [[NSMutableArray alloc] init];
        NSArray* jsonRickAndMorty = [dictionary objectForKey:@"results"];
     
        for(NSDictionary* rickDic in jsonRickAndMorty){
            RickAndMorty* rick = [[RickAndMorty alloc] initWithDictionary:rickDic];
            [rickAndMorty addObject:rick];
        }
        self.RickAndMorty = [NSArray arrayWithArray:rickAndMorty];
    }
    return self;
}

@end
