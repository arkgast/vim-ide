# [neo]vim configuration for web developers
> django, php, reactjs, sass/css

## Installation

### To lint python
    $ sudo pip install flake8

### To write markdown and see changes in realtime
    $ sudo npm i -g instant-markdown-d

### To lint **css/sass**
    $ sudo npm i -g stylelint
    $ npm i stylelint-scss
    $ npm i stylelint-config-standard

Create this file in your working dir **.stylelintrc.json**

    // create a file .stylelintrc.json in your working directory
    {
      "plugins": [
        "stylelint-scss"
      ],
      "extends": "stylelint-config-standard"
    }

## Possible errors

I've got a permission error after installing **stylelint** so to fix it, it's necessary to do:

    $ sudo chmod 744 /opt/node/lib/node_modules/stylelint/node_modules/array-unique/index.js
