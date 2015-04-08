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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture.jpg"]];
    self.txtReceipt.backgroundColor = [UIColor clearColor];
    self.txtReceipt.layer.borderWidth=1.0;
    self.txtReceipt.layer.borderColor = [[UIColor blackColor] CGColor];
    [super viewDidLoad];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    
     /* Exibe as informacoes na tela. */
    [text.mutableString appendString:@"Resumo Evento\n\n"];
    [text.mutableString appendFormat:@"  %-22s R$%.2f\n", "Valor gasto:", _controller.getTotalCost];
    
    [text.mutableString appendFormat:@"  %-22s R$%.2f\n", "Valor contribuido:", _controller.getContributedValue];
    [text.mutableString appendFormat:@"  %-22s ", "Subtotal:"];
    
    //apenda o valor de subtotal com a cor adequada
    [self appendFormatedAttributedStringwithValue:_controller.getContributedValue - _controller.getTotalCost toString:text];
    
    
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
        [text.mutableString appendFormat:@"    %-20s ", "Subtotal:"];
        
        //apenda o valor de subtotal com a cor adequada
        [self appendFormatedAttributedStringwithValue: (sharer.contributedValue - sharer.evaluateBalance) toString:text];
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
    
    //tentativa de manter a fonte Courier por todo o TextView (nao funfa)
    [text addAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Courier" size:16] forKey:NSFontAttributeName] range:NSMakeRange(0, [text length])];
    
    self.txtReceipt.attributedText = text;
   
}

/*set an internal auxiliar attributedString font color acording with value and apend in string*/
- (void) appendFormatedAttributedStringwithValue: (double) value toString: (NSMutableAttributedString*) string{
    NSMutableAttributedString *formatedString = [[NSMutableAttributedString alloc] init];
    
    [formatedString.mutableString setString: [NSString stringWithFormat: @"R$%.2f\n ", fabsf(value)]];
    NSLog(@"%f", value);
    
    if(value < 0)
        [formatedString setAttributes: [NSDictionary dictionaryWithObjects: @[[UIColor redColor],[UIFont fontWithName:@"Courier" size:16]] forKeys: @[NSForegroundColorAttributeName, NSFontAttributeName]] range: NSMakeRange (0, [formatedString length]-1)];
    else
        [formatedString setAttributes: [NSDictionary dictionaryWithObjects: @[[UIColor greenColor],[UIFont fontWithName:@"Courier" size:16]] forKeys: @[NSForegroundColorAttributeName, NSFontAttributeName]] range: NSMakeRange (0, [formatedString length]-1)];
    
    [string appendAttributedString: formatedString];
    
}

@end
