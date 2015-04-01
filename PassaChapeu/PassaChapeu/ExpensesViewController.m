//
//  ExpensesViewController.m
//  PassaChapeu
//
//  Created by Andre Scherma Soleo on 31/03/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "ExpensesViewController.h"
#import "BalancoViewController.h"

#import "Controller.h"

@interface ExpensesViewController ()

@property (nonatomic, strong) Controller *_controller;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;

@end

@implementation ExpensesViewController
@synthesize lblEventName;
@synthesize eventName;

- (void)viewDidLoad {
    lblEventName.text = eventName;
    /* falta o controller!! */
    [self setInfo];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInfo {
    NSMutableString *info = [[NSMutableString alloc] init];

    float contributedValue, totalCost, balance;
    
    contributedValue = [self._controller getContributedValue];
    totalCost = [self._controller getTotalCost];
    
    balance = contributedValue - totalCost;

    [info appendFormat:@"Valor contribuido: %.2f\n", contributedValue];
    [info appendFormat:@"Total:             %.2f\n", totalCost];
    [info appendFormat:@"Saldo:             %.2f", balance];
    
    self.lblInfo.text = [NSString stringWithString:info];
    NSLog(@"%@", [NSString stringWithString:info]);
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"receipt"]) {

        BalancoViewController *destViewController = segue.destinationViewController;
        destViewController.sharers = self._controller.getSharers;
        destViewController.expenses = self._controller.getExpenses;

    }
}


@end
