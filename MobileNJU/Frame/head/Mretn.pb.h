// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class Msg_Retn;
@class Msg_Retn_Builder;

@interface MretnRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface Msg_Retn : PBGeneratedMessage {
@private
  BOOL hasErrorCode_:1;
  BOOL hasErrorMsg_:1;
  BOOL hasReturnMethod_:1;
  BOOL hasRetnMessage_:1;
  int32_t errorCode;
  NSString* errorMsg;
  NSString* returnMethod;
  NSData* retnMessage;
}
- (BOOL) hasErrorCode;
- (BOOL) hasErrorMsg;
- (BOOL) hasReturnMethod;
- (BOOL) hasRetnMessage;
@property (readonly) int32_t errorCode;
@property (readonly, retain) NSString* errorMsg;
@property (readonly, retain) NSString* returnMethod;
@property (readonly, retain) NSData* retnMessage;

+ (Msg_Retn*) defaultInstance;
- (Msg_Retn*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (Msg_Retn_Builder*) builder;
+ (Msg_Retn_Builder*) builder;
+ (Msg_Retn_Builder*) builderWithPrototype:(Msg_Retn*) prototype;

+ (Msg_Retn*) parseFromData:(NSData*) data;
+ (Msg_Retn*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Msg_Retn*) parseFromInputStream:(NSInputStream*) input;
+ (Msg_Retn*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Msg_Retn*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (Msg_Retn*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface Msg_Retn_Builder : PBGeneratedMessage_Builder {
@private
  Msg_Retn* result;
}

- (Msg_Retn*) defaultInstance;

- (Msg_Retn_Builder*) clear;
- (Msg_Retn_Builder*) clone;

- (Msg_Retn*) build;
- (Msg_Retn*) buildPartial;

- (Msg_Retn_Builder*) mergeFrom:(Msg_Retn*) other;
- (Msg_Retn_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (Msg_Retn_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasErrorCode;
- (int32_t) errorCode;
- (Msg_Retn_Builder*) setErrorCode:(int32_t) value;
- (Msg_Retn_Builder*) clearErrorCode;

- (BOOL) hasErrorMsg;
- (NSString*) errorMsg;
- (Msg_Retn_Builder*) setErrorMsg:(NSString*) value;
- (Msg_Retn_Builder*) clearErrorMsg;

- (BOOL) hasReturnMethod;
- (NSString*) returnMethod;
- (Msg_Retn_Builder*) setReturnMethod:(NSString*) value;
- (Msg_Retn_Builder*) clearReturnMethod;

- (BOOL) hasRetnMessage;
- (NSData*) retnMessage;
- (Msg_Retn_Builder*) setRetnMessage:(NSData*) value;
- (Msg_Retn_Builder*) clearRetnMessage;
@end

