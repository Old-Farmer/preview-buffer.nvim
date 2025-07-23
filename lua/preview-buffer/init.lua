local M = {}

local preview_buffer = nil

local default_opts = {
  callback = function(buf) end,
}

local final_opts = {}

function M.preview_buffer()
  return preview_buffer
end

function M.cancel_preview()
  preview_buffer = -1
end

function M.enable()
  preview_buffer = -1
  local group_id = vim.api.nvim_create_augroup("preview-buffer.group", { clear = true })
  vim.api.nvim_create_autocmd("BufAdd", {
    group = group_id,
    pattern = "*",
    callback = function(args)
      if preview_buffer ~= -1 then
        local prev_preview_buffer = preview_buffer
        vim.api.nvim_create_autocmd("BufReadPost", {
          group = group_id,
          buffer = args.buf,
          once = true,
          callback = function()
            vim.cmd("bdelete" .. tostring(prev_preview_buffer))
          end,
        })
      end
      preview_buffer = args.buf
      final_opts.callback(preview_buffer)
      vim.api.nvim_create_autocmd({ "TextChanged", "BufDelete" }, {
        group = group_id,
        buffer = args.buf,
        once = true,
        callback = function(inner_args)
          if preview_buffer == inner_args.buf then
            preview_buffer = -1
            final_opts.callback(preview_buffer)
          end
        end,
      })
    end,
  })
end

function M.disable()
  vim.api.nvim_del_augroup_by_name("preview-buffer.group")
  preview_buffer = -1
end

function M.toggle()
  if preview_buffer == nil then
    M.enable()
  else
    M.disable()
  end
end

function M.setup(opts)
  final_opts = vim.tbl_extend("force", default_opts, opts)
  M.enable()

  vim.api.nvim_create_user_command("PreviewBufferToggle", M.toggle, {})
end

return M
