//
//  CapturaPedidoResponse.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 31/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetornoResponse.h"

@interface CapturaPedidoResponse : NSObject

@property (retain) RetornoResponse *RetornoResponse;

- (id)initWithJson:(id)jsonRecebido;

@end
