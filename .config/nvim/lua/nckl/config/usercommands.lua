vim.cmd([[
    if !exists(":DiffOrig")
      command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
              \ | wincmd p | diffthis
    endif
]])

vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })

vim.api.nvim_create_user_command('OpenTerm', function(direction)
   -- 1. Decide the split type
    if direction.fargs[1] == "side" then
        vim.cmd("botright vsplit")
    elseif direction.fargs[1] == "bottom" then
        -- Default to bottom if no arg or "bottom" is passed
        vim.cmd("botright split")
        vim.cmd("resize" .. (vim.v.count>1 and vim.v.count or 10)) -- Adjust height for bottom terminal
    end
    -- 2. Open the terminal
    vim.cmd("term")
    -- -- -- 3. Standard terminal cleanup/settings
    vim.cmd("startinsert")
end, {count=true, nargs = 1, complete = function() return {"bottom", "side"} end})


vim.api.nvim_create_user_command("TermToggle", function(direction)
    local is_open = vim.g.term_win_id ~= nil and vim.api.nvim_win_is_valid(vim.g.term_win_id)

    if is_open then
        vim.api.nvim_win_hide(vim.g.term_win_id)
        vim.g.term_win_id = nil
        return
    end

    if direction.fargs[1] == "side" then
        vim.cmd("botright vsplit")
    elseif direction.fargs[1] == "bottom" then
        -- Default to bottom if no arg or "bottom" is passed
        vim.cmd("botright split")
        vim.cmd("resize" .. (vim.v.count>1 and vim.v.count or 10)) -- Adjust height for bottom terminal
    end

    vim.g.term_win_id = vim.api.nvim_get_current_win()

    local has_term_buf = vim.g.term_buf_id ~= nil and vim.api.nvim_buf_is_valid(vim.g.term_buf_id)

    if has_term_buf then
        vim.api.nvim_win_set_buf(vim.g.term_win_id, vim.g.term_buf_id)
    else
        vim.cmd.term()
        vim.g.term_buf_id = vim.api.nvim_get_current_buf()
    end

    vim.cmd.startinsert()
end, {count=true, nargs = 1, complete = function() return {"bottom", "side"} end})

