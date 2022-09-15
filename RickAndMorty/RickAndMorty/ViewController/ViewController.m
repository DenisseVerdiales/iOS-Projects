//
//  ViewController.m
//  RickAndMorty
//
//  Created by Consultant on 8/7/22.
//

#import "ViewController.h"
#import "PageResult.h"
#import "NetworkManager.h"
#import "RickAndMorty.h"
#import "RickAndMortyTableViewCell.h"
#import "RickAndMorty-Swift.h"

@interface ViewController()

@property(nonatomic, weak) UITableView* table;

@property(nonatomic,strong) RickAndMortyViewModel* rickVM;


@end

@implementation ViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    [self setUp];
    [self.rickVM bindWithUpdateHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
    }];
    [self.rickVM fetchRickAndMortyPage];
}

-(void)setUp{
    self.rickVM = [[RickAndMortyViewModel alloc] initWithNetworkManager: [NetworkManager sharedInstance]];
    
    UITableView* table = [[UITableView alloc] initWithFrame:CGRectZero];
    [table setTranslatesAutoresizingMaskIntoConstraints:NO];
    [table setDataSource:self];
    [table setPrefetchDataSource:self];
    [table registerClass:[RickAndMortyTableViewCell self] forCellReuseIdentifier:@"CellId"];
    
    self.table = table;
    [self.view addSubview:table];
    
    [[table.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:8] setActive:YES];
    [[table.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:8] setActive:YES];
    [[table.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-8] setActive:YES];
    [[table.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-8] setActive:YES];
    
    [table setBackgroundColor:[UIColor systemOrangeColor]];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.rickVM.count;
}

-(nonnull UITableViewCell *) tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    RickAndMortyTableViewCell* cell = (RickAndMortyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    if(cell == nil){
        return [[UITableViewCell alloc]init];
    }
    
    [cell.name setText:[self.rickVM nameFor:indexPath.row]];
    [cell.species setText:[self.rickVM speciesFor:indexPath.row]];
    [cell.gender setText:[self.rickVM genderFor:indexPath.row]];
    
    [self.rickVM imageFor:indexPath.row completion:^(UIImage * _Nullable img){
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.image setImage:img];
        });
    }];
    
    return  cell;
}

-(void) tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    NSIndexPath* lastIndexPath = [NSIndexPath indexPathForRow:self.rickVM.count - 1 inSection:0];
    if([indexPaths containsObject:lastIndexPath]){
        [self.rickVM fetchRickAndMortyPage];
    }
}

@end
