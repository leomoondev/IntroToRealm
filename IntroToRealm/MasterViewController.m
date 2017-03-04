//
//  MasterViewController.m
//  IntroToRealm
//
//  Created by Hyung Jip Moon on 2017-03-03.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Room.h"
#import "Furniture.h"

@interface MasterViewController () <UIAlertViewDelegate>

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add New Room" message:@"Enter a Room Name. Then Press OK" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Room name";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        NSLog(@"User Tapped: Cancel");
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"User Tapped: OK");
        NSString *input = alertController.textFields[0].text;
        Room *aRoom = [[Room alloc] init];
        aRoom.name = input;
        
        // Lets get its shared object
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        // Everything in Realm (which is persisted) starts with beginWriteTransaction API. So let's start a new transaction.
        [realm beginWriteTransaction];
        
        // Add room objects to realm
        [realm addObject:aRoom];
        
        // Then commit & end this transaction
        [realm commitWriteTransaction];
        

        [self.objects addObject:aRoom.name];

        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:([Room allObjects].count - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self.tableView reloadData];
    [self presentViewController:alertController animated: YES completion: nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RLMResults *results = [Room allObjects];
        Room *object = results[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RLMResults *results = [Room allObjects];
    return results.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    RLMResults *results = [Room allObjects];
    Room *aRoom = results[indexPath.row];
    cell.textLabel.text = aRoom.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) { }
}

@end
