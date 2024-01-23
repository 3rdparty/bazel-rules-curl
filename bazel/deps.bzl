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
        # BoringSSL doesn't usually cut releases, so we use a commit
        # from the 'main-with-bazel' branch, that has bazel rules for
        # it's dependencies.
        commit = "652d66d1feb8ba612e776e03182fa1c8f716d265",
        remote = "https://boringssl.googlesource.com/boringssl",
        shallow_since = "1705953338 +0000",
        repo_mapping = repo_mapping,
    )

    maybe(
        new_git_repository,
        name = "boringssl_with_bazel_rules_curl_build_file",
        build_file = "@com_github_3rdparty_bazel_rules_curl//:BUILD.boringssl.bazel",
        commit = "652d66d1feb8ba612e776e03182fa1c8f716d265",
        remote = "https://boringssl.googlesource.com/boringssl",
        shallow_since = "1705953338 +0000",
        repo_mapping = repo_mapping,
    )

    maybe(
        http_archive,
        name = "com_github_curl_curl",
        url = "https://github.com/curl/curl/archive/refs/tags/curl-7_83_0.tar.gz",
        sha256 = "9350985ab43591ecd04b087f9c9dad84b952c35c6012e2a08ae355ae797db988",
        strip_prefix = "curl-curl-7_83_0",
        build_file = "@com_github_3rdparty_bazel_rules_curl//:BUILD.bazel",
        repo_mapping = repo_mapping,
    )
