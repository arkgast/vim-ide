mkdir -p ~/.local/share/nvim/site/pack/packer/start

cd ~/.local/share/nvim/site/pack/packer/start

git clone --depth 1 https://github.com/wbthomason/packer.nvim packer.nvim

git clone https://github.com/github/copilot.vim.git copilot.vim

cd -

# install dependency tools
brew install ripgrep
brew install fd

# languages support
## Typescript
npm i -g typescript typescript-language-server

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

# JSON
npm i -g fixjson
npm install jsonlint -g

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

# Terminal rust programs
brew install exa # ls
brew install bat # cat
