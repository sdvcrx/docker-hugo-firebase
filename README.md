# docker-hugo-firebase

[![Docker Image CI](https://github.com/sdvcrx/docker-hugo-firebase/actions/workflows/docker-image.yaml/badge.svg)](https://github.com/sdvcrx/docker-hugo-firebase/actions/workflows/docker-image.yaml)
![Docker Image Size](https://img.shields.io/docker/image-size/sdvcrx/hugo-firebase?sort=date)
![Docker Image Pulls](https://img.shields.io/docker/pulls/sdvcrx/hugo-firebase)

Docker image for deploying [hugo](https://gohugo.io/) sites to [Firebase](https://firebase.google.com/)

Based on [bitnami/minideb](https://github.com/bitnami/minideb) image.

## Usage

Pull docker image from [Docker Hub](https://hub.docker.com/r/sdvcrx/hugo-firebase)

```shell
docker pull sdvcrx/hugo-firebase
```

Or pull from [ghcr.io](https://github.com/sdvcrx/docker-hugo-firebase/pkgs/container/hugo-firebase)

```shell
docker pull ghcr.io/sdvcrx/hugo-firebase
```

## Example

### CLI

Using hugo-firebase image to build hugo site and push to firebase:

```shell
docker run -v `pwd`:/app --rm sdvcrx/hugo-firebase bash -c 'hugo  && firebase deploy --token [token]'
```

### Drone CI

```yaml
- name: build
  image: sdvcrx/hugo-firebase
  pull: always
  environment:
    FIREBASE_TOKEN:
      from_secret: FIREBASE_TOKEN
  commands:
    - hugo --minify
    - firebase deploy --token "$FIREBASE_TOKEN"
```

## Development

This repo is using [GitHub Actions](https://github.com/sdvcrx/docker-hugo-firebase/blob/master/.github/workflows/check-update.yaml) to keep hugo version up to date.
