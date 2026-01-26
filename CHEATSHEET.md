# Neovim Configuration Cheat Sheet

## Leader Key
The leader key is set to `;` (semicolon).

## Core Mappings

### Clipboard Operations
| Shortcut | Description | Mode | Type |
|----------|-------------|------|------|
| `<Leader>y` | Copy to system clipboard | Normal, Visual | Custom |
| `<Leader>p` | Paste from system clipboard | Normal, Visual | Custom |
| `<Leader>Y` | Copy to `~/.vim_clipboard` file | Normal, Visual | Custom |
| `<Leader>P` | Paste from `~/.vim_clipboard` file | Normal, Visual | Custom |
| `<Leader>d` | Delete to non-default register | Normal | Custom |

*Config file: `lua/keymap.lua`*

### Window Navigation
| Shortcut | Description | Type |
|----------|-------------|------|
| `<A-j>` | Move to window below | Custom |
| `<A-k>` | Move to window above | Custom |
| `<A-h>` | Move to window left | Custom |
| `<A-l>` | Move to window right | Custom |

*Config file: `lua/keymap.lua`*

### Other Core Mappings
| Shortcut | Description | Type |
|----------|-------------|------|
| `<F1>` | Disabled (no operation) | Custom |
| `*` | Highlight word under cursor (keeps cursor position) | Custom |

*Config file: `lua/keymap.lua`*

## Plugin Mappings

### LSP (Language Server Protocol)
| Shortcut | Description | Type |
|----------|-------------|------|
| `<space>e` | Open diagnostic float | Default |
| `[d` | Go to previous diagnostic | Default |
| `]d` | Go to next diagnostic | Default |
| `<space>q` | Set loclist | Default |
| `gD` | Go to declaration | Default |
| `gd` | Go to definition | Default |
| `K` | Show hover (with border) | Custom |
| `gi` | Go to implementation | Default |
| `<C-k>` | Show signature help | Default |
| `<space>wa` | Add workspace folder | Default |
| `<space>wr` | Remove workspace folder | Default |
| `<space>wl` | List workspace folders | Default |
| `<space>D` | Go to type definition | Default |
| `<space>rn` | Rename | Default |
| `<space>ca` | Code action | Default |
| `gr` | References | Default |
| `<space>f` | Format buffer (async) | Default |

*Config file: `lua/plugins/lsp.lua`*

### Telescope (Fuzzy Finder)
| Shortcut | Description | Type |
|----------|-------------|------|
| `<Leader>ff` | Find files | Custom |
| `<Leader>fq` | Quickfix | Custom |
| `<Leader>fg` | Live grep | Custom |
| `<Leader>fr` | Old files | Custom |
| `<Leader>fb` | Buffers | Custom |
| `<Leader>fh` | Help tags | Custom |
| `<Leader>fd` | Diagnostics | Custom |
| `<Leader>fm` | Bookmarks | Custom |
| `<Leader>ft` | Tags | Custom |
| `<c-f>` | Find files (alternative) | Custom |
| `<Leader>a` | Ack search | Custom |
| `<C-i>` | Show which-key mappings in insert mode | Default |

*Config file: `lua/plugins/navigator.lua`*

### Buffer Management
| Shortcut | Description | Type |
|----------|-------------|------|
| `<leader>bp` | Toggle pin | Custom |
| `<leader>bP` | Delete non-pinned buffers | Custom |
| `<M-,>` | Move to previous buffer | Custom |
| `<M-.>` | Move to buffer | Custom |
| `<Tab><Tab>` | Move to next buffer | Custom |
| `<Leader>[` | Move to previous buffer | Custom |
| `<Leader>]` | Move to next buffer | Custom |
| `<Leader>c` | Close buffer (pick) | Custom |
| `<Leader>1` to `<Leader>9` | Go to buffer 1-9 | Custom |

*Config file: `lua/plugins/ui.lua`*

### Buffer Removal
| Shortcut | Description | Type |
|----------|-------------|------|
| `<leader>bd` | Delete buffer | Custom |
| `<leader>bD` | Delete buffer (force) | Custom |

*Config file: `lua/plugins/action.lua`*

### File Explorer (NeoTree)
| Shortcut | Description | Type |
|----------|-------------|------|
| `<leader>ef` | Toggle NeoTree (root dir) | Custom |
| `<leader>eb` | Explorer buffers | Custom |
| `<leader>eg` | Git status | Custom |
| `<leader>ed` | Document symbols | Custom |

*Config file: `lua/plugins/layout.lua`*

### Bookmarks
| Shortcut | Description | Type |
|----------|-------------|------|
| `<Leader><tab>` | Toggle bookmarks | Default |
| `<Leader>z` | Add bookmark | Default |
| `\g` | Add global bookmark | Default |
| `<CR>` | Jump to bookmark | Default |
| `dd` | Delete bookmark | Default |
| `<space><space>` | Order bookmarks | Default |
| `\dd` | Delete bookmark at virt text line | Default |
| `<Leader>sd` | Show bookmark description | Default |
| `<c-j>` | Focus tags window | Default |
| `<c-k>` | Focus bookmarks window | Default |
| `<S-Tab>` | Toggle window focus | Default |

