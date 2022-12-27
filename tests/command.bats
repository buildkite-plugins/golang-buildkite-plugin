#!/usr/bin/env bats

load "${BATS_PLUGIN_PATH}/load.bash"

# Uncomment to enable stub debug output:
# export DOCKER_STUB_DEBUG=/dev/tty

export BUILDKITE_PIPELINE_SLUG="alpacas"

@test "Running command with specific version of golang" {
  export BUILDKITE_COMMAND="go test ./..."
  export BUILDKITE_PLUGIN_GOLANG_IMPORT="example.org/llamas"
  export BUILDKITE_PLUGIN_GOLANG_VERSION="1.10.0"

  stub docker \
    "run --rm --volume $PWD:/go/src/example.org/llamas --workdir /go/src/example.org/llamas golang:1.10.0 sh -c 'go test ./...' : echo running go test"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "running go test"

  unstub docker
}

@test "Runs command with environment" {
  export BUILDKITE_COMMAND="go test ./..."
  export BUILDKITE_PLUGIN_GOLANG_IMPORT="example.org/llamas"
  export BUILDKITE_PLUGIN_GOLANG_VERSION="1.10.0"
  export BUILDKITE_PLUGIN_GOLANG_ENVIRONMENT_0='MY_TAG=value'
  export BUILDKITE_PLUGIN_GOLANG_ENVIRONMENT_1='ANOTHER_TAG=llamas'

  stub docker \
    "run --rm --volume $PWD:/go/src/example.org/llamas --workdir /go/src/example.org/llamas --env MY_TAG=value --env ANOTHER_TAG=llamas golang:1.10.0 sh -c 'go test ./...' : echo running go test"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "running go test"

  unstub docker
}
