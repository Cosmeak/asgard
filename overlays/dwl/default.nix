{ inputs, outputs, ... }:
final: prev: {
  dwl = prev.dwl.overrideAttrs (finalAttrs: previousAttrs: {
    patches = [ 
      # Add custom patches here and fetch them from https://www.codeberg.org/dwl/dwl-patches
      (inputs.nixpkgs.legacyPackages.x86_64-linux.fetchpatch {
        url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/ipc/ipc.patch";
        hash = "sha256-JOncRH9DxJtN5ZzMUexB2PpGaJUxwdHbDtZUYxYQh5A=";
      })
      (inputs.nixpkgs.legacyPackages.x86_64-linux.fetchpatch {
        url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/alwayscenter/alwayscenter.patch";
        hash = "sha256-JaM/YAXioRi16TRKLvDvHAsn4HQ9jpaBAhvHyp/r/+I=";
      })
      (inputs.nixpkgs.legacyPackages.x86_64-linux.fetchpatch {
        url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/gaps/gaps.patch";
        hash = "sha256-6knXrYblzaqjy5ZG8YG2VKwHeaHB+rij+8ZxXe5LqTE=";
      })
      (inputs.nixpkgs.legacyPackages.x86_64-linux.fetchpatch {
        url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/xwayland-handle-minimize/xwayland-handle-minimize.patch";
        hash = "sha256-u///eiy98ov90BOowSHnX0lE8YCh2kS8kCDVs+uo1gI=";
      })
    ]; 
  });
}