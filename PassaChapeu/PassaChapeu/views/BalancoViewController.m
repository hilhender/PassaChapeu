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
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    
     /* Exibe as informacoes na tela. */
    [text.mutableString appendString:@"Resumo Evento\n\n"];
    [text.mutableString appendFormat:@"  %-22s R$%.2f\n", "Valor gasto:", _controller.getTotalCost];
    
    [text.mutableString appendFormat:@"  %-22s R$%.2f\n", "Valor contribuido:", _controller.getContributedValue];
    [text.mutableString appendFormat:@"  %-22s R$%.2f\n", "Subtotal:", _controller.getTotalCost - _controller.getContributedValue];
    
    
    //seta a cor da string de acordo com o valor e apenda em text
    [attributedText.mutableString setString: [NSString stringWithFormat: @"R$%.2f\n", _controller.getTotalCost - _controller.getContributedValue]];
    if(_controller.getTotalCost - _controller.getContributedValue < 0)
        [attributedText setAttributes: [NSDictionary dictionaryWithObject: [UIColor redColor] forKey: NSForegroundColorAttributeName] range: NSMakeRange (0, [attributedText.mutableString length])];
    else
        [attributedText setAttributes: [NSDictionary dictionaryWithObject: [UIColor greenColor] forKey: NSForegroundColorAttributeName] range: NSMakeRange (0, [attributedText.mutableString length])];
    
    [text appendAttributedString: attributedText];


    //tentativa de fazer com que o resto do texto nao pegue o atributo da ultima attributedstring apendada
    //dá crash, nao sei porque, talvez pelo range
    /*
     [text setAttributes:[NSDictionary dictionaryWithObject: [UIColor blackColor] forKey:NSForegroundColorAttributeName] range: NSMakeRange([text.mutableString length], [text.mutableString length])];
     */
    [text.mutableString appendString:@"\nDetalhes Pessoa\n"];
    
    for (Sharer *sharer in _controller.getSharers) {
        [text.mutableString appendFormat:@"  %@\n", sharer.name];
        for (Expense *expense in sharer.expenses) {
            [text.mutableString appendFormat:@"    %@\n", expense.name];
            [text.mutableString appendFormat:@"      %-18s R$%.2f\n", "Preco:", expense.value];
            [text.mutableString appendFormat:@"      %-18s R$%.2f\n", "Preco por pessoa:", expense.value / expense.getNumberOfSharers];
        }
        [text.mutableString appendFormat:@"    %-20s R$%.2f\n", "Valor contribuido:", sharer.contributedValue];
        [text.mutableString appendFormat:@"    %-20s R$%.2f\n", "Valor gasto:", sharer.evaluateBalance];
        [text.mutableString appendFormat:@"    %-20s R$%.2f\n", "Subtotal:", sharer.contributedValue - sharer.evaluateBalance];
    }
    
    
    [text.mutableString appendString:@"\nDetalhes Gasto\n"];

    for (Expense *expense in _controller.getExpenses) {
        [text.mutableString appendFormat:@"  %@\n", expense.name];
        [text.mutableString appendFormat:@"    %-20s R$%.2f\n", "Preco:", expense.value];
        [text.mutableString appendFormat:@"    %-20s %d\n", "Participantes:", (int)expense.getNumberOfSharers];
        for (Sharer *sharer in expense.sharers) {
            [text.mutableString appendFormat:@"      %@\n", sharer.name];
        }
        [text.mutableString appendFormat:@"    %-20s R$%.2f\n", "Valor por pessoa:", expense.value / expense.getNumberOfSharers];
    }

    /* Seta edicao, fonte da text field e exibe. */
    
    [self.txtReceipt setEditable:NO];
    [self.txtReceipt setFont:[UIFont fontWithName:@"Courier" size:16]];
    
    self.txtReceipt.attributedText = text;
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
