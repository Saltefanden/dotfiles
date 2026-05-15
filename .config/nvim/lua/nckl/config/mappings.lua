-- Helpers for a more concise `<Leader>` mappings.
-- Most of the mappings use `<Cmd>...<CR>` string as a right hand side (RHS) in
-- an attempt to be more concise yet descriptive. See `:h <Cmd>`.
-- This approach also doesn't require the underlying commands/functions to exist
-- during mapping creation: a "lazy loading" approach to improve startup time.
local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end

local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end


-- -- Window navigation maps
if vim.fn.maparg("<leader>1", "n") == "" then
    nmap_leader("1", "<Cmd>Ex<CR>", "Ex")
end
nmap_leader("ed", "<Cmd>e .<CR>", "Open file navigation")
nmap_leader("esd", "<Cmd>vsp .<CR>", "Split open file at cwd")
-- Local window navigation maps
nmap_leader("2", "<Cmd>vsp %:h<CR>", "Open navigation at current file")
nmap_leader("ef", "<Cmd>e %:h<CR>", "Open files at current file")
nmap_leader("esf", "<Cmd>vsp %:h<CR>", "Split open files at current file")
-- Quickfix and location windows
nmap_leader('eq', function()
        vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
    end, 'Quickfix list')
nmap_leader('el', function()
        vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and 'lclose' or 'lopen')
    end, 'Location list')
-- Special files
nmap_leader("ev", "<Cmd>e $MYVIMRC<CR>", "Edit init.lua/vimrc")
nmap_leader("ez", "<Cmd>e $XDG_CONFIG_HOME/zsh/.zshrc<CR>", "Open zshrc")
-- Terminals
nmap_leader("<Enter>", "<Cmd>TermToggle side<CR>", "Open a terminal to the right")
nmap_leader("<leader>", "<Cmd>TermToggle bottom<CR>", "Open a terminal on the bottom")
-- vim.keymap.set("n", "<leader>t", vim.cmd.TermToggle, { desc = "Toggle [T]erminal", silent = true })
-- vim.keymap.set("t", "<C-t>", vim.cmd.TermToggle, { desc = "Toggle [^][T]erminal", silent = true })

nmap_leader("c", "<Cmd>DiffOrig<CR>", "Inspect diff")

-- Diagnostic stuff
-- nmap_leader("dq", vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
-- nmap_leader("dd", vim.diagnostic.open_float, "Open diagnostic float")
nmap_leader("D", function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end, "Toggle diagnostic virtual lines")


-- Fuzzy picking
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',            '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',            '":" history')
nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>',     'Added hunks (all)')
nmap_leader('fA', pick_added_hunks_buf,                         'Added hunks (buf)')
nmap_leader('fb', '<Cmd>Pick buffers<CR>',                      'Buffers')
nmap_leader('fc', '<Cmd>Pick git_commits<CR>',                  'Commits (all)')
nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>',         'Commits (buf)')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>',       'Diagnostic workspace')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>',   'Diagnostic buffer')
nmap_leader('ff', '<Cmd>Pick files<CR>',                        'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>',                    'Grep live')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>',       'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>',                         'Help tags')
nmap_leader('fH', '<Cmd>Pick hl_groups<CR>',                    'Highlight groups')
nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>',        'Lines (all)')
nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>',    'Lines (buf)')
nmap_leader('fm', '<Cmd>Pick git_hunks<CR>',                    'Modified hunks (all)')
nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>',           'Modified hunks (buf)')
nmap_leader('fr', '<Cmd>Pick resume<CR>',                       'Resume')
nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>',       'References (LSP)')
nmap_leader('fs', pick_workspace_symbols_live,                  'Symbols workspace (live)')
nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>',  'Symbols document')
nmap_leader('fv', '<Cmd>Pick visit_paths cwd=""<CR>',           'Visit paths (all)')
nmap_leader('fV', '<Cmd>Pick visit_paths<CR>',                  'Visit paths (cwd)')

nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>',     'Actions')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>',   'Diagnostic popup')
nmap_leader('lf', '<Cmd>lua require("conform").format()<CR>',   'Format')
xmap_leader('lf', '<Cmd>lua require("conform").format()<CR>',   'Format selection')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>',  'Implementation')
nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>',           'Hover')
nmap_leader('ll', '<Cmd>lua vim.lsp.codelens.run()<CR>',        'Lens')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>',          'Rename')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>',      'References')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>',      'Source definition')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')

local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

nmap_leader('ga', '<Cmd>Git diff --cached<CR>',             'Added diff (staged)')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>',        'Added diff buffer (staged)')
nmap_leader('gc', '<Cmd>Git commit<CR>',                    'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',            'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>',                      'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>',                 'Diff buffer')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',         'Log')
nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>',     'Log buffer')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',  'Show at cursor')
nmap_leader('gp', '<Cmd>Git push<CR>',                      'Push')

xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')

nmap_leader('wo', '<Cmd>lua require("mini.misc").zoom()<CR>',   'Zoom toggle')

vim.keymap.set("i", "<C-0>", function()
        require("mini.completion").stop()
    end,
    { desc ="Stop completion stuff" }
)


-- Use <Esc> to exit terminal mode
vim.keymap.set("t", "<Esc>", '<C-\\><C-n>',
    { desc = "Use <Esc> to exit terminal mode" })


vim.keymap.set("n", "<C-j>", "<Cmd>m .+1<CR>==") -- Errors on invalid range..
vim.keymap.set("n", "<C-k>", "<Cmd>m .-2<CR>==")

vim.keymap.set("v", "<C-j>", "<Cmd>m '>+1<CR>gv=gv") -- Errors on invalid range..
vim.keymap.set("v", "<C-k>", "<Cmd>m '<-2<CR>gv=gv")


-- Less disorienting page scrolls
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


-- System clipboard usage with leader y
vim.keymap.set( {"n", "v"} , "<leader>y", "\"+y",
    { desc = "Use system clipboard with <leader>y" })

vim.keymap.set( {"n", "v"} , "<leader>Y", "\"+Y",
    { desc = "Use system clipboard with <leader>Y" })

vim.keymap.set( "x", "<leader>p", '"_dP',
    { desc = "In visual mode exclusively (not select mode), paste without yanking" })

vim.keymap.set( { "n", "v" }, "<leader>x", '"_d',
    { desc = "Delete without yanking" })

vim.keymap.set( "x", ">", ">gv",
    { desc = "Indent with reselet" })

vim.keymap.set( "x", "<", "<gv",
    { desc = "Unindent with reselet" })


--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-S-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-S-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-S-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-S-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<A-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<A-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<A-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<A-k>', '<C-w>K', { desc = 'Move window to the upper' })

