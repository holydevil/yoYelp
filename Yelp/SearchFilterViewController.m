//
//  SearchFilterViewController.m
//  Yelp
//
//  Created by Praveen P N on 6/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SearchFilterViewController.h"

@interface SearchFilterViewController ()

@property (nonatomic,assign) int collapsedState;

@end

@implementation SearchFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

    if (self.collapsedState == section) {
        return 1;
    } else {
        return 3;
    }
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Category";
            break;
        case 1:
            return @"Sort";
            break;
        case 2:
            return @"Radius";
            break;
        case 3:
            return @"Deals";
            break;
        default:
            return @"";
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell  alloc]init];
    
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectZero];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [switchView setTag:indexPath.row];
        cell.textLabel.text = @"Delas?";
        cell.accessoryView = switchView;
        
    } else {
//        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = @"cell here";
        

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
