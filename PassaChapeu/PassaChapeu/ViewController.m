//
//  ViewController.m
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "ViewController.h"
#import "Controller.h"

@interface ViewController ()

@property Controller *controller;
@property (weak, nonatomic) IBOutlet UITableView *tblEventos;

@end

@implementation ViewController {
    NSMutableArray *_events;
}


- (void)viewDidLoad {
    self.controller = [[Controller alloc] init];
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newEvent:(id)sender {
    /* Abrir uma caixa de texto pedindo nome do evento */
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Insira o nome do evento:" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    //[alert addTextFieldWithConfigurationHandler:nil];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    /*
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Insira nome do evento:" delegate:self cancelButtonTitle:@"Cancelar"  otherButtonTitles:nil];
    [theAlert addButtonWithTitle:@"Ok"];
    [theAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [theAlert ];
    [theAlert show];*/
}


/*
-(IBAction)cadastreEvent(id)sender {


//#pragma mark - Data source
//visualization of events recorded
//New event


 O MAIOR PROBLEMA EH MANTER A COERENCIA DE DADOS (BASE DE DADOS E O QUE ESTÁ SENDO EXIBIDO NA TELA!).
 SE EU ADIOCIONAR NOVO GASTO OU PARTICIPANTE, PRECISO RECARREGAR A TELA???? 
 Pensei em um pickerview que possui inicialmente o usuário inicial(VOCÊ) adicionado no pickerview
 ele deve escrever o nome de um novo usuário e tecla o símbolo mais, assim a barra de rolagem adiciona este 
 posicionando o nome no pickerview. Agora se quiser apagar basta deletar com o botão menos, caso queira adiconar basta colocar mais 
 um e continuar adiconando. Caso tenha terminado basta colocar confirmar(botão)
 */


@end
