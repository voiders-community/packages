# Void Community Repository

[![Build Status](https://img.shields.io/github/actions/workflow/status/voiders-community/void-packages/build.yml?style=flat-square&label=Build)](https://github.com/voiders-community/packages/actions)
[![Packages](https://img.shields.io/github/directory-file-count/voiders-community/void-packages/srcpkgs?style=flat-square&label=Packages&type=dir)](https://github.com/voiders-community/packages/tree/master/srcpkgs)
[![Open Issues](https://img.shields.io/github/issues/voiders-community/void-packages?style=flat-square&color=orange)](https://github.com/voiders-community/packages/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/voiders-community/void-packages?style=flat-square&color=blue)](https://github.com/voiders-community/packages/pulls)
[![License](https://img.shields.io/github/license/voiders-community/void-packages?style=flat-square)](LICENSE.md)

An unofficial, community-driven package repository for [Void Linux](https://voidlinux.org).

This repository hosts software that may diverge from the strict guidelines of the official Void repositories, including patched versions, experimental software, and customized configurations.

Currently supported architectures include `x86_64` and `x86_64-musl`.

## Installation

### 1. Register the Repository
Create a repo config file for XBPS.

```sh
echo "repository=https://voiders-community.github.io/packages" | sudo tee /etc/xbps.d/20-voiders.conf
```

### 2. Sync & Import Keys
Update your local index. XBPS will prompt you to import the repo's RSA key upon the first sync.

```sh
sudo xbps-install -S
```

### 3. Verification (Optional but Recommended)
Verify that the imported key matches our official fingerprint:

> `Signed by Haris <plavpxl@proton.me>`
> `f4:d9:eb:bf:3c:9a:04:ae:e9:98:ac:12:7a:88:6b:06`

## Usage

Once registered, you can install packages as normal:

```sh
sudo xbps-install <package_name>
```

To list all packages available in this repository:

```sh
xbps-query -Rs --repository=https://voiders-community.github.io/packages "*"
```

## Contributing

We welcome and encourage contributions. Please follow the standard `xbps-src` packaging guidelines where possible. All packages must be tested before they are considered to be added.

### Backend

The `build.sh` script is a wrapper for `xbps-src` to work with custom repos. To avoid dependency issues, it copies all `srcpkgs` into the submodule dir `void-packages/srcpkgs` before attempting builds. Reviews and improvements are very welccome!

The workflow file `.github/workflows/build.yml` uses a Docker image [`void-glibc-full`](https://github.com/void-linux/void-containers/pkgs/container/void-glibc-full) from [void-containers](https://github.com/void-linux/void-containers) for a full build and development environment.

### Packages

To keep this repo more open, we allow opening Pull Requests (PRs) if you don't have a built template, or even know how to create one. When opening a PR for this, use the tag `template request` and briefly discuss:

- Why should we add and maintain this package?
- Should it be compiled from source or download a binary pkg?
- Does it appear to be safe? (i.e., no known malicious source code or blobs)

Often times, users will create working templates and make them available on the Internet, but outdated/orphaned. These are also welcomed. In addition to the above tag, use the `orphaned` tag. 

For other packages intended to be actively maintained, with a template made, use the tag `package request`.

For any Electron-based apps, use the tag `electron`.

For any custom Linux kernels, use the tag `kernel`. Note that custom kernels must work on all hardware (that is, not compiled with `-march=native` or similar).

A submodule of the official `void-packages` is used. This will be updated from upstream automatically, please do not include it in PRs.

### Build Locally
To build a package from this repository locally:

1. Clone the repo:
   ```sh
   git clone https://github.com/voiders-community/packages.git --recurse-submodules
   cd void-packages
   ```

2. Build using the provided helper script:
   ```sh
   ./build.sh build <pkgname>
   ```

### CI/CD Pipeline
All packages are automatically built and signed via GitHub Actions.
- **Push:** Commits to `master` trigger a rebuild of changed templates.
- **Publish:** Successful builds are automatically deployed to the repository site.

---
*This project is not officially affiliated with the Void Linux contributors, maintainers, or developers.*
