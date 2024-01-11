<div align="center">

# asdf-ghostscript [![Build](https://github.com/igno/asdf-ghostscript/actions/workflows/build.yml/badge.svg)](https://github.com/igno/asdf-ghostscript/actions/workflows/build.yml) [![Lint](https://github.com/igno/asdf-ghostscript/actions/workflows/lint.yml/badge.svg)](https://github.com/igno/asdf-ghostscript/actions/workflows/lint.yml)

[ghostscript](https://github.com/igno/asdf-ghostscript) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add ghostscript
# or
asdf plugin add ghostscript https://github.com/igno/asdf-ghostscript.git
```

ghostscript:

```shell
# Show all installable versions
asdf list-all ghostscript

# Install specific version
asdf install ghostscript latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ghostscript latest

# Now ghostscript commands are available
gs --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/igno/asdf-ghostscript/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Erik Jutemar](https://github.com/igno/)
