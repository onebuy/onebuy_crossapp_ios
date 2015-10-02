//
//  Transacao.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "Transacao.h"

@implementation Transacao
#pragma mark Métodos Públicos



#pragma mark Métodos Privados
- (void)descriptografar:(NSString *) chaveCriptografia{
        
    self.DataFinal = [Criptografia descriptografarDadosTrafegados:self.DataFinal chaveDescriptografia:chaveCriptografia];
    self.DataInicial = [Criptografia descriptografarDadosTrafegados:self.DataInicial chaveDescriptografia:chaveCriptografia];
    self.NumeroTransacao = [Criptografia descriptografarDadosTrafegados:self.NumeroTransacao chaveDescriptografia:chaveCriptografia];
}

@end
