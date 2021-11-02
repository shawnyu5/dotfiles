-- local Rule = require('nvim-autopairs.rule')
-- local npairs = require('nvim-autopairs')

require('nvim-autopairs').setup{
  enable_check_bracket_line = false
}

-- require('nvim-autopairs').clear_rules() -- clear all rule
-- require('nvim-autopairs').get_rule('{') -- get rule " then modify it
require('nvim-autopairs').remove_rule('(') -- remove rule (
require('nvim-autopairs').remove_rule("'") -- remove rule '
require('nvim-autopairs').remove_rule('"') -- remove rule "
require('nvim-autopairs').remove_rule('`') -- remove rule `
require('nvim-autopairs').remove_rule('[') -- remove rule [

