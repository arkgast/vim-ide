# [neo]vim configuration for web developers
> django, php, reactjs, sass/css

Configuration to speed up development

## Installation

### Markdown
    $ sudo npm i -g instant-markdown-d

### Linters
#### Python
    $ sudo pip install flake8

#### CSS SASS LESS
    $ sudo npm i -g stylelint
    $ npm i stylelint-scss
    $ npm i stylelint-config-standard

Create this file in your working dir **.stylelintrc.json**

    {
      "plugins": [
        "stylelint-scss"
      ],
      "extends": "stylelint-config-standard"
    }

## Possible errors

I've got a permission error after installing **stylelint** so to fix it, it's necessary to do:

    $ sudo chmod 744 /opt/node/lib/node_modules/stylelint/node_modules/array-unique/index.js
