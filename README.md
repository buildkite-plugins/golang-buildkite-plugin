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
        package: github.com/buildkite/agent
```

## Configuration

### `version` (required)

The golang docker image to use. See https://hub.docker.com/_/golang/ for a full list.

Example: `1.10.2`

### `package`(required)

The golang package to use in the gopath in the container.

Exmaple: `github.com/buildkite/agent`

## License

MIT (see [LICENSE](LICENSE))
