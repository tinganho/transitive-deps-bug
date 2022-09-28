load(":npm.bzl", "npm_package_name", "npm_package_label", "current_label", "package_json")
load("@aspect_rules_js//npm:defs.bzl", "npm_package")
load("@aspect_rules_ts//ts:defs.bzl", "ts_project")


def ts_test(name, srcs = [], deps = []):
    ts_project(
        name = "ts_project",
        srcs = srcs,
        tsconfig = "//:tsconfig",
        declaration = True,
        supports_workers = False,
        deps = [npm_package_label(dep) for dep in deps],
        data = [npm_package_label(dep) for dep in deps],
    )
    package_name = npm_package_name(current_label(name))
    package_json(
        name = "package_json",
        package_name = package_name,
    )
    npm_package(
        name = name,
        package = package_name,
        include_srcs_patterns = ["*.js", "*.d.ts", "*.json"],
        srcs = [":ts_project", ":package_json"],
    )


