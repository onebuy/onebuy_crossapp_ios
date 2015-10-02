//
//  SondaPedidoResponse.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 31/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "SondaPedidoResponse.h"

@implementation SondaPedidoResponse
#pragma mark Métodos Públicos



#pragma mark Métodos Privados

- (id)initWithJson:(id)jsonRecebido
{
    if( self = [super init] )
    {
        self = [self ConverterSondaPedidoResponseJSONParaObjeto:jsonRecebido];
    }
    
    return self;
}

- (SondaPedidoResponse *)ConverterSondaPedidoResponseJSONParaObjeto:(id)jsonData {
    
    SondaPedidoResponse *objSondaPedidoResponse = [[SondaPedidoResponse alloc] init];
    
    id objRetornoResponse = jsonData[@"RetornoResponse"];
    objSondaPedidoResponse.RetornoResponse = [[RetornoResponse alloc] init];
    objSondaPedidoResponse.RetornoResponse.Sucesso =
    [objRetornoResponse[@"Sucesso"] boolValue];
    objSondaPedidoResponse.RetornoResponse.Mensagem = objRetornoResponse[@"Mensagem"];
    
    //Apenas tenta compor o restante do objeto se a requisição teve sucesso
    if(objSondaPedidoResponse.RetornoResponse.Sucesso)
    {
        objSondaPedidoResponse.Status = jsonData[@"Status"];
        objSondaPedidoResponse.CodigoStatus = [jsonData[@"CodigoStatus"] intValue];
        objSondaPedidoResponse.NumeroPedidoLoja = jsonData[@"NumeroPedidoLoja"];
        objSondaPedidoResponse.CodigoTransacaoGateway = jsonData[@"CodigoTransacaoGateway"];
        objSondaPedidoResponse.CodigoAutorizacao = jsonData[@"CodigoAutorizacao"];

        id objDadosCartaoResponse = objRetornoResponse[@"DadosCartao"];
        
        objSondaPedidoResponse.DadosCartao = [[DadosCartaoManager alloc] init];
        objSondaPedidoResponse.DadosCartao.Bandeira = objDadosCartaoResponse[@"Bandeira"];
        objSondaPedidoResponse.DadosCartao.NumeroCartaoMascarado = objDadosCartaoResponse[@"NumeroCartaoMascarado"];
        objSondaPedidoResponse.DadosCartao.CodigoMeioPagamento = objDadosCartaoResponse[@"CodigoMeioPagamento"];
        objSondaPedidoResponse.DadosCartao.MeioPagamento = objDadosCartaoResponse[@"MeioPagamento"];
        
    }
    
    return objSondaPedidoResponse;
}

#pragma mark Métodos Públicos

@end
