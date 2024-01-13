return {
	-- quick commentary
	{ "tpope/vim-commentary" },
	{ "lambdalisue/suda.vim" },
	-- {'google/vim-glaive', dependencies = {'google/vim-maktaba' }},
	---- motions to surround text with other text
	{
		--- surr*ound_words             ysiw)           (surround_words)
		-- *make strings               ys$"            "make strings"
		-- [delete ar*ound me!]        ds]             delete around me!
		-- remove <b>HTML t*ags</b>    dst             remove HTML tags
		-- 'change quot*es'            cs'"            "change quotes"
		-- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
		-- delete(functi*on calls)     dsf             function calls
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	-- automatically insert/delete parenthesis, brackets, quotes
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
}
