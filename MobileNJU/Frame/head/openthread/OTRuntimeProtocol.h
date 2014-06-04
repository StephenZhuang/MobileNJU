//
//  OTRuntimeProtocol.h
//  Pomodoro
//
//  Created by OpenThread on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OTTypeDef.h"

//Returns a the name of a protocol.
const char *protocol_getName(Protocol *p);

//Returns a Boolean value that indicates whether two protocols are equal.
BOOL protocol_isEqual(Protocol *proto, Protocol *other);

//Returns an array of method descriptions of methods meeting a given specification for a given protocol.
struct objc_method_description * protocol_copyMethodDescriptionList(Protocol *p, BOOL isRequiredMethod, BOOL isInstanceMethod, unsigned int *outCount);

//Returns a method description structure for a specified method of a given protocol.
struct objc_method_description protocol_getMethodDescription(Protocol *p, SEL aSel, BOOL isRequiredMethod, BOOL isInstanceMethod);

//Returns an array of the properties declared by a protocol.
objc_property_t * protocol_copyPropertyList(Protocol *protocol, unsigned int *outCount);

//Returns the specified property of a given protocol.
objc_property_t protocol_getProperty(Protocol *proto, const char *name, BOOL isRequiredProperty, BOOL isInstanceProperty);

//Returns a Boolean value that indicates whether one protocol conforms to another protocol.
BOOL protocol_conformsToProtocol(Protocol *proto, Protocol *other);

//Returns the name of a property.
const char *property_getName(objc_property_t property);

//Returns the attribute string of an property.
const char *property_getAttributes(objc_property_t property);

#if !__has_feature(objc_arc)

//Returns an array of the protocols adopted by a protocol.
Protocol **protocol_copyProtocolList(Protocol *proto, unsigned int *outCount);

#endif