//
//  OTRuntimeClass.h
//  Pomodoro
//
//  Created by OpenThread on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OTTypeDef.h"

//Returns the name of a class.
const char * class_getName(Class cls);

//Returns the superclass of a class.
Class class_getSuperclass(Class cls);

//Sets the superclass of a given class.
Class class_setSuperclass(Class cls, Class newSuper);

//Returns a Boolean value that indicates whether a class object is a metaclass.
BOOL class_isMetaClass(Class cls);

//Returns the size of instances of a class.
size_t class_getInstanceSize(Class cls);

//Returns the Ivar for a specified instance variable of a given class.
Ivar class_getInstanceVariable(Class cls, const char* name);

//Returns the Ivar for a specified class variable of a given class.
Ivar class_getClassVariable(Class cls, const char* name);

//Adds a new instance variable to a class.
BOOL class_addIvar(Class cls, const char *name, size_t size, uint8_t alignment, const char *types);

//Describes the instance variables declared by a class.
Ivar * class_copyIvarList(Class cls, unsigned int *outCount);

//Returns a description of the Ivar layout for a given class.
const char *class_getIvarLayout(Class cls);

//Sets the Ivar layout for a given class.
void class_setIvarLayout(Class cls, const char *layout);

//Returns a description of the layout of weak Ivars for a given class.
const char *class_getWeakIvarLayout(Class cls);

//Sets the layout for weak Ivars for a given class.
void class_setWeakIvarLayout(Class cls, const char *layout);

//Returns a property with a given name of a given class.
objc_property_t class_getProperty(Class cls, const char *name);

//Describes the properties declared by a class.
objc_property_t * class_copyPropertyList(Class cls, unsigned int *outCount);

//Adds a new method to a class with a given name and implementation.
BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types);

//Returns a specified instance method for a given class.
Method class_getInstanceMethod(Class aClass, SEL aSelector);

//Returns a pointer to the data structure describing a given class method for a given class.
Method class_getClassMethod(Class aClass, SEL aSelector);

//Describes the instance methods implemented by a class.
Method * class_copyMethodList(Class cls, unsigned int *outCount);

//Replaces the implementation of a method for a given class.
IMP class_replaceMethod(Class cls, SEL name, IMP imp, const char *types);

//Returns the function pointer that would be called if a particular message were sent to an instance of a class.
IMP class_getMethodImplementation(Class cls, SEL name);

//Returns the function pointer that would be called if a particular message were sent to an instance of a class.
IMP class_getMethodImplementation_stret(Class cls, SEL name);

//Returns a Boolean value that indicates whether instances of a class respond to a particular selector.
BOOL class_respondsToSelector(Class cls, SEL sel);

//Adds a protocol to a class.
BOOL class_addProtocol(Class cls, Protocol *protocol);

//Returns a Boolean value that indicates whether a class conforms to a given protocol.
BOOL class_conformsToProtocol(Class cls, Protocol *protocol);

//Returns the version number of a class definition.
int class_getVersion(Class theClass);

//Sets the version number of a class definition.
void class_setVersion(Class theClass, int version);

//Creates an instance of a class, allocating memory for the class in the default malloc memory zone.
id class_createInstance(Class cls, size_t extraBytes);

#if !__has_feature(objc_arc)

//Describes the protocols adopted by a class.Note that is cannot be used in ARC.
Protocol ** class_copyProtocolList(Class cls, unsigned int *outCount);

//Returns a specified protocol.
Protocol *objc_getProtocol(const char *name);

//Returns an array of all the protocols known to the runtime.
Protocol **objc_copyProtocolList(unsigned int *outCount);

#endif