// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class MBook;
@class MBookDetail;
@class MBookDetail_Builder;
@class MBookList;
@class MBookList_Builder;
@class MBook_Builder;

@interface ZsndLibraryRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface MBookList : PBGeneratedMessage {
@private
  BOOL hasCnt_:1;
  BOOL hasImg_:1;
  int32_t cnt;
  NSData* img;
  NSMutableArray* mutableNewsList;
}
- (BOOL) hasCnt;
- (BOOL) hasImg;
@property (readonly) int32_t cnt;
@property (readonly, retain) NSData* img;
- (NSArray*) newsList;
- (MBook*) newsAtIndex:(int32_t) index;

+ (MBookList*) defaultInstance;
- (MBookList*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MBookList_Builder*) builder;
+ (MBookList_Builder*) builder;
+ (MBookList_Builder*) builderWithPrototype:(MBookList*) prototype;

+ (MBookList*) parseFromData:(NSData*) data;
+ (MBookList*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MBookList*) parseFromInputStream:(NSInputStream*) input;
+ (MBookList*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MBookList*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MBookList*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MBookList_Builder : PBGeneratedMessage_Builder {
@private
  MBookList* result;
}

- (MBookList*) defaultInstance;

- (MBookList_Builder*) clear;
- (MBookList_Builder*) clone;

- (MBookList*) build;
- (MBookList*) buildPartial;

- (MBookList_Builder*) mergeFrom:(MBookList*) other;
- (MBookList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MBookList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) newsList;
- (MBook*) newsAtIndex:(int32_t) index;
- (MBookList_Builder*) replaceNewsAtIndex:(int32_t) index with:(MBook*) value;
- (MBookList_Builder*) addNews:(MBook*) value;
- (MBookList_Builder*) addAllNews:(NSArray*) values;
- (MBookList_Builder*) clearNewsList;

- (BOOL) hasCnt;
- (int32_t) cnt;
- (MBookList_Builder*) setCnt:(int32_t) value;
- (MBookList_Builder*) clearCnt;

- (BOOL) hasImg;
- (NSData*) img;
- (MBookList_Builder*) setImg:(NSData*) value;
- (MBookList_Builder*) clearImg;
@end

@interface MBook : PBGeneratedMessage {
@private
  BOOL hasTotal_:1;
  BOOL hasCanBorrow_:1;
  BOOL hasCanRenew_:1;
  BOOL hasId_:1;
  BOOL hasTitle_:1;
  BOOL hasAuthor_:1;
  BOOL hasPublish_:1;
  BOOL hasBorrowTime_:1;
  BOOL hasBackTime_:1;
  int32_t total;
  int32_t canBorrow;
  int32_t canRenew;
  NSString* id;
  NSString* title;
  NSString* author;
  NSString* publish;
  NSString* borrowTime;
  NSString* backTime;
  NSMutableArray* mutableDetailsList;
}
- (BOOL) hasId;
- (BOOL) hasTitle;
- (BOOL) hasAuthor;
- (BOOL) hasPublish;
- (BOOL) hasTotal;
- (BOOL) hasCanBorrow;
- (BOOL) hasBorrowTime;
- (BOOL) hasBackTime;
- (BOOL) hasCanRenew;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* title;
@property (readonly, retain) NSString* author;
@property (readonly, retain) NSString* publish;
@property (readonly) int32_t total;
@property (readonly) int32_t canBorrow;
@property (readonly, retain) NSString* borrowTime;
@property (readonly, retain) NSString* backTime;
@property (readonly) int32_t canRenew;
- (NSArray*) detailsList;
- (MBookDetail*) detailsAtIndex:(int32_t) index;

+ (MBook*) defaultInstance;
- (MBook*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MBook_Builder*) builder;
+ (MBook_Builder*) builder;
+ (MBook_Builder*) builderWithPrototype:(MBook*) prototype;

+ (MBook*) parseFromData:(NSData*) data;
+ (MBook*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MBook*) parseFromInputStream:(NSInputStream*) input;
+ (MBook*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MBook*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MBook*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MBook_Builder : PBGeneratedMessage_Builder {
@private
  MBook* result;
}

- (MBook*) defaultInstance;

- (MBook_Builder*) clear;
- (MBook_Builder*) clone;

- (MBook*) build;
- (MBook*) buildPartial;

- (MBook_Builder*) mergeFrom:(MBook*) other;
- (MBook_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MBook_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MBook_Builder*) setId:(NSString*) value;
- (MBook_Builder*) clearId;

- (BOOL) hasTitle;
- (NSString*) title;
- (MBook_Builder*) setTitle:(NSString*) value;
- (MBook_Builder*) clearTitle;

- (BOOL) hasAuthor;
- (NSString*) author;
- (MBook_Builder*) setAuthor:(NSString*) value;
- (MBook_Builder*) clearAuthor;

- (BOOL) hasPublish;
- (NSString*) publish;
- (MBook_Builder*) setPublish:(NSString*) value;
- (MBook_Builder*) clearPublish;

- (BOOL) hasTotal;
- (int32_t) total;
- (MBook_Builder*) setTotal:(int32_t) value;
- (MBook_Builder*) clearTotal;

- (BOOL) hasCanBorrow;
- (int32_t) canBorrow;
- (MBook_Builder*) setCanBorrow:(int32_t) value;
- (MBook_Builder*) clearCanBorrow;

- (BOOL) hasBorrowTime;
- (NSString*) borrowTime;
- (MBook_Builder*) setBorrowTime:(NSString*) value;
- (MBook_Builder*) clearBorrowTime;

- (BOOL) hasBackTime;
- (NSString*) backTime;
- (MBook_Builder*) setBackTime:(NSString*) value;
- (MBook_Builder*) clearBackTime;

- (BOOL) hasCanRenew;
- (int32_t) canRenew;
- (MBook_Builder*) setCanRenew:(int32_t) value;
- (MBook_Builder*) clearCanRenew;

- (NSArray*) detailsList;
- (MBookDetail*) detailsAtIndex:(int32_t) index;
- (MBook_Builder*) replaceDetailsAtIndex:(int32_t) index with:(MBookDetail*) value;
- (MBook_Builder*) addDetails:(MBookDetail*) value;
- (MBook_Builder*) addAllDetails:(NSArray*) values;
- (MBook_Builder*) clearDetailsList;
@end

@interface MBookDetail : PBGeneratedMessage {
@private
  BOOL hasNum_:1;
  BOOL hasCode_:1;
  BOOL hasAddress_:1;
  BOOL hasState_:1;
  NSString* num;
  NSString* code;
  NSString* address;
  NSString* state;
}
- (BOOL) hasNum;
- (BOOL) hasCode;
- (BOOL) hasAddress;
- (BOOL) hasState;
@property (readonly, retain) NSString* num;
@property (readonly, retain) NSString* code;
@property (readonly, retain) NSString* address;
@property (readonly, retain) NSString* state;

+ (MBookDetail*) defaultInstance;
- (MBookDetail*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MBookDetail_Builder*) builder;
+ (MBookDetail_Builder*) builder;
+ (MBookDetail_Builder*) builderWithPrototype:(MBookDetail*) prototype;

+ (MBookDetail*) parseFromData:(NSData*) data;
+ (MBookDetail*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MBookDetail*) parseFromInputStream:(NSInputStream*) input;
+ (MBookDetail*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MBookDetail*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MBookDetail*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MBookDetail_Builder : PBGeneratedMessage_Builder {
@private
  MBookDetail* result;
}

- (MBookDetail*) defaultInstance;

- (MBookDetail_Builder*) clear;
- (MBookDetail_Builder*) clone;

- (MBookDetail*) build;
- (MBookDetail*) buildPartial;

- (MBookDetail_Builder*) mergeFrom:(MBookDetail*) other;
- (MBookDetail_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MBookDetail_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasNum;
- (NSString*) num;
- (MBookDetail_Builder*) setNum:(NSString*) value;
- (MBookDetail_Builder*) clearNum;

- (BOOL) hasCode;
- (NSString*) code;
- (MBookDetail_Builder*) setCode:(NSString*) value;
- (MBookDetail_Builder*) clearCode;

- (BOOL) hasAddress;
- (NSString*) address;
- (MBookDetail_Builder*) setAddress:(NSString*) value;
- (MBookDetail_Builder*) clearAddress;

- (BOOL) hasState;
- (NSString*) state;
- (MBookDetail_Builder*) setState:(NSString*) value;
- (MBookDetail_Builder*) clearState;
@end

