# Install package manager
mkdir -p ~/.local/share/nvim/site/pack/packer/start
cd ~/.local/share/nvim/site/pack/packer/start
git clone --depth 1 https://github.com/wbthomason/packer.nvim packer.nvim
cd -

# Terminal rust programs
brew install neovim
brew install lua

# install dependency tools
brew install ripgrep
brew install fd
brew install exa # ls
brew install bat # cat

# languages support
## Typescript
npm i -g typescript typescript-language-server
npm install -g @fsouza/prettierd

## Solidity
npm install -g solidity-language-server

# Lua
brew install lua-language-server
brew install luarocks
luarocks install luacheck
luarocks install lanes

# Rust
brew install rust-analyzer
rustup component add rustfmt
rustup component add clippy

# CSharp
dotnet tool install --global csharp-ls

# Python
npm i -g pyright
pip3 install black

# Go
## Language Server
go install golang.org/x/tools/gopls@latest
## Linter
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.54.2

## Install dependencies $GOPATH is configured in ~/.zshrc
## export GOPATH=/opt/go
mkdir /opt/go

# C/C++
brew install llvm

## Make this part of env
## cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
## ln -s ~/myproject-build/compile_commands.json ~/myproject/

# Tailwind
npm install -g @tailwindcss/language-server

# YAML
go install github.com/google/yamlfmt/cmd/yamlfmt@latest

# checkhealth
pip3 install neovim
npm i -g neovim
cargo install tree-sitter-cli

# fonts
# https://www.nerdfonts.com/font-downloads
brew tap homebrew/cask-fonts &&
brew install --cask font-dejavu-sans-mono-nerd-font

# writting
npm i -g write-good

pip3 install codespell
pip3 install yamllint

npm install -g @commitlint/{config-conventional,cli}
npm install -g commitlint-format-json

# Mundo plugin dependency
pip3 install pynvim
