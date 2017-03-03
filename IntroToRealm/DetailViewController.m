//
//  DetailViewController.m
//  IntroToRealm
//
//  Created by Hyung Jip Moon on 2017-03-03.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *storeFurnitures;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailViewController

//- (void)configureView {
//    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        _detailItem = newDetailItem;
//
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(Room *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storeFurnitures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailViewCell" forIndexPath:indexPath];
    Furniture *furniture = self.storeFurnitures[indexPath.row];
    cell.textLabel.text = furniture.name;
    return cell;
}


@end
