//
//  ListingTableViewCell.m
//  Yelp
//
//  Created by Praveen P N on 6/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ListingTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ListingTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *listingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingReviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *listingThumbnailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *listingRatingImageView;


@end

@implementation ListingTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setListing:(NSDictionary *)listing {
    
    @try {
        self.listingTitleLabel.text = listing[@"name"];
        NSArray *address = [listing[@"location"] valueForKey:@"address"];
        
        self.listingAddressLabel.text = [address objectAtIndex:0];
        
        NSArray *categories = listing[@"categories"];
        self.listingCategoryLabel.text = [[categories objectAtIndex:0] objectAtIndex:0];
        
        self.listingReviewLabel.text = [NSString stringWithFormat:@"%@ Reviews", listing[@"review_count"]];
        [self.listingRatingImageView setImageWithURL:[NSURL URLWithString:listing[@"rating_img_url"]]];
        [self.listingThumbnailImageView setImageWithURL:[NSURL URLWithString:listing[@"image_url"]]];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Cell cannot show data due to exception %@", exception);
        return;
    }
    @finally {
        return;
    }
    

    
}

@end
