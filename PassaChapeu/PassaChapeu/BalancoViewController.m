//
//  BalancoViewController.m
//  PassaChapeu
//
//  Created by Andre Scherma Soleo on 31/03/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "BalancoViewController.h"

#import "Expense.h"
#import "Sharer.h"

@interface BalancoViewController ()

@property (weak, nonatomic) IBOutlet UITextView *txtReceipt;

@end

@implementation BalancoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Exibe as informacoes na tela. */
    NSMutableString *text = [[NSMutableString alloc] init];

    [text appendString:@"Resumo Evento\n\n"];
    [text appendFormat:@"  %-24s R$%.2f\n", "Valor gasto:", _controller.getTotalCost];
    [text appendFormat:@"  %-24s R$%.2f\n", "Valor contribuido:", _controller.getContributedValue];
    [text appendFormat:@"  %-24s R$%.2f\n", "Subtotal:", _controller.getTotalCost - _controller.getContributedValue];

    
    [text appendString:@"\nDetalhes Pessoa\n"];
    
    for (Sharer *sharer in _controller.getSharers) {
        [text appendFormat:@"  %@\n", sharer.name];
        for (Expense *expense in sharer.expenses) {
            [text appendFormat:@"    %@\n", expense.name];
            [text appendFormat:@"      %-20s R$%.2f\n", "Preco:", expense.value];
            [text appendFormat:@"      %-20s R$%.2f\n", "Preco por pessoa:", expense.value / expense.getNumberOfSharers];
        }
        [text appendFormat:@"    %-20s R$%.2f\n", "Valor contribuido:", sharer.contributedValue];
        [text appendFormat:@"    %-20s R$%.2f\n", "Valor gasto:", sharer.evaluateBalance];
        [text appendFormat:@"    %-20s R$%.2f\n", "Subtotal:", sharer.contributedValue - sharer.evaluateBalance];
    }
    
    
    [text appendString:@"\nDetalhes Gasto\n"];

    for (Expense *expense in _controller.getExpenses) {
        [text appendFormat:@"  %@\n", expense.name];
        [text appendFormat:@"    %-22s R$%.2f\n", "Preco:", expense.value];
        [text appendFormat:@"    %-22s %d\n", "Participantes:", (int)expense.getNumberOfSharers];
        for (Sharer *sharer in expense.sharers) {
            [text appendFormat:@"      %@\n", sharer.name];
        }
        [text appendFormat:@"    %-22s R$%.2f\n", "Valor por pessoa:", expense.value / expense.getNumberOfSharers];
    }

    /* Seta edicao, fonte da text field e exibe. */
    [self.txtReceipt setEditable:NO];
    [self.txtReceipt setFont:[UIFont fontWithName:@"Courier" size:16]];
    self.txtReceipt.text = text;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
