# neovim configuration for developers
>(specially web developers)

## Additional packages

It's necessary to install `python-neovim` to use [YouCompleteMe](https://valloric.github.io/YouCompleteMe/)

    $ pip install neovim

### CSS - SASS

    $ npm install stylelint -g
    $ npm install stylelint-scss
    $ npm install stylelint-config-standard

Then is necessary to create the next file **.stylelintrc.json**

    // .stylelintrc.json
    {
      "plugins": [
        "stylelint-scss"
      ],
      "extends": "stylelint-config-standard"
    }

## Possible issues

I've got a permission error after installing **stylelint** so to fix it, it's necessary to do:
    # Run as root
    $ chmod 744 /opt/node/lib/node_modules/stylelint/node_modules/array-unique/index.js
