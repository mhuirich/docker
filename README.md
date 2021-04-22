# docker

*Useful docker images*

[![Project Logo][logo]][logo-large]

Currently, only one image is supported in this repo: a Haskell build environment
in Docker using Alpine as the base OS.

## Haskell

The `haskell` Docker image is useful for creating static builds of compiled
Haskell apps / services. See `./examples` for indications of detailed
usage patterns, taking particular note of compilation, size reduction, and
Docker image stripping.

The following examples have been pushed to Docker Hub, where you may view their
compressed sizes or `docker pull` them:

* [haskell-io-example-stripped](https://hub.docker.com/r/mhuirich/haskell-io-example-stripped/tags?page=1&ordering=last_updated)

Basic workflow is this:

1. `git clone git@github.com:mhuirich/docker.git`
1. Create the (large) Docker build image by calling `make haskell` in
   `mhuirich/docker` (this will create an image with a tag like
   `mhuirich/haskell:8.10.4-alpine3.13.`)
1. Create a Haskell project and include a `Dockerfile` and a `Makefile` as in
   `./examples/haskell-io-cli`
1. In your `Dockerfile`:
   1. set your `FROM` to use the generated image above
   1. build the app with `ghc` and your preferred options
   1. reduce the executable file size with `upx` (included as part of the
      `mhuirich/haskell` image)
   1. wrap the excecutable in a shell script (only necessary when using a
      generalised `Dockerfile` where the exectuable name is an `ARG`)
1. In your `Makefile`, use `strip-docker-image`
   (available [here](https://github.com/mvanholsteijn/strip-docker-image))
   to create a minimal Docker image
1. In the end, you will have two Docker images, both named after the app, one
   with a `-stripped` suffix. Run both images, ensuring behaviour is as
   expected and identical between the two.

Determining which files should be included in the strip command is a matter or
trial and error: include some basics, build, and attempt to run, then watch for
error messages about missing libraries.

Using this process, a basic CLI I/O Haskell app built on a 3+GB Docker image can
be reduced in size to just under 8MB with very little effort and no special
tweaking. Further reductions in size are possible, with varying degrees of
predictable success.


[//]: ---Named-Links---

[logo]: https://raw.githubusercontent.com/mhuirich/resources/main/images/Logo-v4.0-small.jpg
[logo-large]: https://raw.githubusercontent.com/mhuirich/resources/main/images/Logo-v4.0.png
