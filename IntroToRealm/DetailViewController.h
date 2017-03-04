//
//  DetailViewController.h
//  IntroToRealm
//
//  Created by Hyung Jip Moon on 2017-03-03.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "Furniture.h"

@interface DetailViewController : UIViewController 
@property (strong, nonatomic) Room *detailItem;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) RLMResults<Furniture *> *storeFurnitures;

@end
