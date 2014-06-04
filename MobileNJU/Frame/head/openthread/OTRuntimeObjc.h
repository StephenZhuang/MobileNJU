//
//  OTRuntimeObjc.h
//  Pomodoro
//
//  Created by OpenThread on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

//Used by CoreFoundation's toll-free bridging.
Class objc_getFutureClass(const char *name);

//Used by CoreFoundation's toll-free bridging.
void objc_setFutureClass(Class cls, const char *name);

//Creates a new class and metaclass.
Class objc_allocateClassPair(Class superclass, const char *name, size_t extraBytes);

//Registers a class that was allocated using objc_allocateClassPair.
void objc_registerClassPair(Class cls);

//Used by Foundation's Key-Value Observing.Do not call this function yourself.
//objc_duplicateClass;

//Obtains the list of registered class definitions.
int objc_getClassList(Class *buffer, int bufferLen);

//Returns the class definition of a specified class.
id objc_lookUpClass(const char *name);

//Returns the class definition of a specified class.
id objc_getClass(const char *name);

//Returns the class definition of a specified class.
id objc_getRequiredClass(const char *name);

//Returns the metaclass definition of a specified class.
id objc_getMetaClass(const char *name);

//Sets an associated value for a given object using a given key and association policy.
void objc_setAssociatedObject(id object, void *key, id value, objc_AssociationPolicy policy);

//Returns the value associated with a given object for a given key.
id objc_getAssociatedObject(id object, void *key);

//Removes all associations for a given object.
void objc_removeAssociatedObjects(id object);

//Sends a message with a simple return value to an instance of a class.
id objc_msgSend(id theReceiver, SEL theSelector, ...);


//Uncompleted inplemention under.
#ifdef I386
//Sends a message with a floating-point return value to an instance of a class.
double objc_msgSend_fpret(id self, SEL op, ...);

//Sends a message with a data-structure return value to an instance of a class.
void objc_msgSend_stret(void * stretAddr, id theReceiver, SEL theSelector,  ...);

//Sends a message with a simple return value to the superclass of an instance of a class.
id objc_msgSendSuper(struct objc_super *super, SEL op,  ...);

//Sends a message with a data-structure return value to the superclass of an instance of a class.
void objc_msgSendSuper_stret(struct objc_super *super, SEL op, ...);
#endif