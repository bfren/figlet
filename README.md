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

| figlet    | Built on    |
| --------- | ----------- |
| **2.2.5** | Alpine 3.24 |

Every image is built for `linux/amd64`, `linux/arm64` and `linux/arm/v7`.

## Tags

Images are published to `quay.io/bfren-bin/figlet`:

| Tag              | Example          |
| ---------------- | ---------------- |
| `FIGLET-VERSION` | `2.2.5-261106.2` |

`VERSION` is the build date (`yymmdd`) in [VERSION](VERSION) - pin it to get exactly the same executable every
time. Builds from any branch other than `main` add `-dev` to every tag.

## Adding a release

1. Update the `ALPINE` default in [Dockerfile](Dockerfile) and [test.sh](test.sh) for a new Alpine minor version
   (a rebuild picks up new revisions of 3.24 on its own), or for a new figlet release add its source to [src](src)
   (see [Source](#source)) and update the `FIGLET` default in [Dockerfile](Dockerfile) and [test.sh](test.sh), the
   `figlet` matrix in the [build workflow](.github/workflows/build.yml), and the matrix above.
2. Set [VERSION](VERSION) to today's date (`yymmdd`, or `yymmdd.2`, `.3` and so on for another release that day),
   then run `./test.sh`.
3. Push the branch, which builds `-dev` tags to test with, then merge into `main`, which builds the release (it
   refuses to overwrite a tag that already exists).

## Source

[src](src) holds `figlet-2.2.5.tar.gz`, created from the `2.2.5` tag of figlet's
[GitHub repository](https://github.com/cmatsuoka/figlet) with `git archive --prefix=figlet-2.2.5/`, and its checksum.

## Usage

You can find live examples in my [Alpine](https://github.com/bfren/docker-alpine) and
[Debian](https://github.com/bfren/docker-debian) Docker images.

```Dockerfile
# load figlet
FROM quay.io/bfren-bin/figlet:2.2.5-261106.2 AS figlet

# use any Linux distribution
FROM alpine:3.24

# copy figlet, its default font and licence to /
COPY --from=figlet / /

# rest of Dockerfile
```

## Licence

The build scripts in this repository are released under the [MIT licence](https://mit.bfren.dev/2026).

figlet is licensed under the [BSD 3-Clause licence](https://github.com/cmatsuoka/figlet/blob/master/LICENSE), which
covers the source in [src](src) and the files in the published images - its licence is included in each image.

## Copyright

> Copyright (c) 2026 bfren (unless otherwise stated)
