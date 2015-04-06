//
//  ExpensesViewController.h
//  PassaChapeu
//
//  Created by Andre Scherma Soleo on 31/03/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>
#import "Controller.h"

@interface ExpensesViewController : UIViewController
@property (nonatomic, strong) Controller *controller;

@property (nonatomic, strong) IBOutlet UILabel *lblEventName;

@end
