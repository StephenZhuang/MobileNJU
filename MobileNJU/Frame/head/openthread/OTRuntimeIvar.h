//
//  OTRuntimeIvar.h
//  Pomodoro
//
//  Created by OpenThread on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OTTypeDef.h"

//Returns the name of an instance variable.
const char * ivar_getName(Ivar ivar);

//Returns the type string of an instance variable.
const char * ivar_getTypeEncoding(Ivar ivar);

//Returns the offset of an instance variable.
ptrdiff_t ivar_getOffset(Ivar ivar);
