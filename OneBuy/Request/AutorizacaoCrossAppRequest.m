//
//  AutorizacaoCrossAppRequest.m
//  OneBuy
//
//  Created by Andre Luiz Costa on 18/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "OneBuy.h"
#import "AutorizacaoCrossAppRequest.h"


@interface AutorizacaoCrossAppRequest ()

@property (retain) NSString *codigoIntegracaoLoja;
@property (retain) NSString *cultura;
@property (retain) NSString *identificadorTransacao;

@property (copy) void (^callbackBlock)(AutorizacaoResponse *objAutorizacaoResponse);

@end

@implementation AutorizacaoCrossAppRequest

#pragma mark Métodos públicos

- (void)obterAutorizacao:(void (^)(AutorizacaoResponse *objAutorizacaoResponse))block
{
    _callbackBlock = block;
    __block AutorizacaoResponse *objAutorizacaoResponseRetorno = [[AutorizacaoResponse alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"%@IntegracaoCrossApp/ObterAutorizacao", INTEGRACAO_ONEBUY];
    AFHTTPRequestOperationManager *objAFHTTPRequestOperationManager = [AFHTTPRequestOperationManager manager];
    objAFHTTPRequestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *parametrosRequisicao = [NSMutableDictionary dictionary];
    [parametrosRequisicao setObject:[[OneBuy sharedInstance] chaveLoja] forKey:@"CodigoIntegracaoLoja"];
    [parametrosRequisicao setObject:[[OneBuy sharedInstance] cultura] forKey:@"Cultura"];
    [parametrosRequisicao setObject:[[OneBuy sharedInstance] identificadorUsuarioTransacao] forKey:@"IdentificadorUsuarioTransacao"];
    
    [objAFHTTPRequestOperationManager POST:url parameters:parametrosRequisicao success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        //Sucesso
        AutorizacaoResponse *objAutorizacaoResponse = [[AutorizacaoResponse alloc] initWithJson:responseObject];
        
        objAutorizacaoResponseRetorno = objAutorizacaoResponse;
        
        _callbackBlock(objAutorizacaoResponseRetorno);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Falha
        NSDictionary *userInfo = [error userInfo];
        NSString *mensagemErro = [[userInfo objectForKey:NSUnderlyingErrorKey] localizedDescription];
        
        //Caso exista algum erro de comunicação
        if(mensagemErro == nil)
        {
            mensagemErro = [userInfo objectForKey:@"NSLocalizedDescription"];
        }
        
        objAutorizacaoResponseRetorno.RetornoResponse = [[RetornoResponse alloc] init];
        [objAutorizacaoResponseRetorno.RetornoResponse.Mensagem addObject:mensagemErro];
        _callbackBlock(objAutorizacaoResponseRetorno);
    }];
}

#pragma mark Métodos Privados

@end
