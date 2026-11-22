# dotfiles
 
個人PC用の dotfiles。
 
## 構成
 
| パス | 配置先 | 内容 |
|---|---|---|
| `config/fish/` | `~/.config/fish` | fish の設定。プラグインは fisher（`fish_plugins`）で管理 |
| `com.googlecode.iterm2.plist` | — | iTerm2 の設定（iTerm2 がこのリポジトリを直接読み書きする） |
| `.gitconfig` | `~/.gitconfig` | Git の設定 |
| `.gitignore` | `~/.gitignore` | グローバルな gitignore（`.gitconfig` の `core.excludesfile` で参照） |
| `.vimrc` | `~/.vimrc` | vim |
 
## 新しいPCでのセットアップ
 
### 1. git と GitHub
 
```sh
xcode-select --install                      # git を含む Command Line Tools
ssh-keygen -t ed25519 -C "<メールアドレス>"   # パスフレーズは設定する
pbcopy < ~/.ssh/id_ed25519.pub              # GitHub の Settings > SSH and GPG keys に登録
```
 
`~/.ssh/config`:
 
```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```
 
`ssh -T git@github.com` で `Hi kotaro0522!` と出れば OK。
 
### 2. Homebrew と ghq
 
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install ghq fzf fish
ghq get -p kotaro0522/dotfiles               # ~/ghq/github.com/kotaro0522/dotfiles
```
 
### 3. 設定ファイルをリンクする
 
```sh
cd ~/ghq/github.com/kotaro0522/dotfiles
mkdir -p ~/.config
ln -s "$PWD/config/fish" ~/.config/fish
ln -s "$PWD/.gitconfig"  ~/.gitconfig
ln -s "$PWD/.gitignore"  ~/.gitignore
ln -s "$PWD/.vimrc"      ~/.vimrc
```
 
既にファイルがある場合は、退避してからリンクする。
 
### 4. fish をデフォルトシェルにする
 
```sh
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```
 
新しいターミナルを開き、fisher とプラグインを入れる。
 
```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher update
```
 
### 5. iTerm2
 
1. `Settings > General > Settings` で「Load settings from a custom folder or URL」にチェックを入れ、このリポジトリのルートを指定する
2. iTerm2 を `⌘Q` で終了して起動し直す（custom folder は起動時に読み込まれる）
3. `Settings > Profiles` に `prod`・`dev`・`Hotkey` が出ていれば読み込めている
4. システム設定の「プライバシーとセキュリティ」で、iTerm2 に **「アクセシビリティ」と「入力監視」** の権限を付与し、もう一度 `⌘Q` → 起動
   （hotkey は修飾キーのダブルタップ方式なので、入力監視がないと iTerm2 がアクティブなときしか反応しない）
custom folder を指定する前に「変更を保存」が「自動的に」になっていると、初期状態の設定で plist が上書きされることがある。
`git status` で plist が変わっていたら、iTerm2 を終了してから `git checkout -- com.googlecode.iterm2.plist` で戻す。
 
## 設定を変えたとき
 
- シンボリックリンク経由でリポジトリのファイルが直接変わるので、`git diff` で確認してコミットする
- iTerm2 の設定も plist が自動で更新される。スニペットやトリガーに接続先のホスト名などを入れた場合は、public リポジトリなのでコミット前に中身を確認する
- fish の `set -U` で作ったユニバーサル変数は `fish_variables`（管理対象外）に入るので、残したいものは `config/fish/conf.d/` に書く
 
