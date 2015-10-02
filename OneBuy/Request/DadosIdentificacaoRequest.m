//
//  DadosIdentificacaoRequest.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "DadosIdentificacaoRequest.h"
#import "Util.h"

#define PLATAFORMA_ORIGEM @"Mobile"

@implementation DadosIdentificacaoRequest

#pragma mark Métodos Públicos
- (id)init
{
    self = [super init];
    if(self) {
        _IdentificadorUsuario = [Util gerarIdentificadorAparelho];
        _PlataformaOrigem = PLATAFORMA_ORIGEM;
    }
    
    return self;
}


#pragma mark Métodos Privados

@end