//
//  OneBuy.m
//  OneBuy
//
//  Created by Andre Luiz Costa on 17/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "OneBuy.h"
#import "Util/Util.h"
#import "Request/AutorizacaoCrossAppRequest.h"
#import "Request/CheckoutOneBuyDadosRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "DadosPedidoItemRequest.h"
#import "CapturaPedidoCrossAppRequest.h"
#import "SondaPedidoRequest.h"

@interface OneBuy()

@property (copy) void (^callbackPedido)(PedidoResponse *objPedidoResponse);
@property (copy) void (^callbackAuth)(RetornoResponse *objRetornoResponse);
@property (copy) void (^callbackCkeckOut)(CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse);
@property (copy) void (^callbackCaptura)(CapturaPedidoResponse *objCapturaPedidoResponse);
@property (copy) void (^callbackSonda)(SondaPedidoResponse *objSondaPedidoResponse);

@end

@implementation OneBuy

static OneBuy *sharedInstance = nil;

+ (OneBuy *)sharedInstance {
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[OneBuy alloc] init];
        sharedInstance.cultura = CULTURA_INTERNACIONALIZACAO;
    });
    
    return sharedInstance;
}


#pragma mark Métodos Públicos
- (void)abrirAppOneBuy:(TipoOperacaoAppOneBuy)objTipoOperacaoAppOneBuy comURLRetorno: (NSString *) urlRetorno completo:(void (^)(RetornoResponse *objRetornoResponse)) block {
    
    __block RetornoResponse *objRetornoResponse = [[RetornoResponse alloc] init];
    _callbackAuth = block;

    if(objTipoOperacaoAppOneBuy == ObterToken)
    {
        //Abrindo o app OneBuy para realizar a geração de um novo token OneBuy
        
        [[OneBuy sharedInstance] setCodigoAutorizacaoServidor:nil];
        [[OneBuy sharedInstance] setNumeroTransacaoCheckout:nil];
        [[OneBuy sharedInstance] setIdentificadorUsuarioTransacao:nil];
        [[OneBuy sharedInstance] setCodigoAutorizacaoCliente:nil];
        
        //Obtem autorização no servidor OneBuy
        [[OneBuy sharedInstance] setIdentificadorUsuarioTransacao:[Util gerarIdentificadorTransacao]];
        
        AutorizacaoCrossAppRequest *objAutorizacaoCrossAppRequest = [[AutorizacaoCrossAppRequest alloc] init];
        [objAutorizacaoCrossAppRequest obterAutorizacao:^(AutorizacaoResponse *objAutorizacaoResponse) {
            
            objRetornoResponse = objAutorizacaoResponse.RetornoResponse;
            
            if(objAutorizacaoResponse.RetornoResponse.Sucesso)
            {
                [[OneBuy sharedInstance] setCodigoAutorizacaoServidor:objAutorizacaoResponse.CodigoAutorizacaoServidor];
                [[OneBuy sharedInstance] setCodigoAutorizacaoCliente:objAutorizacaoResponse.CodigoAutorizacaoCliente];
                //Tentamos abrir a aplicação OneBuy se existir um código de autorização corrente
                
                if([[OneBuy sharedInstance] codigoAutorizacaoServidor] != nil)
                {
                    [OneBuy abrirURLAplicacaoOneBuy:objTipoOperacaoAppOneBuy comCodigoAutorizacao:objAutorizacaoResponse.CodigoAutorizacaoCliente eComURLRetorno:urlRetorno];
                }else{
                    //Nada a fazer. A mensagem de retorno poderá ser usada pelo lojista para identificar o problema.
                }
            } else {
                
            }
            _callbackAuth(objRetornoResponse);
            
        }];
    }
    else
    {
        //Abrindo o app OneBuy para realizar a sonda e aprovação do pedido.
        [OneBuy abrirURLAplicacaoOneBuy:objTipoOperacaoAppOneBuy comCodigoAutorizacao:[[OneBuy sharedInstance] codigoAutorizacaoCliente] eComURLRetorno:urlRetorno];
        
        objRetornoResponse.Sucesso = YES;
        _callbackAuth(objRetornoResponse);
    }
}

