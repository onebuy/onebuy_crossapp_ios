//
//  DadosUsuarioCheckout.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transacao.h"
#import "Cartao.h"
#import "ProgramasMilhagem.h"
#import "EnderecoCobranca.h"
#import "EnderecoEntrega.h"
#import "Criptografia.h"

@interface DadosUsuarioCheckout : NSObject
@property (retain) NSString *Apelido;
@property (retain) NSString *CPF;
@property (retain) NSString *CPFCodificado;
@property (retain) NSString *Celular;
@property (retain) NSString *DataNascimento;
@property (retain) NSString *Email;
@property (retain) NSString *EmailCodificado;
@property (retain) NSString *IdTransacao;
@property (retain) NSString *IdentificadorUsuarioCodificado;
@property (retain) NSString *Idioma;
@property (retain) NSString *NomeCompleto;
@property (retain) NSString *RG;
@property (retain) NSString *RGOrgaoEmissor;
@property (retain) NSString *SenhaUsuarioCodificado;
@property (retain) NSString *Sexo;
@property (retain) NSString *Telefone;
@property (retain) Transacao *Transacao;
@property (retain) Cartao *Cartao;
@property (retain) ProgramasMilhagem *ProgramasMilhagem;
@property (retain) EnderecoCobranca *EnderecoCobranca;
@property (retain) EnderecoEntrega *EnderecoEntrega;

- (void)descriptografar:(NSString *) chaveCriptografia;
    
@end
