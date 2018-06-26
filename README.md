# My Setup

Repository for documenting and tracking my compute setup, and simplify setting up new machines.

## Setting up a new Mac

- [ ] Clone this repo and run the initial Mac setup script:

```sh
mkdir -p ~/work/ostrich
cd !$
git clone https://github.com/itamaro/my-setup.git
cd my-setup
./initial-mac-setup.sh
```

- [ ] Chrome: Sign in, Sync extensions, Login to LastPass
- [ ] Dropbox: Sign in, Configure "Selective Sync", Let it sync with `~/Dropbox`
- [ ] Dotfiles etc.: Run the idempotent Mac setup script: `./idempotent-mac-setup.sh`
- [ ] Secrets: Run the restore secrets script (password in LastPass 'secret encryption'): `./restore-secrets.sh`
- [ ] Evernote: Sign in, Let it sync
- [ ] CrashPlan: Sign in, Adopt computer, Restore things (if needed)
