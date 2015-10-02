//
//  PedidoResponse.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "PedidoResponse.h"

@implementation PedidoResponse
#pragma mark Métodos Públicos



#pragma mark Métodos Privados

- (id)initWithJson:(id)jsonRecebido
{
    if( self = [super init] )
    {
        self = [self ConverterPedidoResponseJSONParaObjeto:jsonRecebido];
    }
    
    return self;
}

- (PedidoResponse *)ConverterPedidoResponseJSONParaObjeto:(id)jsonData {
    
    PedidoResponse *objPedidoResponse = [[PedidoResponse alloc] init];
    
    id objRetornoResponse = jsonData[@"RetornoResponse"];
    objPedidoResponse.RetornoResponse = [[RetornoResponse alloc] init];
    objPedidoResponse.RetornoResponse.Sucesso =
    [objRetornoResponse[@"Sucesso"] boolValue];
    objPedidoResponse.RetornoResponse.Mensagem = objRetornoResponse[@"Mensagem"];
    
    //Apenas tenta compor o restante do objeto se a requisição teve sucesso
    if(objPedidoResponse.RetornoResponse.Sucesso)
    {
        objPedidoResponse.CodigoTransacaoGateway = jsonData[@"CodigoTransacaoGateway"];
        objPedidoResponse.CodigoTransacaoAdquirente = jsonData[@"CodigoTransacaoAdquirente"];
        objPedidoResponse.CodigoAutorizacao = jsonData[@"CodigoAutorizacao"];
        objPedidoResponse.BandeiraCartao = jsonData[@"BandeiraCartao"];
        objPedidoResponse.NumeroCartaoMascarado = jsonData[@"NumeroCartaoMascarado"];
        objPedidoResponse.Valor = [jsonData[@"Valor"] longLongValue];
    }

    return objPedidoResponse;
}

@end
