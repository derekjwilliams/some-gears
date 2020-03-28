# This simple example is the same as ../mimi-server but structured

This is a fairly standard structure, with the schema and resolvers in to their own files.

## Other changes from ../mimi-server

### import and export instead of require

[esm](https://www.npmjs.com/package/esm) is used to provide support for standard JavaScript import and export, which are not supported natively in node yet (as of 13.9).  The `--experimental-support` flag could also be used if one does not want to use esm.



