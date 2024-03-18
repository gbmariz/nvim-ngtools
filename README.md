# Ng Tools
The plugin adds @angular/cli command line functions to speed up development of the framework.
To use the plugin, call the ngt.setup() function.

## Install
Use your favourite dependency manager.

For [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "gbmariz/nvim-ngtools",
    dependencies = { "rcarriga/nvim-notify" },
    opts = {}
}
```

For [pckr.nvim](https://github.com/lewis6991/pckr.nvim)
```lua
{
    "gbmariz/nvim-ngtools",
    require = { "rcarriga/nvim-notify" }
}
```

## Setup
To initialize and configure ngtools, run the `setup` function.

Read the documentation for more information `:help ng_tools`.

