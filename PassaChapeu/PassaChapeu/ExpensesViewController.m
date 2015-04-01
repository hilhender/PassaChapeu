//
//  ExpensesViewController.m
//  PassaChapeu
//
//  Created by Andre Scherma Soleo on 31/03/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "ExpensesViewController.h"
#import "BalancoViewController.h"


@interface ExpensesViewController () <UITableViewDelegate, UITableViewDataSource>

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

- (void)viewDidLoad {
    _controller = [[Controller alloc] initWithEvent:_event];
    lblEventName.text = _controller.event.name;
  
    [self setInfo];
    
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInfo {
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

        /* Cria um novo participante com "name", adiciona ao evento e recarrega a Table de participantes */
        Sharer *newSharer = [[Sharer alloc] initWithName:name];
        [_event addNewSharer: newSharer];
        [_tblPessoas reloadData];
        NSLog(@"%@", name);
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Insira nome", @"NameExpense");
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Required methods of UITableViewDataSource Protocol

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cria cell para _tblPessoas
    if([tableView isEqual: _tblPessoas]){
        static NSString *cellIdentifier = @"SharerCell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
        
        Sharer* sharer = _event.sharers[indexPath.row];
        cell.textLabel.text = sharer.name;
        
        return cell;
    }
    //cria cell para _tblGastos
    else if([tableView isEqual: _tblGastos]){
        static NSString *cellIdentifier = @"ExpensesCell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
        
        Expense* expense = _event.expenses[indexPath.row];
        cell.textLabel.text = expense.name;

        return cell;
    }
    //se chegou aqui eh porque deu merda
    else
        return nil;
}
    
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    if([tableView isEqual: _tblPessoas]){
        
        Sharer *sharer = [_controller getSharer:row];
        
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
        
    }
    //cria cell para _tblGastos
    else if([tableView isEqual: _tblGastos]){
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

    }
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    
    
    
    
    
    
    
   /*
 
    static NSString *CellIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Event *event = _eventsOnMemory[indexPath.row];
    cell.textLabel.text = event.name;
    
    return cell;
     
}*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual: _tblPessoas])
        return [_event.sharers count];
    
    if([tableView isEqual: _tblGastos])
        return [_event.expenses count];
    
    return 0; //soh pra nao correr o risco de nao retornar nada
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
