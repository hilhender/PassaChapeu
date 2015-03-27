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

@end

@implementation ViewController

- (void)viewDidLoad {
    self.controller = [[Controller alloc] init];
    
    //teste do model
    
    
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
