//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "ListingTableViewCell.h"
#import "MBProgressHUD.h"
#import "SearchFilterViewController.h"

NSString * const kYelpConsumerKey = @"Vnjp7ZF04kiQ7sK2o1vnRA";
NSString * const kYelpConsumerSecret = @"14zcRgDb8vjCV7gdOG8b6blT7dk";
NSString * const kYelpToken = @"f2UobXsqeE4xIf1KLl07iK7LlM_pfvYZ";
NSString * const kYelpTokenSecret = @"CJBo7INY6j42rDN9GsvJ7SaXIOQ";

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listingTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *yelpSearchBar;

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSMutableArray *listings;
@property MBProgressHUD *hud;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //uncomment this when you want to fetch real data
    if (self) {
        [self getDatafromYelp:@"Restaurants"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDefaults];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Setting up defaults
- (void) setupDefaults {
    self.listingTableView.dataSource = self;
    self.listingTableView.delegate = self;
    self.listingTableView.rowHeight = 75;
    [self.listingTableView registerNib:[UINib nibWithNibName:@"ListingTableViewCell" bundle:nil ] forCellReuseIdentifier:@"ListingTableViewCell"];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.94 green:0 blue:0 alpha:1]];
    self.yelpSearchBar.placeholder = @"Search";
    [self.yelpSearchBar setBarTintColor:[UIColor colorWithRed:0.8 green:0 blue:0.02 alpha:1]];
}

#pragma mark - Overriding top navigation bar
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listings count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *yelpListing = [self.listings objectAtIndex:indexPath.row];
    cell.listing = yelpListing;
    
    return cell;
}

#pragma mark - Search methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(searchYelpWithString:) withObject:searchText afterDelay:0.8];
}

// Dismiss the keyboard after the user hits search
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

// Pass search text to the main API function
-(void)searchYelpWithString: (NSString *) searchText {
    [self getDatafromYelp:searchText];
}

- (IBAction)filterButtonClicked:(id)sender {
    SearchFilterViewController *searchFilterViewController = [[SearchFilterViewController alloc]init];
    [self.navigationController pushViewController:searchFilterViewController animated:YES];
}



#pragma mark - API calls
-(void)getDatafromYelp: (NSString *) searchTerm {
    [self showHUD];
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:searchTerm success:^(AFHTTPRequestOperation *operation, id response) {
        self.listings = [response objectForKey:@"businesses"];
        [self.listingTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    
    [self hideHUD];
    
}

#pragma mark - Loading icons
- (void) showHUD {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"loading";
    [self.hud show:YES];
}

- (void) hideHUD {
    [self.hud hide:YES];
}


@end
