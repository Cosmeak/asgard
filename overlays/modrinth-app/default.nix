{ channels, ... }:

final: prev: {
    inherit (channels.unstable) modrinth-app;
}
