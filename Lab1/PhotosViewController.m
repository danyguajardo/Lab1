//
//  PhotosViewController.m
//  Lab1
//
//  Created by sbernal0115 on 6/27/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "PhotosViewController.h"
#import "UIImageView+AFNetworking.h"
#import "cellDecoration.h"

@interface PhotosViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableViewSource;
@property (weak, nonatomic) IBOutlet UIImageView *imagePlaceHolder;

@end


@implementation PhotosViewController

 - (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewSource.rowHeight = 240;
    self.tableViewSource.dataSource = self;
    self.tableViewSource.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // TODO: Get the posts and store in posts property
            // TODO: Reload the table view
            
            NSDictionary *responseDictionary = dataDictionary[@"response"];
            
            self.posts = responseDictionary[@"posts"];
            [self.tableViewSource reloadData];
            
        }
    }];
    
    
    [task resume];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cellDecoration *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
//    cell.textLabel.text = [NSString stringWithFormat:@"This is row %ld", (long)indexPath.row];

    NSDictionary *post = self.posts[indexPath.row];
    
    NSArray *photos = post[@"photos"];
    if(photos){
        // 1. Get the first photo in the photos array
        NSDictionary *photo = photos[0];
        
        // 2. Get the original size dictionary from the photo
        NSDictionary *originalSize =  photo[@"original_size"];
        
        // 3. Get the url string from the original size dictionary
        NSString *urlString = originalSize[@"url"];
        
        // 4. Create a URL using the urlString
        NSURL *url = [NSURL URLWithString:urlString];
        
        [cell.photoView setImageWithURL:url];

    }
    return cell;
    
}


@end
