-- local Rule = require('nvim-autopairs.rule')
-- local npairs = require('nvim-autopairs')

require('nvim-autopairs').setup{
  enable_check_bracket_line = false
}

require('nvim-autopairs').remove_rule('(') -- remove rule (
require('nvim-autopairs').remove_rule("'") -- remove rule '
require('nvim-autopairs').remove_rule('"') -- remove rule "
require('nvim-autopairs').remove_rule('`') -- remove rule `

