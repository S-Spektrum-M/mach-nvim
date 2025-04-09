function RunFile()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand('%')
    local filename_noext = vim.fn.expand('%:t:r')
    local filename_ext = vim.fn.expand('%:t')

    if ft == 'python' then
        vim.cmd('!python3 ' .. filename)
    elseif ft == 'javascript' then
        vim.cmd('!node .')
    elseif ft == 'c' then
        vim.cmd('!clang ' .. filename .. ' -o ' .. filename_noext .. ' && ./' .. filename_noext)
    elseif ft == 'cpp' then
        vim.cmd('!g++ ' .. filename .. ' -o ' .. filename_noext .. ' --std=c++20 && ./' .. filename_noext)
    elseif ft == 'typescript' then
        vim.cmd('!tsc ' .. filename .. ' && node ' .. filename_noext .. '.js')
    elseif ft == 'java' then
        vim.cmd('!javac ' .. filename_ext .. ' && java ' .. filename_noext)
    elseif ft == 'go' then
        vim.cmd('!go run ' .. filename)
    elseif ft == 'lua' then
        vim.cmd('!lua ' .. filename)
    else
        vim.cmd('call Render()')
    end
end

function RenderLaTex()
    vim.cmd("!biber %:t:r")
    vim.cmd("!pdflatex --shell-escape %:t:r")
end

function RenderLaTexFast()
    vim.cmd("pdflatex --shell-escape %:t:r")
end

function Render()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand('%')
    local filename_noext = vim.fn.expand('%:t:r')
    local filename_ext = vim.fn.expand('%:t')

    if ft == 'tex' then
        vim.cmd('call RenderLaTexFast()')
    elseif ft == 'plaintex' then
        vim.cmd('call RenderLaTex()')
    elseif ft == 'markdown' then
        vim.cmd('!pandoc ' .. filename_ext .. ' -o ' .. filename_noext .. '.pdf')
        vim.cmd('!wslview ' .. filename_noext .. '.pdf')
    elseif ft == 'html' then
        vim.cmd('!open ' .. filename_ext)
    else
        vim.cmd('echom "unsupported filetype"')
    end
end

function ViewPdf()
    vim.cmd('! zathura ' .. vim.fn.expand('%:t:r') .. '.pdf &')
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true }
local opts_silent = { noremap = true, silent = true }

map("n", "<Leader>m", "<cmd>lua Render()<CR>", opts_silent)
map("n", "<Leader><F10>", ":lua RunFile()", opts)
