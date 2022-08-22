mkdir -p ~/.local/share/nvim/site/pack/packer/start

cd ~/.local/share/nvim/site/pack/packer/start

git clone --depth 1 https://github.com/wbthomason/packer.nvim packer.nvim

git clone https://github.com/github/copilot.vim.git copilot.vim

cd -

# install dependency tools
brew install ripgrep
brew install fd

# languages support
npm i -g typescript typescript-language-server
npm install -g solidity-language-server
brew install lua-language-server
brew install rust-analyzer
dotnet tool install --global csharp-ls

# checkhealth
pip3 install neovim
npm i -g neovim
cargo install tree-sitter-cli

# fonts
# https://www.nerdfonts.com/font-downloads
brew tap homebrew/cask-fonts &&
brew install --cask font-dejavu-sans-mono-nerd-font

# Terminal rust programs
brew install exa # ls
brew install bat # cat
