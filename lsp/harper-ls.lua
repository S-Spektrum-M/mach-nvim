local exe_name = require('mach.lsp_util').exe_name

local default_config = {
    cmd = { exe_name('harper-ls'), '--stdio' },
    filetypes = { 'markdown', 'text', 'latex', 'plaintex',  },
}

return default_config
