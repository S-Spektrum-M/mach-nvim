function RunFile()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand("%")
    local filename_noext = vim.fn.expand("%:t:r")
    local filename_ext = vim.fn.expand("%:t")

    if ft == "python" then
        vim.cmd("FloatermNew --autoclose=0 python3 " .. filename)
    elseif ft == "javascript" then
        vim.cmd("FloatermNew --autoclose=0 node .")
    elseif ft == "c" then
        vim.cmd("FloatermNew --autoclose=0 clang " .. filename .. " -o " .. filename_noext .. " && ./" .. filename_noext)
    elseif ft == "cpp" then
        vim.cmd("FloatermNew --autoclose=0 g++ " .. filename .. " -o " .. filename_noext .. " --std=c++20 && ./" .. filename_noext)
    elseif ft == "typescript" then
        vim.cmd("FloatermNew --autoclose=0 tsc " .. filename .. " && node " .. filename_noext .. ".js")
    elseif ft == "java" then
        vim.cmd("FloatermNew --autoclose=0 javac " .. filename_ext .. " && java " .. filename_noext)
    elseif ft == "go" then
        vim.cmd("FloatermNew --autoclose=0 go run " .. filename)
    elseif ft == "lua" then
        vim.cmd("FloatermNew --autoclose=0 lua " .. filename)
    else
        vim.cmd("call Render()")
    end
end

function RenderLaTex()
    vim.cmd("!biber %:t:r")
    vim.cmd("!pdflatex --shell-escape %:t:r")
end

function RenderLaTexFast()
    vim.cmd("pdflatex --shell-escape %:t:r")
end

function ViewPdf()
    vim.cmd("! zathura " .. vim.fn.expand("%:t:r") .. ".pdf &")
end

function Render()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand("%")
    local filename_noext = vim.fn.expand("%:t:r")
    local filename_ext = vim.fn.expand("%:t")

    if ft == "tex" then
        vim.cmd("call RenderLaTexFast()")
    elseif ft == "plaintex" then
        vim.cmd("call RenderLaTex()")
    elseif ft == "markdown" then
        vim.cmd("FloatermNew pandoc " .. filename_ext .. " -o " .. filename_noext .. ".pdf")
        ViewPdf()
    elseif ft == "html" then
        vim.cmd("!open " .. filename_ext)
    else
        vim.cmd("echom \"unsupported filetype\"")
    end
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true }
local opts_silent = { noremap = true, silent = true }

map("n", "<Leader>m", "<cmd>lua Render()<CR>", opts_silent)
map("n", "<Leader><F10>", ":lua RunFile()", opts)