- (void)realizarCheckOut:(NSString *) tokenOneBuyCriptografado completo:(void (^)(CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse)) block {
    
    _callbackCkeckOut = block;
    
    //Descriptografar o token recebido
    NSString *tokenDescriptografado = [AESCrypt decrypt:tokenOneBuyCriptografado password:[[OneBuy sharedInstance] identificadorUsuarioTransacao]];
    
    CheckoutOneBuyDadosRequest *objCheckoutOneBuyDadosRequest = [[CheckoutOneBuyDadosRequest alloc] init];
    [objCheckoutOneBuyDadosRequest realizarCheckoutOneBuyComToken:tokenDescriptografado completo:^(CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse) {
        
        _callbackCkeckOut(objCheckoutOneBuyDadosResponse);
    }];
}

- (void)criarPedido:(PedidoRequest *) objPedidoRequest completo:(void (^)(PedidoResponse *objPedidoResponse)) block{
    
    _callbackPedido = block;
    
    [objPedidoRequest criarPedido:objPedidoRequest completo:^(PedidoResponse *objPedidoResponse) {
        
        _callbackPedido(objPedidoResponse);
    }];
}

- (void)capturarPedido:(NSString *) codigoTransacaoGateway pedidoValor: (long long) valorPedido completo:(void (^)(CapturaPedidoResponse *objCapturaPedidoResponse)) block{
    
    _callbackCaptura = block;
    
    CapturaPedidoCrossAppRequest *objCapturaPedidoCrossAppRequest = [[CapturaPedidoCrossAppRequest alloc] init];
    [objCapturaPedidoCrossAppRequest capturarPedido:codigoTransacaoGateway pedidoValor:valorPedido completo:^(CapturaPedidoResponse *objCapturaPedidoResponse) {
        _callbackCaptura(objCapturaPedidoResponse);
    }];
}

- (void)sondarPedido:(NSString *) codigoTransacaoGateway completo:(void (^)(SondaPedidoResponse *objSondaPedidoResponse)) block{
    
    _callbackSonda = block;
    
    SondaPedidoRequest *objSondaPedidoRequest = [[SondaPedidoRequest alloc] init];
    [objSondaPedidoRequest sondarPedido:codigoTransacaoGateway completo:^(SondaPedidoResponse *objSondaPedidoResponse) {
        _callbackSonda(objSondaPedidoResponse);
    }];
}

#pragma mark Métodos Privados
+ (void) abrirURLAplicacaoOneBuy:(TipoOperacaoAppOneBuy)objTipoOperacaoAppOneBuy comCodigoAutorizacao: (NSString *) codigoAutorizacao eComURLRetorno:(NSString *) urlRetorno{
    
    //if([self verificarInstaladoAppOneBuy]){
        
        if(objTipoOperacaoAppOneBuy == ObterToken)
        {
            NSString *queryCodAutorizacaoUrlRetorno = [[NSString alloc] initWithFormat: @"?CodigoAutorizacao$%@&URLRetorno$%@", codigoAutorizacao, urlRetorno];
            
            NSString *url = [URL_APLICACAO_ONEBUY stringByAppendingString: queryCodAutorizacaoUrlRetorno];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
         }
        else
        {
            NSString *queryUrlRetorno = [[NSString alloc] initWithFormat: @"?URLRetorno$%@", urlRetorno];
            
            NSString *url = [URL_APLICACAO_ONEBUY stringByAppendingString: queryUrlRetorno];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    //}else {
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_APP_STORE_ONEBUY]];
    //}
}

+(BOOL) verificarInstaladoAppOneBuy{
    
    BOOL appInstalado = [[UIApplication sharedApplication]
                           canOpenURL: [NSURL URLWithString:@"onebuy"]];
    
    return appInstalado;
}
@end
