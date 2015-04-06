//
//  ExpensesViewController.m
//  PassaChapeu
//
//  Created by Andre Scherma Soleo on 31/03/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "ExpensesViewController.h"
#import "BalancoViewController.h"


@interface ExpensesViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblEventName;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UITextField *txtContributedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblContributedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalCost;
@property (weak, nonatomic) IBOutlet UILabel *lblBalance;
@property (weak, nonatomic) IBOutlet UITableView *tblGastos;
@property (weak, nonatomic) IBOutlet UITableView *tblPessoas;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ExpensesViewController {
    NSMutableArray *_expenses;

    //Armazena o objeto (pessoa/gasto) a ser editado
    id objectSelectedToBeEdited;
    UITextField *activeField;
}

- (void)viewDidLoad {
    _lblEventName.text = _controller.event.name;
    [self registerForKeyboardNotifications];

    _scrollView.showsVerticalScrollIndicator = NO;
    [self setEventInfo];

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) swipeLeft {
    [self setEventInfo];
}

#pragma mark - Displayed Info

/* Exibe informacoes do evento. */
- (void)setEventInfo {
    /* Se nada estiver selecionado. */
    [_tblGastos setAllowsMultipleSelection:NO];
    [_tblPessoas setAllowsMultipleSelection:NO];

    objectSelectedToBeEdited = nil;
    [self deselectAllRows:_tblGastos animated:NO];
    [self deselectAllRows:_tblPessoas animated:NO];
    
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
    self.lblInfo.text = @"Valor contribuido:\n\nTotal:\n\nSaldo:";
    self.lblContributedValue.text = [NSString stringWithFormat:@"R$%.2f", contributedValue];
    self.lblTotalCost.text = [NSString stringWithFormat:@"R$%.2f", totalCost];
    self.lblBalance.text = [NSString stringWithFormat:@"R$%.2f", balance];

}

