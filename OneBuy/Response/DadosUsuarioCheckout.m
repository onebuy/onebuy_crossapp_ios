//
//  DadosUsuarioCheckout.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "DadosUsuarioCheckout.h"

@implementation DadosUsuarioCheckout

#pragma mark Métodos Públicos



#pragma mark Métodos Privados
- (void)descriptografar:(NSString *) chaveCriptografia{
    
    self.Apelido = [Criptografia descriptografarDadosTrafegados:self.Apelido chaveDescriptografia:chaveCriptografia];
    self.CPF = [Criptografia descriptografarDadosTrafegados:self.CPF chaveDescriptografia:chaveCriptografia];
    self.CPFCodificado = [Criptografia descriptografarDadosTrafegados:self.CPFCodificado chaveDescriptografia:chaveCriptografia];
    self.Celular = [Criptografia descriptografarDadosTrafegados:self.Celular chaveDescriptografia:chaveCriptografia];
    self.DataNascimento = [Criptografia descriptografarDadosTrafegados:self.DataNascimento chaveDescriptografia:chaveCriptografia];
    self.Email = [Criptografia descriptografarDadosTrafegados:self.Email chaveDescriptografia:chaveCriptografia];
    self.EmailCodificado = [Criptografia descriptografarDadosTrafegados:self.EmailCodificado chaveDescriptografia:chaveCriptografia];
    self.IdentificadorUsuarioCodificado = [Criptografia descriptografarDadosTrafegados:self.IdentificadorUsuarioCodificado chaveDescriptografia:chaveCriptografia];
    self.Idioma = [Criptografia descriptografarDadosTrafegados:self.Idioma chaveDescriptografia:chaveCriptografia];
    self.NomeCompleto = [Criptografia descriptografarDadosTrafegados:self.NomeCompleto chaveDescriptografia:chaveCriptografia];
    self.RG = [Criptografia descriptografarDadosTrafegados:self.RG chaveDescriptografia:chaveCriptografia];
    self.RGOrgaoEmissor = [Criptografia descriptografarDadosTrafegados:self.RGOrgaoEmissor chaveDescriptografia:chaveCriptografia];
    self.SenhaUsuarioCodificado = [Criptografia descriptografarDadosTrafegados:self.SenhaUsuarioCodificado chaveDescriptografia:chaveCriptografia];
    self.Sexo = [Criptografia descriptografarDadosTrafegados:self.Sexo chaveDescriptografia:chaveCriptografia];
    self.Telefone = [Criptografia descriptografarDadosTrafegados:self.Telefone chaveDescriptografia:chaveCriptografia];
    
    [self.Transacao descriptografar:chaveCriptografia];
    //[self.ProgramasMilhagem descriptografar:chaveCriptografia];
    [self.EnderecoEntrega descriptografar:chaveCriptografia];
    [self.EnderecoCobranca descriptografar:chaveCriptografia];
    [self.Cartao descriptografar:chaveCriptografia];
}


@end
