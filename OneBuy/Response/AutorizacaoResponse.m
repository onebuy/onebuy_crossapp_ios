//
//  AutorizacaoResponse.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 27/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "AutorizacaoResponse.h"

@implementation AutorizacaoResponse
#pragma mark Métodos Públicos



#pragma mark Métodos Privados

- (id)initWithJson:(id)jsonRecebido
{
    if( self = [super init] )
    {
        self = [self ConverterAutorizacaoResponseJSONParaObjeto:jsonRecebido];
    }
    
    return self;
}

- (AutorizacaoResponse *)ConverterAutorizacaoResponseJSONParaObjeto:(id)jsonData {
    
    AutorizacaoResponse *objAutorizacaoResponse = [[AutorizacaoResponse alloc] init];
    
    id objRetornoResponse = jsonData[@"RetornoResponse"];
    objAutorizacaoResponse.RetornoResponse = [[RetornoResponse alloc] init];
    objAutorizacaoResponse.RetornoResponse.Sucesso =
    [objRetornoResponse[@"Sucesso"] boolValue];
    objAutorizacaoResponse.RetornoResponse.Mensagem = objRetornoResponse[@"Mensagem"];
    
    //Apenas tenta compor o restante do objeto se a requisição teve sucesso
    if(objAutorizacaoResponse.RetornoResponse.Sucesso)
    {
        objAutorizacaoResponse.CodigoAutorizacaoServidor = jsonData[@"CodigoAutorizacaoServidor"];
        objAutorizacaoResponse.CodigoAutorizacaoCliente = jsonData[@"CodigoAutorizacaoCliente"];
    }
    
    return objAutorizacaoResponse;
}

#pragma mark Métodos Públicos

@end
