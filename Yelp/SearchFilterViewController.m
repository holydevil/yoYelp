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
@property (nonatomic, strong) NSMutableDictionary *expandedState;
@property (nonatomic, strong) NSMutableDictionary *selectedState;

@property NSUserDefaults *defaults;

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
- (IBAction)searchButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setupDefaults {
    self.title = @"Filters";
    self.expandedState = [[NSMutableDictionary alloc] initWithCapacity:4];
    self.selectedState = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
//    self.navigationController
}

#pragma mark - Table methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //pick up one dictionary at a time (one dict per section)
    NSDictionary *currentFilter = self.filters[section];
    
    if ([[currentFilter objectForKey:@"type"] isEqualToString:@"list"]) {
        return [[currentFilter objectForKey:@"options_api"] count];
    } else if ([[currentFilter objectForKey:@"type"] isEqualToString:@"collapse"]) {
        return [[currentFilter objectForKey:@"options_api"] count];
    }
    
    return [[currentFilter objectForKey:@"options_api"] count];

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
    
    //pick up one dictionary at a time (one dict per section)
    NSDictionary *currentFilter = self.filters[indexPath.section];
//    NSLog(@"current filter for %@ are %@", [currentFilter objectForKey:@"name"],currentFilter);
    UITableViewCell *cell = [[UITableViewCell  alloc]init];
    cell.textLabel.text = [currentFilter objectForKey:@"options"][indexPath.row];
    
    if ([[currentFilter objectForKey:@"type"] isEqualToString:@"switch"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectZero];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView setTag:indexPath.row];
        cell.accessoryView = switchView;
        
    } else if ([[currentFilter objectForKey:@"type"] isEqualToString:@"list"]) {
        if ([[self.selectedState objectForKey:[currentFilter objectForKey:@"options_api"][indexPath.row]] isEqual:@YES]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else if ([[currentFilter objectForKey:@"type"] isEqualToString:@"collapse"]) {
        
    }
    
    
    return cell;
        
}

-(void)switchChanged: (id) sender {
    if ([[self.selectedState objectForKey:@"deals_filter"] isEqual:@YES]) {
        self.selectedState[@"deals_filter"] = @NO;
    } else {
        self.selectedState[@"deals_filter"] = @YES;
    }
    NSLog(@"deals_filter is %@", self.selectedState[@"deals_filter"]);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //pick up one dictionary at a time (one dict per section)
    NSDictionary *currentFilter = self.filters[indexPath.section];
    
    if ([[currentFilter objectForKey:@"type"] isEqualToString:@"list"]) {
        if ([[self.selectedState objectForKey:[currentFilter objectForKey:@"options_api"][indexPath.row]] isEqual:@YES]) {
            self.selectedState[[currentFilter objectForKey:@"options_api"][indexPath.row]] = @NO;
        } else {
            self.selectedState[[currentFilter objectForKey:@"options_api"][indexPath.row]] = @YES;
        }
    } else if ([[currentFilter objectForKey:@"type"] isEqualToString:@"collapse"]) {
        if ([self.expandedState[[currentFilter objectForKey:@"options_api"][indexPath.row]] isEqual:@YES]) {
            self.expandedState[[currentFilter objectForKey:@"options_api"][indexPath.row]] = @NO;
        } else {
            self.expandedState[[currentFilter objectForKey:@"options_api"][indexPath.row]] = @YES;
        }

        NSLog(@"selected value is %@", [currentFilter objectForKey:@"options_api"][indexPath.row]);
//        }
    }
    
//    NSLog(@"List dict looks like this %@", self.expandedState);
//    NSLog(@"Category dict looks like this %@", self.selectedState);
    
//
//    int previous = self.collapsedState;
//    self.collapsedState = indexPath.section;
//
//    NSMutableIndexSet *set = [NSMutableIndexSet indexSetWithIndex:previous];
//    [set addIndex:self.collapsedState];
//
//
    
    [self.defaults setObject:self.expandedState forKey:@"expandedState"];
    [self.defaults setObject:self.selectedState forKey:@"selectedState"];
    
    //imp. don't forget to synchronize (save in other words)
    [self.defaults synchronize];
    
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    [tableView reloadData];
}


@end
