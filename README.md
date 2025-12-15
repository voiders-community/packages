Void packages repo maintained by the unofficial void linux community.

You can use this repo in two ways, either localy or remotely.

## Local install

### Clone the repository anywhere

```sh
git clone https://github.com/voiders-community/packages ~/ports --recurse-submodules
```

### Add the repository

```sh
echo "repository=$HOME/ports/hostdir/binpkgs" | sudo tee /etc/xbps.d/10-voiders-community-local-repo.conf
```

### Sync the repos

```sh
sudo xbps-install -S
```

## Remote install

### Add the repository

```sh
echo "repository=https://github.com/voiders-community/packages/raw/refs/heads/master/hostdir/binpkgs/" | sudo tee /etc/xbps.d/10-voiders-community-local-repo.conf
```

### Sync the repos

```sh
sudo xbps-install -S
```


## How to add a new package

Write your template in ./srcpkgs/YOUR_PACKAGE/template like you'd do with the official repo, then run `./make build YOUR_PACKAGE`, if you've installed the repo using the local install you can now do `xbps-install -S YOUR_PACKAGE`.

## How to push my new package

To add a new package you just need to open a PR with your srcpkgs (DO NOT push any .xbps files)
