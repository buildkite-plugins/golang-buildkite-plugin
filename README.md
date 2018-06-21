# Golang Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) for running a command in a docker container with a [specific golang version](https://hub.docker.com/_/golang/).

The build directory is mounted into the docker container, so artifact uploads work.

## Example

You can run go commands against a specific version.

```yml
steps:
  - command: go test ./...
    plugins:
      golang#v1.0.0:
        version: 1.10.2
        import: github.com/buildkite/agent
```

You can pass in additional environment variables:

```yml
steps:
  - command: go build .
    plugins:
      golang#v1.0.0:
        version: 1.10.2
        import: github.com/buildkite/agent
        environment:
          - GOOS=darwin
          - GOARCH=amd64
```

## Configuration

### `version` (required)

The golang docker image to use. See https://hub.docker.com/_/golang/ for a full list.

Example: `1.10.2`

### `import`(required)

The golang package to use in the gopath in the container.

Exmaple: `github.com/buildkite/agent`

### `environment` (optional)

Extra environment variables to pass to the docker container, in an array. Items can be specified as either `KEY` or `KEY=value`. Each entry corresponds to a Docker CLI `--env` parameter. Values specified as variable names will be passed through from the outer environment.

Examples: `MY_SECRET_KEY`, `MY_SPECIAL_BUT_PUBLIC_VALUE=kittens`

## License

MIT (see [LICENSE](LICENSE))
