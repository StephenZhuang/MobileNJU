//
//  OTRuntimeSel.h
//  Pomodoro
//
//  Created by OpenThread on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

//Returns the name of the method specified by a given selector.
const char* sel_getName(SEL aSelector);

//Registers a method with the Objective-C runtime system, maps the method name to a selector, and returns the selector value.
SEL sel_registerName(const char *str);

//Registers a method name with the Objective-C runtime system.
SEL sel_getUid(const char *str);

//Returns a Boolean value that indicates whether two selectors are equal.
BOOL sel_isEqual(SEL lhs, SEL rhs);