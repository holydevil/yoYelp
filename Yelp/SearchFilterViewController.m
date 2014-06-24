//
//  SearchFilterViewController.m
//  Yelp
//
//  Created by Praveen P N on 6/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SearchFilterViewController.h"

@interface SearchFilterViewController ()
@property (nonatomic, strong) NSMutableArray *filters;

@end

@implementation SearchFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.filters = @{
//                         @"deals":@{@"<#string#>": <#object, ...#>}}
        NSDictionary *sortFilter = @{
                                     @"name":@"sort",
                                     @"type":@"collapse",
                                     @"options":@[@"Best Match", @"Disatnce",@"Rating"],
                                     @"options_api":@[@"0",@"1",@"2"]
                                     };
        
        NSDictionary *searchRadiusFilter = @{
                                             @"name":@"radius_filter",
                                             @"type":@"collapse",
                                             @"options":@[@"50 meters", @"100 meters",@"500 meters",@"1000 meters"],
                                             @"options_api":@[@"50",@"100",@"500",@"1000"]
                                             };
        NSDictionary *mostPopularFilter = @{
                                            @"name":@"deals_filter",
                                            @"type":@"switch",
                                            @"options":@[@"Deal"],
                                            @"options_api":@[@"false"]
                                            };
        
        NSDictionary *categoryFilter = @{
                                         @"name":@"category_filter",
                                         @"type":@"list",
                                         @"options":@[@"Vegan", @"Vegetarian", @"Indian", @"Thai", @"Mexican", @"Mediterranean"],
                                         @"options_api":@[@"vegan", @"vegetarian", @"indpak", @"thai", @"mexican", @"mediterranean"]
                                         };

        
        self.filters = [NSMutableArray arrayWithObjects:sortFilter,searchRadiusFilter,mostPopularFilter,categoryFilter, nil];
        
        NSLog(@"number of filters are %d, options_api = %@", [self.filters count],[self.filters[1] objectForKey:@"options"][0]);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDefaults];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setupDefaults {
    self.title = @"Filters";
//    self.navigationController
}

#pragma mark - Table methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [[self.filters[section] objectForKey:@"options"] count];
            break;
        case 1:
            return [[self.filters[section] objectForKey:@"options"] count];
            break;
        case 2:
            return [[self.filters[section] objectForKey:@"options"] count];
            break;
        case 3:
            return [[self.filters[section] objectForKey:@"options"] count];
            break;
        default:
            return 0;
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Sort";
            break;
        case 1:
            return @"Radius";
            break;
        case 2:
            return @"Deals";
            break;
        case 3:
            return @"Categories";
            break;
        default:
            return @"";
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.filters count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //pick up one dictionary at a time
    NSDictionary *currentFilter = self.filters[indexPath.section];
//    NSLog(@"current filter for %@ are %@", [currentFilter objectForKey:@"name"],currentFilter);
    UITableViewCell *cell = [[UITableViewCell  alloc]init];
    cell.textLabel.text = [currentFilter objectForKey:@"options"][indexPath.row];
    
    if ([[currentFilter objectForKey:@"type"] isEqualToString:@"switch"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectZero];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView setTag:indexPath.row];
        
        cell.textLabel.text = @"Deals?";
        cell.accessoryView = switchView;
        
    } else if ([[currentFilter objectForKey:@"type"] isEqualToString:@"list"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if ([[currentFilter objectForKey:@"type"] isEqualToString:@"collapse"]) {
        
    }
    
    
    return cell;
        
}

-(void)switchChanged: (id) sender {
    NSLog(@"toggle changed %d", [sender tag]);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    int previous = self.collapsedState;
//    self.collapsedState = indexPath.section;
//    
//    NSMutableIndexSet *set = [NSMutableIndexSet indexSetWithIndex:previous];
//    [set addIndex:self.collapsedState];
//
//    
//    [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
//    
//    [tableView reloadData];
}


@end
