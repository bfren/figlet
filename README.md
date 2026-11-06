# figlet

[figlet](http://www.figlet.org) compiled as a static executable, so my
[Alpine](https://github.com/bfren/docker-alpine) and [Debian](https://github.com/bfren/docker-debian) images can show
their start-up banner without installing a package.

- **Build:** figlet's own Makefile, linked statically against musl on Alpine - the executable runs on any Linux
  distribution. See [build.sh](build.sh).
- **Patches:** [patches](patches) holds the one patch from Alpine's
  [figlet package](https://gitlab.alpinelinux.org/alpine/aports/-/tree/master/community/figlet), which lets figlet
  build against musl.
- **Contents:** `/usr/bin/figlet`, the default `standard` font in `/usr/share/figlet`, and figlet's licence in
  `/usr/share/licenses/figlet`.
- **Verification:** every build checks the source tarball against the SHA-256 checksum committed alongside it, checks
  figlet is statically linked, and renders text with the default font.

figlet 2.2.5 was released in 2012 and has not changed since, so new builds are only needed for a new Alpine release.

## Matrix

| figlet    | Platforms                                    |
| --------- | -------------------------------------------- |
| **2.2.5** | `linux/amd64`, `linux/arm64`, `linux/arm/v7` |

## Usage

```Dockerfile
# load figlet
FROM quay.io/bfren-bin/figlet:2.2.5-261106 AS figlet

# use it with any Linux distribution
FROM alpine:3.24
COPY --from=figlet / /

# rest of Dockerfile
```

## Source

[src](src) holds `figlet-2.2.5.tar.gz`, created from the `2.2.5` tag of figlet's
[GitHub repository](https://github.com/cmatsuoka/figlet) with `git archive --prefix=figlet-2.2.5/`, and its checksum.

## Licence

The build scripts in this repository are released under the [MIT licence](https://mit.bfren.dev/2026).

figlet is licensed under the [BSD 3-Clause licence](https://github.com/cmatsuoka/figlet/blob/master/LICENSE), which
covers the source in [src](src) and the files in the published images - its licence is included in each image.
