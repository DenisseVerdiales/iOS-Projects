//
//  RickAndMorty.m
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#import "RickAndMorty.h"

@implementation RickAndMorty

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super self];
    if(self){
        self.identifier = [[dictionary valueForKey:@"id"]integerValue];
        self.name = [dictionary valueForKey:@"name"];
        self.image = [dictionary valueForKey:@"image"];
        self.status = [dictionary valueForKey:@"status"];
        self.gender = [dictionary valueForKey:@"gender"];
        self.species = [dictionary valueForKey:@"species"];
        
    }
    return self;
}


@end
