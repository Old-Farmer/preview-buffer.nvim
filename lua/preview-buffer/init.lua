local M = {}

local preview_buffer = -1

function M.preview_buffer()
  return preview_buffer
end

function M.cancel_preview()
  preview_buffer = -1
end

function M.setup(opts)
  local callback
  if opts.callback then
    callback = opts.callback
  end

  local group_id = vim.api.nvim_create_augroup("preview-buffer-group", { clear = true })
  vim.api.nvim_create_autocmd("BufAdd", {
    group = group_id,
    pattern = "*",
    callback = function(args)
      if preview_buffer ~= -1 then
        vim.cmd("bdelete" .. tostring(preview_buffer))
      end
      preview_buffer = args.buf
      callback(preview_buffer)
      vim.api.nvim_create_autocmd("TextChanged", {
        buffer = preview_buffer,
        once = true,
        callback = function(inner_args)
          if preview_buffer == inner_args.buf then
            preview_buffer = -1
            callback(preview_buffer)
          end
        end,
      })
      vim.api.nvim_create_autocmd({ "TextChanged", "BufDelete" }, {
        buffer = preview_buffer,
        once = true,
        callback = function(inner_args)
          if preview_buffer == inner_args.buf then
            preview_buffer = -1
            callback(preview_buffer)
          end
        end,
      })
    end,
  })

  -- vim.api.nvim_del_autocmd(group_id)
end

return M
