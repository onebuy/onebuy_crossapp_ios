//
//  CheckoutOneBuyDadosResponse.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "CheckoutOneBuyDadosResponse.h"

@implementation CheckoutOneBuyDadosResponse
#pragma mark Métodos Públicos



#pragma mark Métodos Privados

- (id)initWithJson:(id)jsonRecebido
{
    if( self = [super init] )
    {
        self = [self ConverterDadosUsuarioCheckoutJSONParaObjeto:jsonRecebido];
    }
    
    return self;
}

- (CheckoutOneBuyDadosResponse *)ConverterDadosUsuarioCheckoutJSONParaObjeto:(id)jsonData {
    
    CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse = [[CheckoutOneBuyDadosResponse alloc] init];
    
    id objRetornoResponse = jsonData[@"RetornoResponse"];
    
    objCheckoutOneBuyDadosResponse.RetornoResponse = [[RetornoResponse alloc] init];
    objCheckoutOneBuyDadosResponse.RetornoResponse.Sucesso =
    [objRetornoResponse[@"Sucesso"] boolValue];
    objCheckoutOneBuyDadosResponse.RetornoResponse.Mensagem = objRetornoResponse[@"Mensagem"];
    
    //Apenas tenta compor o restante do objeto se a requisição teve sucesso
    if(objCheckoutOneBuyDadosResponse.RetornoResponse.Sucesso)
    {
        id objDadosUsuarioCheckout = jsonData[@"DadosUsuarioCheckout"];
        
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout = [[DadosUsuarioCheckout alloc] init];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.IdTransacao = objDadosUsuarioCheckout[@"IdTransacao"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Apelido = objDadosUsuarioCheckout[@"Apelido"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.CPF = objDadosUsuarioCheckout[@"CPF"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.CPFCodificado = objDadosUsuarioCheckout[@"CPFCodificado"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Celular = objDadosUsuarioCheckout[@"Celular"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.DataNascimento = objDadosUsuarioCheckout[@"DataNascimento"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Email = objDadosUsuarioCheckout[@"Email"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EmailCodificado = objDadosUsuarioCheckout[@"EmailCodificado"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.IdentificadorUsuarioCodificado = objDadosUsuarioCheckout[@"IdentificadorUsuarioCodificado"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Idioma = objDadosUsuarioCheckout[@"Idioma"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.NomeCompleto = objDadosUsuarioCheckout[@"NomeCompleto"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.RG = objDadosUsuarioCheckout[@"RG"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.RGOrgaoEmissor = objDadosUsuarioCheckout[@"RGOrgaoEmissor"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.SenhaUsuarioCodificado = objDadosUsuarioCheckout[@"SenhaUsuarioCodificado"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Sexo = objDadosUsuarioCheckout[@"Sexo"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Telefone = objDadosUsuarioCheckout[@"Telefone"];
        
        //Transação checkout
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Transacao = [[Transacao alloc] init];
        id objTransacaoResponse = objDadosUsuarioCheckout[@"Transacao"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Transacao.NumeroTransacao = objTransacaoResponse[@"NumeroTransacao"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Transacao.DataInicial = objTransacaoResponse[@"DataInicial"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Transacao.DataFinal = objTransacaoResponse[@"DataFinal"];
        
        //Programa de milhagem
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.ProgramasMilhagem = [[ProgramasMilhagem alloc] init];
        //id objProgramasMilhagemResponse = objDadosUsuarioCheckout[@"ProgramasMilhagem"];
        
        //Endereço de cobrança
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca = [[EnderecoCobranca alloc] init];
        id objEnderecoCobrancaResponse = objDadosUsuarioCheckout[@"EnderecoCobranca"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.Bairro = objEnderecoCobrancaResponse[@"Bairro"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.CEP = objEnderecoCobrancaResponse[@"CEP"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.Cidade = objEnderecoCobrancaResponse[@"Cidade"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.Complemento = objEnderecoCobrancaResponse[@"Complemento"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.Estado = objEnderecoCobrancaResponse[@"Estado"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.Logradouro = objEnderecoCobrancaResponse[@"Logradouro"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.Numero = objEnderecoCobrancaResponse[@"Numero"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.Pais = objEnderecoCobrancaResponse[@"Pais"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.Telefone = objEnderecoCobrancaResponse[@"Telefone"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoCobranca.UF = objEnderecoCobrancaResponse[@"UF"];
        
        //Endereço de entrega
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega = [[EnderecoEntrega alloc] init];
        id objEnderecoEntregaResponse = objDadosUsuarioCheckout[@"EnderecoEntrega"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Bairro = objEnderecoEntregaResponse[@"Bairro"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Destinatario = objEnderecoEntregaResponse[@"Destinatario"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.CEP = objEnderecoEntregaResponse[@"CEP"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Cidade = objEnderecoEntregaResponse[@"Cidade"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Complemento = objEnderecoEntregaResponse[@"Complemento"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Estado = objEnderecoEntregaResponse[@"Estado"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Logradouro = objEnderecoEntregaResponse[@"Logradouro"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Numero = objEnderecoEntregaResponse[@"Numero"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Pais = objEnderecoEntregaResponse[@"Pais"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.Telefone = objEnderecoEntregaResponse[@"Telefone"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.EnderecoEntrega.UF = objEnderecoEntregaResponse[@"UF"];
        
        
        //Cartão
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Cartao = [[Cartao alloc] init];
        id objCartaoResponse = objDadosUsuarioCheckout[@"Cartao"];
        
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Cartao.Bandeira = objCartaoResponse[@"Bandeira"];
        objCheckoutOneBuyDadosResponse.DadosUsuarioCheckout.Cartao.NumeroCartaoMascarado = objCartaoResponse[@"NumeroCartaoMascarado"];
    }
    
    return objCheckoutOneBuyDadosResponse;
}

- (void)descriptografar:(NSString *) chaveCriptografia{

    [self.DadosUsuarioCheckout descriptografar:chaveCriptografia];
}
@end
