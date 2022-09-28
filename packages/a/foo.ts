import { Foo } from '@myorg/b/bar';

export interface Offline {
    pluginRegistry: Foo | undefined;
}
export const Offline = {
    fromPartial<I extends Exact<DeepPartial<Offline>, I>>(object: I) {
    // const message = createBaseOffline();
    // message.pluginRegistry = (object.pluginRegistry !== undefined && object.pluginRegistry !== null)
    //   ? PluginRegistry.fromPartial(object.pluginRegistry)
    //   : undefined;
    console.log(object);
  }
}
type Builtin = Date | Function | Uint8Array | string | number | boolean | undefined;

export type DeepPartial<T> = T extends Builtin ? T
  : T extends Array<infer U> ? Array<DeepPartial<U>> : T extends ReadonlyArray<infer U> ? ReadonlyArray<DeepPartial<U>>
  : T extends {} ? { [K in keyof T]?: DeepPartial<T[K]> }
  : Partial<T>;

type KeysOfUnion<T> = T extends T ? keyof T : never;
export type Exact<P, I extends P> = P extends Builtin ? P
  : P & { [K in keyof P]: Exact<P[K], I[K]> } & { [K in Exclude<keyof I, KeysOfUnion<P>>]: never };