/* Exibe informacoes do participante. */
- (void) setSharerInfo : (Sharer*) sharer {
    /* Quais informacoes a exibir? */
    [self.lblContributedValue setHidden:YES];
    [self.lblTotalCost setHidden:NO];
    [self.lblBalance setHidden:NO];
    [self.txtContributedValue setHidden:NO];

    UITableViewCell *cell = [_tblPessoas cellForRowAtIndexPath:[_tblPessoas indexPathForSelectedRow]];
    [self setSelectedBackgroudColor:cell];

    /* Valores a serem exibidos. */
    float contributedValue, totalCost, balance;
    contributedValue = sharer.contributedValue;
    totalCost = sharer.evaluateBalance;
    balance = contributedValue - totalCost;
    
    for (Expense* expense in sharer.expenses) {
        NSUInteger row = [_controller getExpenseID:expense];
        [_tblGastos selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    
    /* Exibe. */
    self.lblInfo.text = @"Valor contribuido:\n\nTotal gastos:\n\nSaldo:";
    self.txtContributedValue.text = [NSString stringWithFormat:@"%.2f", contributedValue];
    self.lblTotalCost.text = [NSString stringWithFormat:@"R$%.2f", totalCost];
    self.lblBalance.text = [NSString stringWithFormat:@"R$%.2f", balance];
}

/* Exibe informacoes do pagamento. */
- (void) setExpenseInfo : (Expense*) expense {
    /* Quais informacoes a exibir? */
    [self.lblContributedValue setHidden:YES];
    [self.lblTotalCost setHidden:NO];
    [self.lblBalance setHidden:YES];
    [self.txtContributedValue setHidden:YES];

    UITableViewCell *cell = [_tblGastos cellForRowAtIndexPath:[_tblGastos indexPathForSelectedRow]];
    [self setSelectedBackgroudColor:cell];

    /* Valores a serem exibidos. */
    float costPerPerson;
    if (expense.getNumberOfSharers == 0) {
        costPerPerson = expense.value ;
    } else {
        costPerPerson = expense.value / expense.getNumberOfSharers;
    }

    for (Sharer* sharer in expense.sharers) {
        NSUInteger row = [_controller getSharerID:sharer];
        [_tblPessoas selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    
    /* Exibe. */
    self.lblInfo.text = @"Gasto por pessoa:";
    self.lblTotalCost.text = [NSString stringWithFormat:@"R$%.2f", costPerPerson];

}

# pragma mark - Text Field Events

- (IBAction)editingTextBegin:(id)sender {
    activeField = sender;
}

- (IBAction)textValueChanged:(id)sender {
     UITextField *textField = (UITextField*) sender;
    Sharer *sharer = [_controller getSharer:[[_tblPessoas indexPathForSelectedRow] row]];
    sharer.contributedValue = [textField.text floatValue];
}

#pragma mark - Add Buttons

/* Adiciona novo gasto. */
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

        /* Verifica se insiro um nome válido. */
        if (![name compare:@""] || cost == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Dados invalidos!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                /* Implementa o botao cancelar. */
            }];

            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            /* Cria nova expense com nome e custo e adiciona ao evento. Recarrega _tblGastos */
            [_controller addNewExpense:name withValue:cost];
            [_tblGastos reloadData];
        }

        [self setEventInfo];
    }];

    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Insira nome", @"NameExpense");
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Insira custo", @"CostExpense");
        [textField setKeyboardType:UIKeyboardTypePhonePad];
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/* Adiciona novo participante. */
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

        /* Verifica se insiro um nome válido. */
        if (![name compare:@""]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Insira o nome do participante!" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                /* Implementa o botao cancelar. */
            }];

            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            /* Cria um novo participante com "name", adiciona ao evento e recarrega a Table de participantes */
            [_controller addNewSharer:name];
            [_tblPessoas reloadData];
        }

        [self setEventInfo];
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

        Sharer* sharer = _controller.getSharers[indexPath.row];
        cell.textLabel.text = sharer.name;

        [self setDefaultBackgroudColor:cell];

        return cell;
    }

    //cria cell para _tblGastos
    else if([tableView isEqual: _tblGastos]){
        static NSString *cellIdentifier = @"ExpensesCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];

        Expense* expense = _controller.getExpenses[indexPath.row];
        cell.textLabel.text = expense.name;

        NSString* valueInString = [NSString stringWithFormat:@"$%.2f", expense.value];
        cell.detailTextLabel.text = valueInString;

        [self setDefaultBackgroudColor:cell];

        UISwipeGestureRecognizer* leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [cell addGestureRecognizer:leftSwipeGestureRecognizer];
        
        return cell;
    }
    //se chegou aqui eh porque deu merda
    else
        return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual: _tblPessoas])
        return [_controller.getSharers count];
     else if([tableView isEqual: _tblGastos])
        return [_controller.getExpenses count];

    return 0; //soh pra nao correr o risco de nao retornar nada
}

#pragma mark - TableViews Selection Affairs

/* Deseleciona todas as linhas de uma tabela. */
- (void)deselectAllRows:(UITableView *)tableView animated:(BOOL)animated {
    for (NSIndexPath *indexPath in [tableView indexPathsForSelectedRows]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor lightGrayColor];
        [cell setSelectedBackgroundView:bgColorView];
        [tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

/* Permite exclusao de linhas. */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];

    if([tableView isEqual: _tblPessoas]){
        [_controller removeSharer:[_controller getSharer:row]];
        [_tblPessoas reloadData];
    } else if([tableView isEqual: _tblGastos]){
        [_controller removeExpense:[_controller getExpense:row]];
        [_tblGastos reloadData];
    }
    
    [self setEventInfo];
}

/* Mensagem a ser exibida quando se quer apagar uma linha. */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    return @"X";
}

