# Bazel build rules for [curl](https://github.com/curl/curl)

Follows a "repos/deps" pattern (in order to help with recursive dependencies). To use:

1. Copy `bazel/repos.bzl` into your repository at `3rdparty/bazel-rules-curl/repos.bzl` and add an empty `BUILD` (or `BUILD.bazel`) to `3rdparty/bazel-rules-curl` as well.

2. Copy all of the directories from `3rdparty` that you ***don't*** already have in ***your*** repository's `3rdparty` directory.

3. Either ... add the following to your `WORKSPACE` (or `WORKSPACE.bazel`):

```bazel
load("//3rdparty/bazel-rules-curl:repos.bzl", curl_repos="repos")
curl_repos()

load("@com_github_3rdparty_bazel_rules_curl//bazel:deps.bzl", curl_deps="deps")
curl_deps()
```

Or ... to simplify others depending on ***your*** repository, add the following to your `repos.bzl`:

```bazel
load("//3rdparty/bazel-rules-curl:repos.bzl", curl_repos="repos")

def repos():
    curl_repos()
```

And the following to your `deps.bzl`:

```bazel
load("@com_github_3rdparty_bazel_rules_curl//bazel:deps.bzl", curl_deps="deps")

def deps():
    curl_deps()
```

4. You can then use `@com_github_curl_curl//:libcurl` in your target's `deps`.

5. Repeat the steps starting at (1) at the desired version of this repository that you want to use:

| curl | Copy `bazel/repos.bzl` from: |
| :---: | :--------------------------: |
| 7.78.0 | [a1648d5](https://github.com/3rdparty/bazel-rules-curl/tree/a1648d56cf75fdeb524c35abce48c245c924fb75) |
