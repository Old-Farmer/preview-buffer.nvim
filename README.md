# preview-buffer.nvim

Vscode preview tab like feature in neovim.

This plugin automatically choose an unmodified buffer as a preview buffer, every new buffer will replace the previous preview buffer.

## Installation & Confiuration

Use your favourate plugin manager, e.g. neovim built-in plugin manager in 0.12

```lua
vim.pack.add({ "https://github.com/Old-Farmer/preview-buffer.nvim" })
```

Then setup it.

```lua
require("preview-buffer").setup()
```

You maybe want to setup a callback when the preview buffer changes.


```lua
require("preview-buffer").setup({
  callback = function(buf)
    print(buf)
  end
})
```

## Functions

```lua
require("preview-buffer").preview_buffer() -- Get preview-buffer id
require("preview-buffer").cancel_preview() -- Don't preview the current preview buffer
```
