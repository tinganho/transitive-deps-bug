Transitive dependency are not linked underneath `node_modules`
===============

A demo of the bug that causes portability issues in `rules_js`:

Just run:
```
bazel run //:foo --sandbox_debug
```

And it will produce the following error:

```
error TS2742: The inferred type of 'Offline' cannot be named without a reference to '.aspect_rules_js/@myorg+c@0.0.0/node_modules/@myorg/c/qux'. This is likely not portable. A type annotation is necessary.
```

The reasons seems to be there is no linkage underneath `node_modules`(The screenshot is of the bin folder in sandbox and it seems to be missing `node_modules/@myorg/c`):

![Screenshot of the bug](screenshot.png "Screenshot")

Also, to reproduce wheren't so easy. It requires at least import with file reference i.e. `@org/package/file` and an enum in the transitive dep, and in the source file you also need some type operation fiddling to reproduce it.

And when you remove `data` attribute in `ts.bzl` the error dissapears:

![Screenshot of the bug](ts.bzl.png "Screenshot")
