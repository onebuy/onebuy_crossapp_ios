//
//  EnderecoCobranca.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Endereco.h"
#import "Criptografia.h"

@interface EnderecoCobranca : Endereco

- (void)descriptografar:(NSString *) chaveCriptografia;
@end