/* Numa tabela que permite selecao de apenas uma linha, permite a deselecao. */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual: _tblPessoas]){
        if (![_tblPessoas allowsMultipleSelection]) {
            [self setDefaultBackgroudColor:[_tblPessoas cellForRowAtIndexPath:[_tblPessoas indexPathForSelectedRow]]];
            [self deselectAllRows:_tblGastos animated:NO];
            if ([_tblPessoas indexPathForSelectedRow] == indexPath) {
                [_tblPessoas deselectRowAtIndexPath:indexPath animated:NO];

                [_tblGastos setAllowsMultipleSelection:NO];

                [self setEventInfo];
                indexPath = nil;
            }
        }
    } else if([tableView isEqual: _tblGastos]){
        if (![_tblGastos allowsMultipleSelection]) {
            [self setDefaultBackgroudColor:[_tblGastos cellForRowAtIndexPath:[_tblGastos indexPathForSelectedRow]]];
            [self deselectAllRows:_tblPessoas animated:NO];
            if ([_tblGastos indexPathForSelectedRow] == indexPath) {
                [_tblGastos deselectRowAtIndexPath:indexPath animated:NO];
                
                [_tblPessoas setAllowsMultipleSelection:NO];
        
                [self setEventInfo];
                indexPath = nil;
            }
        }
    }
    return indexPath;
}

/* Trata o evento de selecionar uma linha. */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];

    if([tableView isEqual: _tblPessoas]){
        /* Se pessoa estiver selecionado. */
        Sharer *sharer = [_controller getSharer:row];

        if (![_tblPessoas allowsMultipleSelection]) {
            /* Estou editando uma pessoa. */
            [_tblGastos setAllowsMultipleSelection:YES];
            objectSelectedToBeEdited = sharer;

            [self setSharerInfo:sharer];
        } else {
            /* Estou vinculando pessoas a um gasto. */
            Expense *expense = objectSelectedToBeEdited;
            [_controller linkExpense: expense ToSharer: sharer];

            [self setExpenseInfo:expense];
        }
    } else if([tableView isEqual: _tblGastos]) {
        /* Se gasto estiver selecionado. */
        Expense *expense = [_controller getExpense:row];

        if (![_tblGastos allowsMultipleSelection]) {
            [_tblPessoas setAllowsMultipleSelection:YES];
            objectSelectedToBeEdited = expense;

            [self setExpenseInfo:expense];
        } else {
            /* Estou vinculando gastos a uma pessoa. */
            Sharer *sharer = objectSelectedToBeEdited;
            [_controller linkExpense: expense ToSharer: sharer];

            [self setSharerInfo:sharer];
        }
        
    }
}

/* Trata o evento de deselecionar uma linha. */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
    if([tableView isEqual: _tblPessoas]){
        if (![_tblGastos allowsMultipleSelection] && [_tblPessoas allowsMultipleSelection]){
            Expense *expense = objectSelectedToBeEdited;
            Sharer *sharer = [_controller getSharer: indexPath.row];
            [_controller unlinkExpense:expense ToSharer:sharer];
            [self setExpenseInfo:expense];
        }
    } else if([tableView isEqual: _tblGastos]){
        if (![_tblPessoas allowsMultipleSelection] && [_tblGastos allowsMultipleSelection]){
            Sharer *sharer = objectSelectedToBeEdited;
            Expense *expense = [_controller getExpense: indexPath.row];
            [_controller unlinkExpense:expense ToSharer:sharer];
            [self setSharerInfo:sharer];
        }
    }
}

#pragma mark - Keyboard Events

/* Atualiza informacoes do participante ao mesmo tempo em que edita valor contribuido. */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    Sharer *sharer = [_controller getSharer:[[_tblPessoas indexPathForSelectedRow]row]];
    [self setSharerInfo:sharer];
    [textField resignFirstResponder];

    return TRUE;
}

/* Ativa a deteccao de teclado sendo exibido. */
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

/* Chamado quando UIKeyboardDidShowNotification foi disparado. */
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;

    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

/* Chamado quando UIKeyboardWillHideNotification foi disparado. */
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Backgroud Color Cells

- (void) setDefaultBackgroudColor : (UITableViewCell*) cell {
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor lightGrayColor];
    [cell setSelectedBackgroundView:bgColorView];
}

- (void) setSelectedBackgroudColor : (UITableViewCell*) cell {
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor redColor];
    [cell setSelectedBackgroundView:bgColorView];
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
