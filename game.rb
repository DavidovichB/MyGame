require_relative 'pick_stage'
require_relative 'battle_stage'


pick = Pick.new()

pick.say_hi
pick.game_rules
pick.heroes_list
pick.p1_select
pick.p2_select

battle = Battle.new()
battle.help
battle.battle_begins
battle.battle_loop_p1

