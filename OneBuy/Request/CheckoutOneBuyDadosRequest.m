//
//  CheckoutOneBuyDadosRequest.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "CheckoutOneBuyDadosRequest.h"
#import "Util.h"

@interface CheckoutOneBuyDadosRequest ()

@property (copy) void (^callbackBlock)(CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse);

@end

@implementation CheckoutOneBuyDadosRequest

#pragma mark Métodos públicos
- (void)realizarCheckoutOneBuyComToken:(NSString *) tokenOneBuy completo:(void (^)(CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse))block
{
    _callbackBlock = block;
    __block CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponseRetorno = [[CheckoutOneBuyDadosResponse alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"%@IntegracaoCrossApp/RealizarCheckoutOneBuyCrossApp", INTEGRACAO_ONEBUY];
    AFHTTPRequestOperationManager *objAFHTTPRequestOperationManager = [AFHTTPRequestOperationManager manager];
    objAFHTTPRequestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *parametrosRequisicao = [NSMutableDictionary dictionary];
    [parametrosRequisicao setObject:[[OneBuy sharedInstance] codigoAutorizacaoServidor] forKey:@"CodigoAutorizacaoServidor"];
    [parametrosRequisicao setObject:[[OneBuy sharedInstance] codigoAutorizacaoCliente] forKey:@"codigoAutorizacaoCliente"];
    [parametrosRequisicao setValue:tokenOneBuy forKey:@"TokenOneBuy"];
    [parametrosRequisicao setValue:[[OneBuy sharedInstance] identificadorUsuarioTransacao] forKey:@"IdentificadorUsuarioTransacao"];
    
    [objAFHTTPRequestOperationManager POST:url parameters:parametrosRequisicao success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Sucesso
        CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse = [[CheckoutOneBuyDadosResponse alloc] initWithJson:responseObject];
        
        objCheckoutOneBuyDadosResponseRetorno = objCheckoutOneBuyDadosResponse;
        
        if(objCheckoutOneBuyDadosResponseRetorno.RetornoResponse.Sucesso)
        {           
            [[OneBuy sharedInstance] setNumeroTransacaoCheckout:objCheckoutOneBuyDadosResponseRetorno.DadosUsuarioCheckout.Transacao.NumeroTransacao];
        }
        else
        {
            //Nada a fazer
        }
        
        _callbackBlock(objCheckoutOneBuyDadosResponseRetorno);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Falha
        NSDictionary *userInfo = [error userInfo];
        NSString *mensagemErro = [[userInfo objectForKey:NSUnderlyingErrorKey] localizedDescription];
        
        //Caso exista algum erro de comunicação
        if(mensagemErro == nil)
        {
            mensagemErro = [userInfo objectForKey:@"NSLocalizedDescription"];
        }
        
        objCheckoutOneBuyDadosResponseRetorno.RetornoResponse = [[RetornoResponse alloc] init];
        [objCheckoutOneBuyDadosResponseRetorno.RetornoResponse.Mensagem addObject:mensagemErro];
        _callbackBlock(objCheckoutOneBuyDadosResponseRetorno);
    }];
}

#pragma mark Métodos Privados

@end

