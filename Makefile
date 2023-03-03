# For OS context switching
UNAME := $(shell uname)

# Need hostname to match a nix configuration profile (for macOS we need to remove the .local suffix)
PROFILE := $(subst .local,,$(shell hostname))

switch:
ifeq($(UNAME), Darwin)
  nix build ".#darwinConfigurations.${PROFILE}.system" --extra-experimental-features "nix-command flakes"
  ./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${PROFILE}"
else
  sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${PROFILE}"
endif
