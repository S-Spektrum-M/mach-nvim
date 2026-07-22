-- Usage: nvim --headless -u NONE -i NONE -l scripts/generate_help.lua
local source_path = arg[1] or "reference.md"
local output_path = arg[2] or "doc/mach.txt"

local function read_lines(path)
    local file = assert(io.open(path, "r"))
    local lines = {}

    for line in file:lines() do
        table.insert(lines, line)
    end

    file:close()
    return lines
end

local function slugify(title)
    if title == "Debugging C and C++" then
        return "debugging-c-cpp"
    end

    return title
        :lower()
        :gsub("[^%w%s-]", "")
        :gsub("[%s_]+", "-")
        :gsub("%-+", "-")
        :gsub("^%-", "")
        :gsub("%-$", "")
end

local function tagged_heading(title, tag)
    local marker = "*" .. tag .. "*"
    local padding = math.max(1, 78 - #title - #marker)
    return title .. string.rep(" ", padding) .. marker
end

local function parse_table_row(line)
    local cells = {}

    line = line:gsub("^%s*|", ""):gsub("|%s*$", "") .. "|"

    for cell in line:gmatch("([^|]*)|") do
        cell = cell:gsub("^%s+", ""):gsub("%s+$", "")
        table.insert(cells, cell)
    end

    return cells
end

local function is_table_divider(cells)
    if #cells == 0 then
        return false
    end

    for _, cell in ipairs(cells) do
        if not cell:match("^:?-+:?$") then
            return false
        end
    end

    return true
end

local function render_table(rows)
    local widths = {}

    for _, row in ipairs(rows) do
        if not is_table_divider(row) then
            for column, cell in ipairs(row) do
                widths[column] = math.max(widths[column] or 0, #cell)
            end
        end
    end

    local rendered = {}
    local row_number = 0

    for _, row in ipairs(rows) do
        if not is_table_divider(row) then
            row_number = row_number + 1
            local columns = {}

            for column, cell in ipairs(row) do
                table.insert(columns, cell .. string.rep(" ", widths[column] - #cell))
            end

            table.insert(rendered, (table.concat(columns, "  "):gsub("%s+$", "")))

            if row_number == 1 then
                local dividers = {}
                for _, width in ipairs(widths) do
                    table.insert(dividers, string.rep("-", width))
                end
                table.insert(rendered, table.concat(dividers, "  "))
            end
        end
    end

    return rendered
end

local source = read_lines(source_path)
local sections = {}

for _, line in ipairs(source) do
    local title = line:match("^## (.+)$")
    if title then
        table.insert(sections, { title = title, tag = "mach-" .. slugify(title) })
    end
end

local output = {
    "*mach.txt*                    Mach Neovim Reference                    *mach*",
}

local first_section = 1
while first_section <= #source and not source[first_section]:match("^## ") do
    if not source[first_section]:match("^# ") then
        local line = source[first_section]
        line = line:gsub("%[([^%]]+)%]%(([^%)]+)%)", "%1 (%2)")
        line = line:gsub("%*%*([^*]+)%*%*", "%1")
        table.insert(output, line)
    end
    first_section = first_section + 1
end

table.insert(output, "==============================================================================")
table.insert(output, tagged_heading("CONTENTS", "mach-contents"))
table.insert(output, "")

for _, section in ipairs(sections) do
    table.insert(output, string.format("%-34s |%s|", section.title, section.tag))
end

table.insert(output, "")

local index = first_section
local in_code_block = false

while index <= #source do
    local line = source[index]
    local level_one = line:match("^# (.+)$")
    local level_two = line:match("^## (.+)$")
    local level_three = line:match("^### (.+)$")

    if level_one then
        -- The document title is represented by the help-file header.
    elseif level_two then
        table.insert(output, "==============================================================================")
        table.insert(output, tagged_heading(level_two:upper(), "mach-" .. slugify(level_two)))
    elseif level_three then
        table.insert(output, "------------------------------------------------------------------------------")
        table.insert(output, tagged_heading(level_three, "mach-" .. slugify(level_three)))
    elseif line:match("^```") then
        if in_code_block then
            table.insert(output, "<")
        else
            local language = line:match("^```(%S*)$") or ""
            table.insert(output, ">" .. language)
        end
        in_code_block = not in_code_block
    elseif line:match("^|.*|%s*$") then
        local rows = {}

        while index <= #source and source[index]:match("^|.*|%s*$") do
            table.insert(rows, parse_table_row(source[index]))
            index = index + 1
        end

        for _, rendered_line in ipairs(render_table(rows)) do
            table.insert(output, rendered_line)
        end

        index = index - 1
    else
        line = line:gsub("%[([^%]]+)%]%(([^%)]+)%)", "%1 (%2)")
        line = line:gsub("%*%*([^*]+)%*%*", "%1")
        table.insert(output, line)
    end

    index = index + 1
end

table.insert(output, "")
table.insert(output, "vim:tw=78:ts=8:noet:ft=help:norl:")

local output_file = assert(io.open(output_path, "w"))
output_file:write(table.concat(output, "\n"), "\n")
output_file:close()

vim.cmd.helptags(vim.fn.fnamemodify(output_path, ":h"))
