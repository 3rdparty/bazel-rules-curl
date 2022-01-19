"""Dependency specific initialization."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

def deps(repo_mapping = {}):
    rules_foreign_cc_dependencies()

    maybe(
        git_repository,
        name = "boringssl",
        commit = "b9232f9e27e5668bc0414879dcdedb2a59ea75f2",
        remote = "https://boringssl.googlesource.com/boringssl",
        shallow_since = "1637714942 +0000",
        repo_mapping = repo_mapping,
    )

    maybe(
        new_git_repository,
        name = "boringssl_with_bazel_rules_curl_build_file",
        build_file = "@com_github_3rdparty_bazel_rules_curl//:BUILD.boringssl.bazel",
        commit = "b9232f9e27e5668bc0414879dcdedb2a59ea75f2",
        remote = "https://boringssl.googlesource.com/boringssl",
        shallow_since = "1637714942 +0000",
        repo_mapping = repo_mapping,
    )

    maybe(
        http_archive,
        name = "com_github_curl_curl",
        url = "https://github.com/curl/curl/archive/refs/tags/curl-7_78_0.tar.gz",
        sha256 = "ffa8f79f68dd77b08987ce16acd1f292875df8ab3bf7e3654f98d62b445ebd9a",
        strip_prefix = "curl-curl-7_78_0",
        build_file = "@com_github_3rdparty_bazel_rules_curl//:BUILD.bazel",
        repo_mapping = repo_mapping,
    )
