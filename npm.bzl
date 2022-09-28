
NPM_WORKSPACES = {
    "//packages/a:a": "a",
    "//packages/b:b": "b",
    "//packages/c:c": "c",
}

def npm_package_name(target):
    return "@myorg/{}".format(NPM_WORKSPACES[target])

def npm_package_label(target):
    return "//:node_modules/{}".format(npm_package_name(target))

def current_label(name):
    return "//{package_name}:{name}".format(
        package_name = native.package_name(),
        name = name)

def _package_json_impl(ctx):
    package_json = dict(
        name = ctx.attr.package_name,
        private = True,
        dependencies = ctx.attr.dependencies,
    )
    file = ctx.actions.declare_file("package.json")
    ctx.actions.write(file, json.encode_indent(package_json, indent="    "))
    return [
        DefaultInfo(files = depset([file]))
    ]

package_json = rule(
    implementation = _package_json_impl,
    attrs = dict(
        package_name = attr.string(
            mandatory = True,
        ),
        dependencies = attr.string_dict()
    ),
)