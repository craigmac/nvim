local M = {}

-- Helper function to adjust HSL brightness
local function adjust_brightness(color, factor)
    if not color then return nil end

    -- Convert hex to RGB
    local r = bit.rshift(bit.band(color, 0xFF0000), 16)
    local g = bit.rshift(bit.band(color, 0x00FF00), 8)
    local b = bit.band(color, 0x0000FF)

    -- Increase brightness (clamped to 255)
    r = math.min(255, math.floor(r * factor))
    g = math.min(255, math.floor(g * factor))
    b = math.min(255, math.floor(b * factor))

    -- Convert back to hex using LuaJIT bit operations
    return bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b)
end

function M.brighten_current_line()
    local current_line = vim.fn.line('.')
    local ns_id = vim.api.nvim_create_namespace('bright_line')

    -- Clear previous highlights
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

    -- Get syntax stack at cursor position
    local synstack = vim.fn.synstack(current_line, 1)
    if not synstack or #synstack == 0 then
        -- If no syntax groups found, brighten the Normal highlight
        local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
        if normal_hl.fg then
            local brightened = adjust_brightness(normal_hl.fg, 1.2)
            vim.api.nvim_buf_add_highlight(0, ns_id, 'BrightLineNormal', current_line - 1, 0, -1)
            vim.api.nvim_set_hl(0, 'BrightLineNormal', { fg = brightened })
        end
        return
    end

    -- Get the syntax group name and create brightened version
    for _, syn_id in ipairs(synstack) do
        local name = vim.fn.synIDattr(syn_id, 'name')
        local hl = vim.api.nvim_get_hl(0, { name = name })
        if hl.fg then
            local brightened = adjust_brightness(hl.fg, 1.2)
            local bright_group = 'BrightLine' .. name
            vim.api.nvim_set_hl(0, bright_group, { fg = brightened })
            vim.api.nvim_buf_add_highlight(0, ns_id, bright_group, current_line - 1, 0, -1)
        end
    end
end

function M.setup()
    local group = vim.api.nvim_create_augroup('BrightLine', { clear = true })

    -- Highlight current line when cursor moves
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = group,
        callback = M.brighten_current_line,
    })

    -- Also highlight when entering a buffer
    vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
        group = group,
        callback = M.brighten_current_line,
    })
end

return M
