set number relativenumber
set guicursor=
set ls=2
set tabstop=4
set shiftwidth=4
set expandtab
set noerrorbells
set hidden
set noswapfile
set nobackup
set undodir=$HOME/.vim/undo
set undofile
set nowrap
set incsearch
set scrolloff=8
set smartindent
set nohlsearch
set noshowmode
set signcolumn=yes
set ignorecase
set smartcase
set filetype=on
set background=dark

colorscheme NeoSolarized
syntax enable

let mapleader = " "
let g:coq_settings = {'auto_start': 'shut-up'}
let g:airline#extensions#bufferline#enabled = 1
let g:airline_section_z = '%-c | %-p%%'
let g:airline#extensions#default#layout = [
            \ [ 'a', 'b', 'c' ],
            \ [ 'x', 'z', 'error', 'warning' ]
            \ ]


vnoremap <C-y> "+y
vnoremap <C-x> "+x
nnoremap <C-p> "+P
vnoremap <C-p> "+P
nnoremap <leader><Tab> <cmd>bnext<cr>
nnoremap <leader><S-Tab> <cmd>bprevious<cr>
nnoremap <leader>c <cmd>bd<cr>
nnoremap <leader><S-c> <cmd>bd!<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>gg <cmd>Telescope live_grep<cr>
nnoremap <leader>gD <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>gi <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <leader>D <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <leader>gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <C-t> <cmd>NERDTreeToggle<cr>
nnoremap <leader>nf <cmd>NERDTreeFind<cr>
nnoremap <leader>nn <cmd>NERDTree<cr>
nnoremap <leader>nc <cmd>NERDTreeClose<cr>

call plug#begin()
Plug 'bling/vim-bufferline'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'vim-airline/vim-airline'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
call plug#end()

lua << EOF
local lsp_installer = require("nvim-lsp-installer")

local function on_attach(client, bufnr)
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
  }
  server:setup(opts)
end)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = {
            'vim'
        }
    },
    indent = {
        enable = false,
        disable = {},
    },
}
EOF
