//
//  DetailViewController.m
//  IntroToRealm
//
//  Created by Hyung Jip Moon on 2017-03-03.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"aRoom = %@", self.detailItem];
    self.storeFurnitures = [Furniture objectsWithPredicate:pred];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add New Furniture" message:@"Enter a Furniture Name. Then Press OK" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Furniture name";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        NSLog(@"User Tapped: Cancel");
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"User Tapped: OK");
        NSString *input = alertController.textFields[0].text;
        
        Furniture *aFurniture = [[Furniture alloc] init];
        aFurniture.name = input;
        aFurniture.aRoom = self.detailItem;
        
        // Lets get its shared object
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        // Everything in Realm (which is persisted) starts with beginWriteTransaction API. So let's start a new transaction.
        [realm beginWriteTransaction];
        
        // Add room objects to realm
        [realm addObject:aFurniture];
        
        // Then commit & end this transaction
        [realm commitWriteTransaction];

        
        [self.detailTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.storeFurnitures.count - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self.detailTableView reloadData];
    [self presentViewController:alertController animated: YES completion: nil];
}

#pragma mark - UITableView

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
