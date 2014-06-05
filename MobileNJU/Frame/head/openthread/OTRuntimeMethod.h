//
//  OTRuntimeMethod.h
//  Pomodoro
//
//  Created by OpenThread on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OTTypeDef.h"

//Returns the name of a method.
SEL method_getName(Method method);

//Returns the implementation of a method.
IMP method_getImplementation(Method method);

//Returns a string describing a method's parameter and return types.
const char * method_getTypeEncoding(Method method);

//Returns a string describing a method's return type.
char * method_copyReturnType(Method method);

//Returns a string describing a single parameter type of a method.
char * method_copyArgumentType(Method method, unsigned int index);

//Returns by reference a string describing a method's return type.
void method_getReturnType(Method method, char *dst, size_t dst_len);

//Returns the number of arguments accepted by a method.
unsigned method_getNumberOfArguments(Method method);

//Returns by reference a string describing a single parameter type of a method.
void method_getArgumentType(Method method, unsigned int index, char *dst, size_t dst_len);

//Sets the implementation of a method.
IMP method_setImplementation(Method method, IMP imp);

//Exchanges the implementations of two methods.
void method_exchangeImplementations(Method m1, Method m2);