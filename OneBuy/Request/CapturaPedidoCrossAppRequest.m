//
//  CapturaPedidoCrossAppRequest.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 26/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "CapturaPedidoCrossAppRequest.h"

@interface CapturaPedidoCrossAppRequest ()

@property (copy) void (^callbackBlock)(CapturaPedidoResponse *objCapturaPedidoResponse);

@end

@implementation CapturaPedidoCrossAppRequest

#pragma mark Métodos públicos
- (void)capturarPedido:(NSString *) codigoTransacaoGateway pedidoValor: (long long) valorPedido completo:(void (^)(CapturaPedidoResponse *objCapturaPedidoResponse))block
{
    _callbackBlock = block;
    __block CapturaPedidoResponse *objCapturaPedidoResponseRetorno = [[CapturaPedidoResponse alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"%@IntegracaoCrossApp/CapturarPedido", INTEGRACAO_ONEBUY];
    AFHTTPRequestOperationManager *objAFHTTPRequestOperationManager = [AFHTTPRequestOperationManager manager];
    objAFHTTPRequestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *parametrosRequisicao = [NSMutableDictionary dictionary];
    [parametrosRequisicao setObject:[[OneBuy sharedInstance] codigoAutorizacaoCorrente] forKey:@"CodigoAutorizacao"];
    [parametrosRequisicao setValue:codigoTransacaoGateway forKey:@"CodigoTransacaoGateway"];
    [parametrosRequisicao setValue:[NSNumber numberWithLongLong:valorPedido] forKey:@"ValorPedido"];
    [parametrosRequisicao setValue:[[OneBuy sharedInstance] identificadorUsuarioTransacao] forKey:@"IdentificadorUsuarioTransacao"];
    
    [objAFHTTPRequestOperationManager POST:url parameters:parametrosRequisicao success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Sucesso
        objCapturaPedidoResponseRetorno = [[CapturaPedidoResponse alloc] initWithJson:responseObject];

        _callbackBlock(objCapturaPedidoResponseRetorno);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Falha
        NSDictionary *userInfo = [error userInfo];
        NSString *mensagemErro = [[userInfo objectForKey:NSUnderlyingErrorKey] localizedDescription];
        
        //Caso exista algum erro de comunicação
        if(mensagemErro == nil)
        {
            mensagemErro = [userInfo objectForKey:@"NSLocalizedDescription"];
        }
        
        objCapturaPedidoResponseRetorno.RetornoResponse = [[RetornoResponse alloc] init];
        [objCapturaPedidoResponseRetorno.RetornoResponse.Mensagem addObject:mensagemErro];
        _callbackBlock(objCapturaPedidoResponseRetorno);
    }];
}

#pragma mark Métodos Privados
@end
