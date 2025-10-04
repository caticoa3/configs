local M = {}

-- Configuration for dotfiles bare repository
local dotfiles_dir = vim.fn.expand('$HOME/.myconfig')
local dotfiles_work_tree = vim.fn.expand('$HOME')

-- Run git command for the dotfiles repository
local function run_config_command(command, capture_output)
  local git_cmd = 'git --git-dir=' .. dotfiles_dir .. ' --work-tree=' .. dotfiles_work_tree .. ' ' .. command
  
  if capture_output then
    return vim.fn.system(git_cmd)
  else
    vim.cmd('!' .. git_cmd)
  end
end

-- Set up custom Fugitive-like commands for the dotfiles repository
function M.setup()
  -- ConfigLazygit - Open lazygit for dotfiles in a floating terminal
  vim.api.nvim_create_user_command('ConfigLazygit', function()
    local cmd = 'lazygit --git-dir=' .. dotfiles_dir .. ' --work-tree=' .. dotfiles_work_tree
    vim.cmd('terminal ' .. cmd)
    vim.cmd('startinsert')
  end, {})

  -- ConfigDiffview - Open diffview for dotfiles
  vim.api.nvim_create_user_command('ConfigDiffview', function()
    -- Set environment variables for git
    vim.env.GIT_DIR = dotfiles_dir
    vim.env.GIT_WORK_TREE = dotfiles_work_tree

    -- Open diffview for working directory changes
    vim.cmd('DiffviewOpen')

    -- Clean up environment variables after a short delay
    vim.defer_fn(function()
      vim.env.GIT_DIR = nil
      vim.env.GIT_WORK_TREE = nil
    end, 500)
  end, {})

  -- ConfigStatus - similar to Gstatus
  vim.api.nvim_create_user_command('ConfigStatus', function()
    -- Create a temp file with git status output
    local temp_file = vim.fn.tempname()
    local status_output = run_config_command('status', true)
    local file = io.open(temp_file, 'w')
    if file then
      file:write(status_output)
      file:close()

      -- Open in a new buffer
      vim.cmd('split ' .. temp_file)
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'wipe'
      vim.bo.filetype = 'git'
      vim.cmd('file [config\\ status]')
    end
  end, {})
  
  -- ConfigDiff - diff a file
  vim.api.nvim_create_user_command('ConfigDiff', function(opts)
    local file = opts.args ~= "" and opts.args or vim.fn.expand('%:p')
    local relative_path = file:gsub(dotfiles_work_tree .. '/', '')
    
    -- Create temp files with different versions
    local temp_current = vim.fn.tempname()
    local temp_staged = vim.fn.tempname()
    
    -- Get current content
    if vim.fn.filereadable(file) == 1 then
      vim.fn.system('cp ' .. file .. ' ' .. temp_current)
    else
      vim.fn.system('touch ' .. temp_current)
    end
    
    -- Get staged content
    run_config_command('show :' .. relative_path .. ' > ' .. temp_staged, false)
    
    -- Show diff
    vim.cmd('diffsplit ' .. temp_staged)
    vim.cmd('file [config\\ staged]')
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'wipe'
  end, {nargs = '?', complete = 'file'})
  
  -- ConfigAdd - add a file
  vim.api.nvim_create_user_command('ConfigAdd', function(opts)
    local file = opts.args ~= "" and opts.args or vim.fn.expand('%:p')
    run_config_command('add ' .. file, false)
  end, {nargs = '?', complete = 'file'})
  
  -- ConfigCommit - commit changes
  vim.api.nvim_create_user_command('ConfigCommit', function()
    vim.cmd('terminal git --git-dir=' .. dotfiles_dir .. ' --work-tree=' .. dotfiles_work_tree .. ' commit')
  end, {})
  
  -- ConfigPush - push changes
  vim.api.nvim_create_user_command('ConfigPush', function()
    run_config_command('push', false)
  end, {})
end

return M 