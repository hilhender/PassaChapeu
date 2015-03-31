//
//  ExpensesViewController.m
//  PassaChapeu
//
//  Created by Andre Scherma Soleo on 31/03/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "ExpensesViewController.h"
#import "BalancoViewController.h"

@interface ExpensesViewController ()

@end

@implementation ExpensesViewController
@synthesize lblEventName;
@synthesize eventName;

- (void)viewDidLoad {
    [super viewDidLoad];
    lblEventName.text = eventName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"receipt"]) {
        
        BalancoViewController *destViewController = segue.destinationViewController;
        destViewController.sharers = nil;
        destViewController.expenses = nil;

    }
}


@end
