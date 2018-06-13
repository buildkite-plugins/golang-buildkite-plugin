#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment to enable stub debug output:
# export DOCKER_STUB_DEBUG=/dev/tty

@test "Running go test command against specific version of golang" {
  export BUILDKITE_PIPELINE_SLUG="alpacas"
  export BUILDKITE_COMMAND="go test ./..."
  export BUILDKITE_PLUGIN_GOLANG_PACKAGE="example.org/llamas"
  export BUILDKITE_PLUGIN_GOLANG_VERSION="1.10.0"

  stub docker \
    "run -v $PWD:/go/src/example.org/llamas -w /go/src/example.org/llamas --rm golang:1.10.0 'go test ./...' : echo running go test"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "running go test"

  unstub docker
  unset BUILDKITE_PLUGIN_GOLANG_PACKAGE
  unset BUILDKITE_PLUGIN_GOLANG_VERSION
  unset BUILDKITE_PLUGIN_GOLANG_BUILD_TARGETS_0
}
