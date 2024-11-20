{ channels, ... }:
final: prev: {
    inherit (channels.unstable) deno;
}
