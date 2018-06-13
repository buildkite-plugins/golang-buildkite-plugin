# Golang Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) for running a command in a specific golang version.

## Example: Run a specific golang version

```yml
steps:
  - command: go test ./...
    plugins:
      - golang#v1.0.0:
          version: 1.10.2
          package: github.com/buildkite/agent
```

## License

MIT (see [LICENSE](LICENSE))
