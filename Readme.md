# [neo]vim configuration for developers

Configuration to speed up development

## Dependencies

#### Javascript

Create this file on your working dir **.tern-project**

    {
      "ecmaVersion": 6,
      "libs": [
        "browser"
      ],
      "plugins": {
        "complete_strings": {
          "maxLength": 15
        },
        "doc_comment": {
          "fullDocs": true,
          "strong": true
        },
        "node": {}
      }
    }

#### C#
    $ sudo apt-get install mono-complete

#### Markdown
    $ sudo npm i -g instant-markdown-d

### Linters

#### Python
    $ sudo pip install flake8

#### Javascript

#### CSS SASS
    $ sudo npm i -g stylelint         # global
    $ npm i stylelint-scss            # local
    $ npm i stylelint-config-standard # local

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
