package(default_visibility = ["//visibility:public"])

load(
    "@io_bazel_rules_docker//python:image.bzl",
    "py_image",
)

py_binary(
    name = "php_cached",
    srcs = [
        "main.py",
        "//ftl/cached:cached_lib",
    ],
    data = ["//ftl:php_builder.par"],
    main = "main.py",
    deps = [
        "//ftl:ftl_lib",
        "@containerregistry",
    ],
)

py_image(
    name = "php_cached_image",
    srcs = [
        "main.py",
        "//ftl/cached:cached_lib",
    ],
    base = "@php_base//image",
    main = "main.py",
    deps = [
        "//ftl:ftl_lib",
        "@containerregistry",
    ],
)
