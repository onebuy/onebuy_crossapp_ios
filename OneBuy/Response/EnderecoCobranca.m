//
//  EnderecoCobranca.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "EnderecoCobranca.h"

@implementation EnderecoCobranca
#pragma mark Métodos Públicos



#pragma mark Métodos Privados
- (void)descriptografar:(NSString *) chaveCriptografia{
    
    self.Bairro = [Criptografia descriptografarDadosTrafegados:self.Bairro chaveDescriptografia:chaveCriptografia];
    self.CEP = [Criptografia descriptografarDadosTrafegados:self.CEP chaveDescriptografia:chaveCriptografia];
    self.Cidade = [Criptografia descriptografarDadosTrafegados:self.Cidade chaveDescriptografia:chaveCriptografia];
    self.Complemento = [Criptografia descriptografarDadosTrafegados:self.Complemento chaveDescriptografia:chaveCriptografia];
    self.Estado = [Criptografia descriptografarDadosTrafegados:self.Estado chaveDescriptografia:chaveCriptografia];
    self.Logradouro = [Criptografia descriptografarDadosTrafegados:self.Logradouro chaveDescriptografia:chaveCriptografia];
    self.Numero = [Criptografia descriptografarDadosTrafegados:self.Numero chaveDescriptografia:chaveCriptografia];
    self.Pais = [Criptografia descriptografarDadosTrafegados:self.Pais chaveDescriptografia:chaveCriptografia];
    self.Telefone = [Criptografia descriptografarDadosTrafegados:self.Telefone chaveDescriptografia:chaveCriptografia];
    self.UF = [Criptografia descriptografarDadosTrafegados:self.UF chaveDescriptografia:chaveCriptografia];
}
@end
