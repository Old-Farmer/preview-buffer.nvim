# preview-buffer.nvim

Vscode preview tab like feature in neovim.

This plugin automatically choose an unmodified buffer as a preview buffer, every new buffer will replace the previous preview buffer. This plugin is useful if you don't want to have a lot of buffers in the buffer list.

## Installation & Configuration

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
  -- buf is buffer id, -1 if no preview buffer, nil if disable
  callback = function(buf)
    print(buf)
  end
})
```

## Commands

- `PreviewBufferToggle` Toggle this plugin

## Functions

```lua
local preview_buffer = require("preview-buffer")
-- Get the preview buffer id, -1 if none, nil if not enable
preview_buffer.preview_buffer()
-- Don't preview the current preview buffer
preview_buffer.cancel_preview()
-- Enable preview-buffer
preview_buffer.enable()
-- Disable preview-buffer
preview_buffer.disable()
-- Toggle preview-buffer
preview_buffer.toggle()
```
