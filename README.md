# NVIM CONFIG

## FONT
1. nvim-config/resources/JetBrainsMonoNLRegularNerdFontComplete.ttf

## INSTALL

```bash
git clone git@github.com:haoliplus/nvim-config.git ~/.config/
# installs NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# download and install Node.js
nvm install 20
# verifies the right Node.js version is in the environment
node -v # should print `v20.12.0`
# verifies the right NPM version is in the environment
npm -v # should print `10.5.0`
```

<!-- curl -s -L https://raw.githubusercontent.com/haoliplus/nvim-config/master/tools/install.sh | bash -->
<!-- wget -O - -o https://raw.githubusercontent.com/haoliplus/nvim-config/master/tools/install.sh | bash  -->
<!---->

## quick move
this_is_a_long_word

`cf<symbol>`: delete until next symbol(include symbol)
`ct<symbol>`: delete until next symbol(not include symbol)
`ciw`: delete current word
