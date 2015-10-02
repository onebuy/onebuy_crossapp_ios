//
//  Cartao.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "Cartao.h"

@implementation Cartao
#pragma mark Métodos Públicos



#pragma mark Métodos Privados
- (void)descriptografar:(NSString *) chaveCriptografia{
    
    self.Bandeira = [Criptografia descriptografarDadosTrafegados:self.Bandeira chaveDescriptografia:chaveCriptografia];
    self.NumeroCartaoMascarado = [Criptografia descriptografarDadosTrafegados:self.NumeroCartaoMascarado chaveDescriptografia:chaveCriptografia];
}
@end