*Config file: `lua/plugins/navigator.lua`*

### Formatting
| Shortcut | Description | Type |
|----------|-------------|------|
| `<Leader>F` | Format write | Custom |
| `:F` | Format write (command) | Custom |

*Config file: `lua/plugins/formatter.lua`*

### Trouble Plugin
| Shortcut | Description | Type |
|----------|-------------|------|
| `<F9>` | Toggle trouble diagnostics | Custom |

*Config file: `lua/plugins/layout.lua`*

### Comment.nvim
| Shortcut | Description | Type |
|----------|-------------|------|
| `gcc` | Toggle line comment | Default |
| `gbc` | Toggle block comment | Default |
| `gc` | Line comment operator | Default |
| `gb` | Block comment operator | Default |
| `gcO` | Add comment above | Default |
| `gco` | Add comment below | Default |
| `gcA` | Add comment at end of line | Default |

*Config file: `lua/plugins/editor.lua`*

### OSCYank (System Clipboard)
| Shortcut | Description | Mode | Type |
|----------|-------------|------|------|
| `<leader>c` | OSCYank operator | Normal | Custom |
| `<leader>cc` | OSCYank current line | Normal | Custom |
| `<leader>c` | OSCYank visual selection | Visual | Custom |

*Config file: `lua/plugins/utilities.lua`*

### Noice.nvim (Notifications)
| Shortcut | Description | Type |
|----------|-------------|------|
| `<Esc>` | Dismiss noice notification | Custom |

*Config file: `lua/plugins/message.lua`*

### Vimwiki
| Shortcut | Description | Type |
|----------|-------------|------|
| `<leader>ww` | Open vimwiki index | Default |
| `<leader>wt` | Open vimwiki index in new tab | Default |

*Config file: `lua/plugins/vimwiki.lua`*

### AI Helper
| Shortcut | Description | Mode | Type |
|----------|-------------|------|------|
| `<leader>ai` | AI prompt | Visual | Custom |

*Config file: `lua/plugins/ai-helper.lua`*

### Auto-completion (nvim-cmp)
| Shortcut | Description | Type |
|----------|-------------|------|
| `<C-p>` | Select previous item | Default |
| `<C-n>` | Select next item | Default |
| `<C-b>` | Scroll docs up | Default |
| `<C-f>` | Scroll docs down | Default |
| `<C-Space>` | Trigger completion | Default |
| `<C-e>` | Abort/close completion | Default |
| `<C-g>` | Accept copilot suggestion | Default |
| `<CR>` | Confirm selection | Default |

*Config file: `lua/plugins/nvim-cmp.lua`*

### Blink.cmp (Additional Completion)
| Shortcut | Description | Type |
|----------|-------------|------|
| `<Tab>` | Disabled (to avoid conflict) | Default |
| `<C-]>` | Accept | Default |
| `<C-y>` | Select and accept | Default |
| `<C-e>` | Hide | Default |
| `<C-w>` | Show | Default |
| `<Up>` | Select previous (with fallback) | Default |
| `<Down>` | Select next (with fallback) | Default |
| `<C-p>` | Select previous (with fallback) | Default |
| `<C-n>` | Select next (with fallback to mappings) | Default |
| `<C-a>` | Show only copilot suggestions | Default |
| `<C-s>` | Show only snippet suggestions | Default |

*Config file: `lua/plugins/blink.cmp.lua`*

### Snippets (LuaSnip)
| Shortcut | Description | Mode | Type |
|----------|-------------|------|------|
| `<Tab>` | Expand or jump forward | Insert | Default |
| `<S-Tab>` | Jump backward | Insert | Default |
| `<Tab>` | Jump forward | Snippet | Default |
| `<S-Tab>` | Jump backward | Snippet | Default |
| `<C-E>` | Next choice in choice nodes | Insert/Snippet | Default |

*Config file: `lua/plugins/snips.lua`*

### Copilot
| Shortcut | Description | Type |
|----------|-------------|------|
| `[[` | Jump to previous suggestion | Default |
| `]]` | Jump to next suggestion | Default |
| `<CR>` | Accept suggestion | Default |
| `gr` | Refresh suggestions | Default |
| `<M-CR>` | Open panel | Default |
| `<C-o>` | Accept suggestion (alternative) | Default |
| `<C-j>` | Next suggestion | Default |
| `<C-.>` | Previous suggestion | Default |

*Config file: `lua/plugins/copilot.lua`*

### Illuminate (Reference Highlighting)
| Shortcut | Description | Type |
|----------|-------------|------|
| `]]` | Next reference | Custom |
| `[[` | Previous reference | Custom |

*Config file: `lua/plugins/theme.lua`*

