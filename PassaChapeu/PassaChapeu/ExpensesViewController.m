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

@property (weak, nonatomic) IBOutlet UITextField *txtContributedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblContributedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalCost;
@property (weak, nonatomic) IBOutlet UILabel *lblBalance;

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
    if (true) {
        /* Se nada estiver selecionado. */
        /* Quais informacoes a exibir? */
        [self.lblContributedValue setHidden:NO];
        [self.lblTotalCost setHidden:NO];
        [self.lblBalance setHidden:NO];
        [self.txtContributedValue setHidden:YES];
        
        /* Valores a serem exibidos. */
        float contributedValue, totalCost, balance;
        contributedValue = [self._controller getContributedValue];
        totalCost = [self._controller getTotalCost];
        balance = contributedValue - totalCost;

        /* Exibe. */
        self.lblInfo.text = @"Valor contribuido:\nTotal:\nSaldo:";
        self.lblContributedValue.text = [NSString stringWithFormat:@"%.2f", contributedValue];
        self.lblTotalCost.text = [NSString stringWithFormat:@"%.2f", totalCost];
        self.lblBalance.text = [NSString stringWithFormat:@"%.2f", balance];
    } else if (true) {
        /* Se gasto estiver selecionado. */
        /* Quais informacoes a exibir? */
        [self.lblContributedValue setHidden:NO];
        [self.lblTotalCost setHidden:YES];
        [self.lblBalance setHidden:YES];
        [self.txtContributedValue setHidden:YES];
        
        /* Valores a serem exibidos. */
        float costPerPerson;
        costPerPerson = [self._controller getContributedValue];
        
        /* Exibe. */
        self.lblInfo.text = @"Gasto por pessoa:";
        self.lblContributedValue.text = [NSString stringWithFormat:@"%.2f", costPerPerson];
    }
    
    
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
