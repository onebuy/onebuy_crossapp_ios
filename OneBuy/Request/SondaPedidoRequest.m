//
//  SondaPedidoRequest.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 26/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "SondaPedidoRequest.h"

@interface SondaPedidoRequest ()

@property (copy) void (^callbackBlock)(SondaPedidoResponse *objSondaPedidoResponse);

@end

@implementation SondaPedidoRequest

#pragma mark Métodos públicos
- (void)sondarPedido:(NSString *) codigoTransacaoGateway completo:(void (^)(SondaPedidoResponse *objSondaPedidoResponse))block
{
    _callbackBlock = block;
    __block SondaPedidoResponse *objSondaPedidoResponseRetorno = [[SondaPedidoResponse alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"%@IntegracaoLoja/SondarPedido", INTEGRACAO_ONEBUY];
    AFHTTPRequestOperationManager *objAFHTTPRequestOperationManager = [AFHTTPRequestOperationManager manager];
    objAFHTTPRequestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *parametrosRequisicao = [NSMutableDictionary dictionary];
    [parametrosRequisicao setObject:[[OneBuy sharedInstance] codigoAutorizacaoServidor] forKey:@"CodigoAutorizacaoServidor"];
    [parametrosRequisicao setValue:codigoTransacaoGateway forKey:@"CodigoTransacaoGateway"];
    
    [objAFHTTPRequestOperationManager POST:url parameters:parametrosRequisicao success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Sucesso
        objSondaPedidoResponseRetorno = [[SondaPedidoResponse alloc] initWithJson:responseObject];
        
        _callbackBlock(objSondaPedidoResponseRetorno);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Falha
        NSDictionary *userInfo = [error userInfo];
        NSString *mensagemErro = [[userInfo objectForKey:NSUnderlyingErrorKey] localizedDescription];
        
        //Caso exista algum erro de comunicação
        if(mensagemErro == nil)
        {
            mensagemErro = [userInfo objectForKey:@"NSLocalizedDescription"];
        }
        
        objSondaPedidoResponseRetorno.RetornoResponse = [[RetornoResponse alloc] init];
        [objSondaPedidoResponseRetorno.RetornoResponse.Mensagem addObject:mensagemErro];
        _callbackBlock(objSondaPedidoResponseRetorno);
    }];
}

#pragma mark Métodos Privados
@end
