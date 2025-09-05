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
        Snacks.terminal.open("pandoc " .. filename_ext .. " -o " .. filename_noext .. ".pdf")
        ViewPdf()
    elseif ft == "html" then
        vim.cmd("!open " .. filename_ext)
    else
        vim.cmd("echom \"unsupported filetype\"")
    end
end

function RunFile()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand("%")
    local filename_noext = vim.fn.expand("%:t:r")
    local filename_ext = vim.fn.expand("%:t")

    if ft == "python" then
        Snacks.terminal.open("python3 " .. filename, { auto_close = false })
    elseif ft == "javascript" then
        Snacks.terminal.open("node .", { auto_close = false })
    elseif ft == "c" then
        Snacks.terminal.open("clang " .. filename .. " -o " .. filename_noext .. " && ./" .. filename_noext, { auto_close = false })
    elseif ft == "cpp" then
        Snacks.terminal.open("g++ " .. filename .. " -o " .. filename_noext .. " --std=c++20 && ./" .. filename_noext, { auto_close = false })
    elseif ft == "typescript" then
        Snacks.terminal.open("tsc " .. filename .. " && node " .. filename_noext .. ".js", { auto_close = false })
    elseif ft == "java" then
        Snacks.terminal.open("javac " .. filename_ext .. " && java " .. filename_noext, { auto_close = false })
    elseif ft == "go" then
        Snacks.terminal.open("go run " .. filename, { auto_close = false })
    elseif ft == "lua" then
        Snacks.terminal.open("lua " .. filename, { auto_close = false })
    else
        Render()
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

local map = vim.keymap.set
local opts = { noremap = true }
local opts_silent = { noremap = true, silent = true }

map("n", "<Leader>m", Render, opts_silent)
map("n", "<Leader>4", RunFile, opts)
