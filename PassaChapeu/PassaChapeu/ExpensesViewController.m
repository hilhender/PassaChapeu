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

@property (weak, nonatomic) IBOutlet UILabel *lblInfo;

@property (weak, nonatomic) IBOutlet UITextField *txtContributedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblContributedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalCost;
@property (weak, nonatomic) IBOutlet UILabel *lblBalance;
@property (weak, nonatomic) IBOutlet UITableView *tblGastos;
@property (weak, nonatomic) IBOutlet UITableView *tblPessoas;

@end

@implementation ExpensesViewController {
    NSMutableArray *_expenses;
}

@synthesize lblEventName;
@synthesize eventName;

- (void)viewDidLoad {
    lblEventName.text = _controller.event.name;
  
    [self setInfo];
    
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInfo {
    if (true) {
        /* TERMINAR DE IMPLEMENTAR. TENHO QUE PEGAR A PESOA SELECIONADA E PERGUNTAR AO CONTROLLER AS INFORMACOES DAQUELA PESSOA. */
        /* Se pessoa estiver selecionado. */
        /* Quais informacoes a exibir? */
        [self.lblContributedValue setHidden:YES];
        [self.lblTotalCost setHidden:NO];
        [self.lblBalance setHidden:NO];
        [self.txtContributedValue setHidden:NO];
        
        /* Valores a serem exibidos. */
        float contributedValue, totalCost, balance;
        contributedValue = [self.controller getContributedValue];
        totalCost = [self.controller getTotalCost];
        balance = contributedValue - totalCost;
        
        /* Exibe. */
        self.lblInfo.text = @"Valor contribuido:\nTotal gastos:\nSaldo:";
        self.lblContributedValue.text = [NSString stringWithFormat:@"%.2f", contributedValue];
        self.lblTotalCost.text = [NSString stringWithFormat:@"%.2f", totalCost];
        self.lblBalance.text = [NSString stringWithFormat:@"%.2f", balance];
    } else if (true) {
        /* TERMINAR DE IMPLEMENTAR. TENHO QUE PEGAR O GASTO SELECIONADO E PERGUNTAR AO CONTROLLER O VALOR DAQUELE GASTO E DIVIDIR PELO NUMERO DE PESSOAS */
        /* Se gasto estiver selecionado. */
        /* Quais informacoes a exibir? */
        [self.lblContributedValue setHidden:NO];
        [self.lblTotalCost setHidden:YES];
        [self.lblBalance setHidden:YES];
        [self.txtContributedValue setHidden:YES];
        
        /* Valores a serem exibidos. */
        float costPerPerson;
        costPerPerson = [self.controller getContributedValue];
        
        /* Exibe. */
        self.lblInfo.text = @"Gasto por pessoa:";
        self.lblContributedValue.text = [NSString stringWithFormat:@"%.2f", costPerPerson];
    } else {
        /* Se nada estiver selecionado. */
        /* Quais informacoes a exibir? */
        [self.lblContributedValue setHidden:NO];
        [self.lblTotalCost setHidden:NO];
        [self.lblBalance setHidden:NO];
        [self.txtContributedValue setHidden:YES];
        
        /* Valores a serem exibidos. */
        float contributedValue, totalCost, balance;
        contributedValue = [self.controller getContributedValue];
        totalCost = [self.controller getTotalCost];
        balance = contributedValue - totalCost;
        
        /* Exibe. */
        self.lblInfo.text = @"Valor contribuido:\nTotal:\nSaldo:";
        self.lblContributedValue.text = [NSString stringWithFormat:@"%.2f", contributedValue];
        self.lblTotalCost.text = [NSString stringWithFormat:@"%.2f", totalCost];
        self.lblBalance.text = [NSString stringWithFormat:@"%.2f", balance];
    }
    
    
}

#pragma mark - Add Buttons

- (IBAction)addExpense:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Insira o nome e custo:" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancelar", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        /* Implementa o botao cancelar. */
        NSLog(@"Cancel action");
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        /* Implementa o botão OK. */
        UITextField *nameExpense = alert.textFields.firstObject;
        UITextField *costExpense = alert.textFields.lastObject;
        
        NSString *name = nameExpense.text;
        float cost = costExpense.text.floatValue;
        
        /* Tenho nome e custo em *name e cost. */
        NSLog(@"%@, %.2f", name, cost);
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Insira nome", @"NameExpense");
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Insira custo", @"CostExpense");
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)addSharer:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Insira o nome do participante:" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancelar", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        /* Implementa o botao cancelar. */
        NSLog(@"Cancel action");
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        /* Implementa o botão OK. */
        UITextField *nameSharer = alert.textFields.firstObject;
        NSString *name = nameSharer.text;

        /* tenho o nome do participante em *name */
        NSLog(@"%@", name);
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Insira nome", @"NameExpense");
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"receipt"]) {
        
        BalancoViewController *destViewController = segue.destinationViewController;
        destViewController.controller = _controller;

    }
}

@end
