//
//  AutorizacaoResponse.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 27/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetornoResponse.h"

@interface AutorizacaoResponse : NSObject
@property (retain) NSString *CodigoAutorizacao;
@property (retain) RetornoResponse *RetornoResponse;

- (id)initWithJson:(id)jsonRecebido;
- (AutorizacaoResponse *)ConverterAutorizacaoResponseJSONParaObjeto:(id)jsonData;

@end
