#!/usr/bin/env bats

load "${BATS_PLUGIN_PATH}/load.bash"

# Uncomment to enable stub debug output:
# export DOCKER_STUB_DEBUG=/dev/tty

export BUILDKITE_PIPELINE_SLUG="alpacas"
export BUILDKITE_COMMAND="go test ./..."

@test "Default options run command" {
  stub docker \
    "run --rm --volume $PWD:/go/src/alpacas --workdir /go/src/alpacas golang:latest sh -c \* : echo running \${10}"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "running go test"

  unstub docker
}


@test "Runs command with specific import" {
  export BUILDKITE_PLUGIN_GOLANG_IMPORT="example.org/llamas"

  stub docker \
    "run --rm --volume $PWD:/go/src/example.org/llamas --workdir /go/src/example.org/llamas golang:latest sh -c \* : echo running \${10}"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "running go test"

  unstub docker
}

@test "Running command with specific version of golang" {
  export BUILDKITE_PLUGIN_GOLANG_VERSION="1.10.0"

  stub docker \
    "run --rm --volume \* --workdir \* golang:1.10.0 sh -c \* : echo running \${10}"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "running go test"

  unstub docker
}

@test "Runs command with environment" {
  export BUILDKITE_PLUGIN_GOLANG_ENVIRONMENT_0='MY_TAG=value'
  export BUILDKITE_PLUGIN_GOLANG_ENVIRONMENT_1='ANOTHER_TAG=llamas'

  stub docker \
    "run --rm --volume $PWD:/go/src/alpacas --workdir /go/src/alpacas --env MY_TAG=value --env ANOTHER_TAG=llamas golang:latest sh -c \* : echo running \${14}"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "running go test"

  unstub docker
}
