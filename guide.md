# Personal Guide
---

## 1. Install `stow`

On Debian/Ubuntu:

```bash
sudo apt install stow
```

---

## 2. Repo structure with stow

Each "package" is a folder inside your dotfiles repo, and inside it you mirror the **home directory layout**.

Example structure:

```bash
dotfiles/
├── vim/
│   └── .vim/
│       └── vimrc
├── nvim/
│   └── .config/
│       └── nvim/
│           └── init.lua
└── i3/
    └── .config/
        └── i3/
            └── config
```

---

## 3. Move configs into repo

From your home:

```bash
mkdir -p ~/dotfiles/vim ~/.dotfiles/nvim ~/.dotfiles/i3

mv ~/.vim ~/dotfiles/vim/.vim
mv ~/.config/nvim ~/dotfiles/nvim/.config/
mv ~/.config/i3 ~/dotfiles/i3/.config/
```

---

## 4. Stow them

Now go to your repo:

```bash
cd ~/dotfiles
stow vim
stow nvim
stow i3
```

This will create symlinks in `$HOME` pointing back into your repo.
Check with `ls -l ~/.vim`, `ls -l ~/.config/nvim`, etc. — they should be symlinks.

---

## 5. Git setup

```bash
cd ~/dotfiles
git init
git add .
git commit -m "Initial commit: vim, nvim, i3 configs"
```

Then push to GitHub/GitLab:

```bash
git remote add origin git@github.com:yourusername/dotfiles.git
git branch -M main
git push -u origin main
```

---

## 6. Using it on a new machine

Clone your repo:

```bash
git clone git@github.com:yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow vim nvim i3
```

And everything links automatically 🎉

