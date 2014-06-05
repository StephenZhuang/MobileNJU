//
//  OTRuntimeObject.h
//  Pomodoro
//
//  Created by OpenThread on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OTTypeDef.h"

//Returns a copy of a given object.
id object_copy(id obj, size_t size);

//Frees the memory occupied by a given object.
id object_dispose(id obj);

//Changes the value of an instance variable of a class instance.
Ivar object_setInstanceVariable(id obj, const char *name, void *value);

//Obtains the value of an instance variable of a class instance.
Ivar object_getInstanceVariable(id obj, const char *name, void **outValue);

//Returns a pointer to any extra bytes allocated with a instance given object.
OBJC_EXPORT void *object_getIndexedIvars(id obj);

//Reads the value of an instance variable in an object.
id object_getIvar(id object, Ivar ivar);

//Sets the value of an instance variable in an object.
void object_setIvar(id object, Ivar ivar, id value);

//Returns the class name of a given object.
const char *object_getClassName(id obj);

//Returns the class of an object.
Class object_getClass(id object);

//Sets the class of an object.
Class object_setClass(id object, Class cls);