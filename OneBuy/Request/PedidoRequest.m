//
//  PedidoRequest.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "PedidoRequest.h"
#import "OneBuy.h"
#import "DadosPedidoItemRequest.h"
#import <AFNetworking/AFNetworking.h>

@interface PedidoRequest ()

@property (copy) void (^callbackBlock)(PedidoResponse *objPedidoResponse);
@property (retain, readonly) DadosIdentificacaoRequest *DadosIdentificacao;
@end

@implementation PedidoRequest

#pragma mark Métodos Públicos

- (id)init
{
    self = [super init];
    if(self) {
        _CodigoAutorizacao = [[OneBuy sharedInstance] codigoAutorizacaoCorrente];
        DadosIdentificacaoRequest *objDadosIdentificacaoRequest = [[DadosIdentificacaoRequest alloc] init];
        _DadosIdentificacao = objDadosIdentificacaoRequest;
    }
    
    return self;
}

- (void)criarPedido:(PedidoRequest *) objPedidoRequest completo:(void (^)(PedidoResponse *objPedidoResponse))block{
    
    _callbackBlock = block;
    
    __block PedidoResponse *objPedidoResponseRetorno = [[PedidoResponse alloc] init];
    
    
    NSString *url = [NSString stringWithFormat:@"%@IntegracaoLoja/CriarPedido", INTEGRACAO_ONEBUY];
    AFHTTPRequestOperationManager *objAFHTTPRequestOperationManager = [AFHTTPRequestOperationManager manager];
    objAFHTTPRequestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];

    //DadosPedido
    NSMutableDictionary *parametrosRequisicaoDadosPedido = [NSMutableDictionary dictionary];
    [parametrosRequisicaoDadosPedido setValue:objPedidoRequest.DadosPedido.NumeroCheckout forKey:@"NumeroCheckout"];
    [parametrosRequisicaoDadosPedido setValue:objPedidoRequest.DadosPedido.NumeroParcelas forKey:@"NumeroParcelas"];
    [parametrosRequisicaoDadosPedido setValue:objPedidoRequest.DadosPedido.FormaPagamento forKey:@"FormaPagamento"];
    [parametrosRequisicaoDadosPedido setValue:objPedidoRequest.DadosPedido.NumeroPedidoLoja forKey:@"NumeroPedidoLoja"];
    [parametrosRequisicaoDadosPedido setValue:[NSNumber numberWithLongLong:objPedidoRequest.DadosPedido.Valor] forKey:@"Valor"];
    [parametrosRequisicaoDadosPedido setValue:[NSNumber numberWithLongLong:objPedidoRequest.DadosPedido.ValorFrete] forKey:@"ValorFrete"];
    
     NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    if(objPedidoRequest.DadosPedido != nil && objPedidoRequest.DadosPedido.PedidoItens != nil)
    {
        for (int i = 0; i < objPedidoRequest.DadosPedido.PedidoItens.count; i++) {
            
            DadosPedidoItemRequest *objDadosPedidoItemRequest = objPedidoRequest.DadosPedido.PedidoItens[i];
            NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
            
            [tempDictionary setValue:objDadosPedidoItemRequest.Id forKey:@"Id"];
            [tempDictionary setValue:objDadosPedidoItemRequest.Nome forKey:@"Nome"];
            [tempDictionary setValue:[NSNumber numberWithInt:objDadosPedidoItemRequest.Valor] forKey:@"Valor"];
            [tempDictionary setValue:[NSNumber numberWithInt:objDadosPedidoItemRequest.Quantidade] forKey:@"Quantidade"];
            
            [tempArray addObject:tempDictionary];
        }
    }
    else
    {
        //Nada a fazer.
    }
    
    [parametrosRequisicaoDadosPedido setValue:tempArray forKey:@"PedidoItens"];
    
    //DadosIdentificacaoRequest
    NSMutableDictionary *parametrosRequisicaoDadosIdentificacao = [NSMutableDictionary dictionary];
    [parametrosRequisicaoDadosIdentificacao setValue:objPedidoRequest.DadosIdentificacao.IdentificadorUsuario forKey:@"IdentificadorUsuario"];
    [parametrosRequisicaoDadosIdentificacao setValue:objPedidoRequest.DadosIdentificacao.PlataformaOrigem forKey:@"PlataformaOrigem"];
    
    //DadosAntiFraude
    NSMutableDictionary *parametrosRequisicaoDadosAntiFraude = nil;
    NSMutableDictionary *parametrosRequisicaoDadosAntiFraudeEnderecoEntrega = nil;
    if(objPedidoRequest.DadosAntiFraude != nil && objPedidoRequest.DadosAntiFraude.EnderecoEntrega != nil)
    {
        parametrosRequisicaoDadosAntiFraudeEnderecoEntrega = [NSMutableDictionary dictionary];
        
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:[NSNumber numberWithInt:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Cep] forKey:@"Cep"];
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Pais forKey:@"Pais"];
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Estado forKey:@"Estado"];
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Pais forKey:@"Pais"];
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Cidade forKey:@"Cidade"];
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Bairro forKey:@"Bairro"];
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Rua forKey:@"Rua"];
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Numero forKey:@"Numero"];
        [parametrosRequisicaoDadosAntiFraudeEnderecoEntrega setValue:objPedidoRequest.DadosAntiFraude.EnderecoEntrega.Complemento forKey:@"Complemento"];
        
        
        parametrosRequisicaoDadosAntiFraude = [NSMutableDictionary dictionary];
        [parametrosRequisicaoDadosAntiFraude setValue:parametrosRequisicaoDadosAntiFraudeEnderecoEntrega forKey:@"EnderecoEntrega"];
    }
    
    NSDictionary *parametrosRequisicao =[NSDictionary dictionaryWithObjectsAndKeys:
                           objPedidoRequest.CodigoAutorizacao, @"CodigoAutorizacao",
                           parametrosRequisicaoDadosPedido, @"DadosPedido",
                           parametrosRequisicaoDadosIdentificacao, @"DadosIdentificacao",
                           parametrosRequisicaoDadosAntiFraude, @"DadosAntiFraude",
                           nil];
    
    [objAFHTTPRequestOperationManager POST:url parameters:parametrosRequisicao success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Sucesso
        
        objPedidoResponseRetorno = [[PedidoResponse alloc] initWithJson:responseObject];
        
        _callbackBlock(objPedidoResponseRetorno);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Falha
        NSDictionary *userInfo = [error userInfo];
        NSString *mensagemErro = [[userInfo objectForKey:NSUnderlyingErrorKey] localizedDescription];
        
        //Caso exista algum erro de comunicação
        if(mensagemErro == nil)
        {
            mensagemErro = [userInfo objectForKey:@"NSLocalizedDescription"];
        }
        
        objPedidoResponseRetorno.RetornoResponse = [[RetornoResponse alloc] init];
        [objPedidoResponseRetorno.RetornoResponse.Mensagem addObject:mensagemErro];
        _callbackBlock(objPedidoResponseRetorno);
    }];
}


#pragma mark Métodos Privados

@end