### Legacy Plugin (Conflict Resolution)
| Shortcut | Description | Type |
|----------|-------------|------|
| `co` | Accept ours | Default |
| `ct` | Accept theirs | Default |
| `ca` | Accept all theirs | Default |
| `cb` | Accept both | Default |
| `cc` | Accept at cursor | Default |
| `]x` | Next conflict | Default |
| `[x` | Previous conflict | Default |
| `<M-l>` | Accept suggestion | Default |
| `<M-]>` | Next suggestion | Default |
| `<M-[>` | Previous suggestion | Default |
| `<C-]>` | Dismiss suggestion | Default |
| `]]` | Next jump | Default |
| `[[` | Previous jump | Default |
| `<CR>` | Submit (normal mode) | Default |
| `<C-s>` | Submit (insert mode) | Default |
| `A` | Apply all (sidebar) | Default |
| `a` | Apply at cursor (sidebar) | Default |
| `<Tab>` | Switch windows (sidebar) | Default |
| `<S-Tab>` | Reverse switch windows (sidebar) | Default |

*Config file: `lua/plugins/legacy.lua`*

### Surround (nvim-surround)
| Shortcut | Description | Type |
|----------|-------------|------|
| `ys` | Add surround (operator) | Default |
| `ds` | Delete surround | Default |
| `cs` | Change surround | Default |
| `yss` | Surround entire line | Default |
| `yS` | Surround with newline (operator) | Default |
| `S` | Surround visual selection | Default |

*Config file: `lua/plugins/editor.lua`*

### Git (gitsigns.nvim)
| Shortcut | Description | Type |
|----------|-------------|------|
| `]c` | Next hunk | Default |
| `[c` | Previous hunk | Default |
| `<leader>hs` | Stage hunk | Default |
| `<leader>hr` | Reset hunk | Default |
| `<leader>hS` | Stage buffer | Default |
| `<leader>hu` | Undo stage hunk | Default |
| `<leader>hR` | Reset buffer | Default |
| `ih` | Inner hunk (text object) | Default |
| `<leader>hb` | Blame line | Default |
| `<leader>hB` | Blame line full | Default |

*Config file: `lua/plugins/init.lua`*

### Git (vim-fugitive)
| Command | Description |
|---------|-------------|
| `:G` | Fugitive status |
| `:Git` | Run any git command |
| `:Gstatus` | Show git status |
| `:Gdiff` | Show diff |
| `:Gblame` | Show blame |

*Config file: `lua/plugins/init.lua`*

### Documentation (DoxygenToolkit.vim)
| Command | Description |
|---------|-------------|
| `:Dox` | Generate Doxygen comment |
| `:DoxAuthor` | Insert author comment |
| `:DoxLic` | Insert license comment |

*Config file: `lua/plugins/init.lua`*

### Markdown Preview
| Command | Description |
|---------|-------------|
| `:MarkdownPreviewToggle` | Toggle markdown preview |
| `:MarkdownPreview` | Start markdown preview |
| `:MarkdownPreviewStop` | Stop markdown preview |

*Config file: `lua/plugins/init.lua`*

### Sudo Write (suda.vim)
| Command | Description |
|---------|-------------|
| `:SudaWrite` | Write file with sudo privileges |

*Config file: `lua/plugins/editor.lua`*

### ANSI Escape (AnsiEsc)
| Command | Description |
|---------|-------------|
| `:AnsiEsc` | Toggle ANSI escape sequence highlighting |

*Config file: `lua/plugins/editor.lua`*

### Better Escape
| Behavior | Description |
|----------|-------------|
| `jj` | Escape insert mode (default) |
| `<Tab>` | Trigger luasnip expansion (custom) |
| `jk` | Disabled in visual mode (custom) |

*Config file: `lua/plugins/init.lua`*

## Basic Vim Text Operations
| Shortcut | Description |
|----------|-------------|
| `cf<symbol>` | Delete until next symbol (include symbol) |
| `ct<symbol>` | Delete until next symbol (not include symbol) |
| `ciw` | Delete current word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `ci{` | Change inside braces |
| `ci[` | Change inside brackets |

## Custom Functions
| Shortcut | Description |
|----------|-------------|
| `<c-h>` | Show custom text (demo function) |

*Config file: `lua/init.lua`*

## Dashboard Actions (Startup Screen)
| Shortcut | Action |
|----------|--------|
| `u` | Lazy update |
| `f` | Telescope find files |
| `a` | Telescope oldfiles |

*Config file: `lua/plugins/startup.lua`*

## File Locations
- Core mappings: `lua/keymap.lua`
- Leader key: `lua/setup.lua`
- Plugin mappings: `lua/plugins/` directory
- Initialization: `lua/init.lua`
- Legacy Vim config: `init.vim`

## Type Legend
- **Custom**: User-defined mapping, not part of plugin defaults
- **Default**: Plugin default mapping (may be configured but not customized)

## Notes
- Most mappings use modern Neovim Lua API (`vim.keymap.set`).
- Descriptions are included for better documentation.
- Configuration is modularized in separate files.
- Default mappings are those provided by plugins without significant customization.

## Quick Reference
- Leader: `;`
- Window navigation: Alt + hjkl
- Buffer navigation: `<Leader>[` / `]`, `<Tab><Tab>`, `<M-,>` / `<M-.>`
- File finder: `<Leader>ff`
- LSP: `<space>` + various keys
- Format: `<Leader>F`
- Comment: `gcc`, `gbc`, `gc`, `gb`
- Bookmarks: `<Leader><tab>`

---

*Generated from neovim configuration.*