//
//  CapturaPedidoResponse.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 31/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "CapturaPedidoResponse.h"

@implementation CapturaPedidoResponse

#pragma mark Métodos Públicos



#pragma mark Métodos Privados

- (id)initWithJson:(id)jsonRecebido
{
    if( self = [super init] )
    {
        self = [self ConverterCapturaPedidoResponseJSONParaObjeto:jsonRecebido];
    }
    
    return self;
}

- (CapturaPedidoResponse *)ConverterCapturaPedidoResponseJSONParaObjeto:(id)jsonData {
    
    CapturaPedidoResponse *objCapturaPedidoResponse = [[CapturaPedidoResponse alloc] init];
    
    id objRetornoResponse = jsonData[@"RetornoResponse"];
    objCapturaPedidoResponse.RetornoResponse = [[RetornoResponse alloc] init];
    objCapturaPedidoResponse.RetornoResponse.Sucesso =
    [objRetornoResponse[@"Sucesso"] boolValue];
    objCapturaPedidoResponse.RetornoResponse.Mensagem = objRetornoResponse[@"Mensagem"];

    return objCapturaPedidoResponse;
}

#pragma mark Métodos Públicos

@end
