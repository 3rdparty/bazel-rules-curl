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
        url = "https://github.com/curl/curl/archive/refs/tags/curl-7_83_1.tar.gz",
        sha256 = "903f89dee3be8c9749862b4f1ac9faae8fba49b1a00a7cbf06af6fce16494309",
        strip_prefix = "curl-curl-7_83_1",
        build_file = "@com_github_3rdparty_bazel_rules_curl//:BUILD.bazel",
        repo_mapping = repo_mapping,
    )
