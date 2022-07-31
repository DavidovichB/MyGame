require_relative 'pick_stage'

require_relative 'skills'

require_relative 'heroes/Elementalist'

require_relative 'heroes/Morpheus'


class Hero

    attr_accessor :hp, :mp, :atk, :miss, :name, :physical_reduction, :magick_reduction, :spell_supress, :fire_res, :water_res, :earth_res, :wind_res, :poison_res, :dealed_damage, :sleeping

    def initialize(hp, mp, atk, miss, name, physical_reduction, magick_reduction, spell_supress, poison_res, wind_res, earth_res, water_res, fire_res, sleeping, dealed_damage)
        
        @hp = hp

        @mp = mp

        @atk = atk

        @miss = miss

        @name = name

        @physical_reduction = physical_reduction

        @magick_reduction = magick_reduction

        @spell_supress = spell_supress

        @fire_res = fire_res

        @water_res = water_res

        @earth_res = earth_res

        @wind_res = wind_res

        @poison_res = poison_res

        @dealed_damage = dealed_damage

        @sleeping = sleeping

    end
end


class Battle

    def initialize

        herostats = {'Morpheus'=>  
                {"name" => "Morpheus",
                "hp" => 450,
                "mp" => 240,
                "atk" => 35,
                "miss" => 7,
                "physical_reduction" => 0.97,
                "magick_reduction" => 0.90,
                "spell_supress" => 0,
                "fire_res" => 1.05,
                "water_res" => 1.02,
                "earth_res" => 1.03,
                "wind_res" => 1.0,
                "poison_res" => 1.05,
                "dealed_damage" => 0,
                "sleeping" => 0},

                'Elementalist'=>  
                {"name" => "Elementalist",
                "hp" => 600,
                "mp" => 170,
                "atk" => 50,
                "miss" => 5,
                "physical_reduction" => 0.95,
                "magick_reduction" => 0.90,
                "spell_supress" => 0,
                "fire_res" => 0.95,
                "water_res" => 0.95,
                "earth_res" => 0.95,
                "wind_res" => 0.95,
                "poison_res" => 1.05,
                "dealed_damage" => 0}}

        p1_pick = herostats[$p1_hero]

        p2_pick = herostats[$p2_hero]

        hero_assotiative_array = {
            'Elementalist' => Elementalist,
            'Morpheus' => Morpheus
        }

        @heroes = [hero_assotiative_array[$p1_hero].new(p1_pick['hp'],p1_pick['mp'],p1_pick['atk'],p1_pick['miss'],p1_pick['name'],p1_pick['physical_reduction'],p1_pick['magick_reduction'],p1_pick['spell_supress'],p1_pick['fire_res'],p1_pick['water_res'],p1_pick['earth_res'],p1_pick['wind_res'],p1_pick['poison_res'],p1_pick['dealed_damage'],p1_pick['sleeping'],$p1_hero), hero_assotiative_array[$p2_hero].new(p2_pick['hp'],p2_pick['mp'],p2_pick['atk'],p2_pick['miss'],p2_pick['name'],p2_pick['physical_reduction'],p2_pick['magick_reduction'],p2_pick['spell_supress'],p2_pick['fire_res'],p2_pick['water_res'],p2_pick['earth_res'],p2_pick['wind_res'],p2_pick['poison_res'], p2_pick['dealed_damage'],p2_pick['sleeping'], $p2_hero)]
        
        $round_count = 0

        @level_count_p1 = 0

        @skill_points_p1 = 0

        @gold_count_p1 = 0

        @level_count_p2 = 0

        @skill_points_p2 = 0

        @gold_count_p2 = 0

        @skills_p1 = Skills.new([0,0,0,0],$p1_hero)

        @skills_p2 = Skills.new([0,0,0,0],$p2_hero)

        $action_points = 0

    end

    def help 

        system 'clear'
        puts "\n\n\n                      Available commands                    "
        puts '--------------------------------------------------------------'
        puts '!book    !skip ' 

    end

    def battle_begins

        system 'clear'

        puts '                               Battle begins!'

        puts "\n\n\n#{$p1_hero}(p1) vs #{$p2_hero}(p2)"
        puts "\n\npress 'Enter' to continue."
        action = STDIN.gets.chomp
    end

    def action_after_round(first_elem_p1 = 0, cd_first_ele_p1 = 0, third_elem_p1 = 0, cd_third_ele_p1 = 0, fourth_elem_p1 = 0, cd_fourth_ele_p1 = 0,first_elem_p2 = 0, cd_first_ele_p2 = 0, third_elem_p2 = 0, cd_third_ele_p2 = 0, fourth_elem_p2 = 0, cd_fourth_ele_p2 = 0 )

        $action_points = 0

        $round_count = $round_count + 1

        @heroes[1].sp

        @heroes[0].sp

        @level_count_p1 = @level_count_p1 + 1

        @gold_count_p1 = @gold_count_p1 + 10

        @level_count_p2 = @level_count_p2 + 1

        @gold_count_p2 = @gold_count_p2 + 10
               
    end
    
    def battle_loop_p1

        while @heroes[0].hp > 0 && @heroes[1].hp > 0
        
            if $round_count == 0 

                $round_count = $round_count + 1
                @level_count_p1 = @level_count_p1 + 1
                @gold_count_p1 = @gold_count_p1 + 10
        
                @level_count_p2 = @level_count_p2 + 1
                @gold_count_p2 = @gold_count_p2 + 20

                @heroes[1].sp
                @heroes[0].sp

            end

            system 'clear'
        
            puts "                                 ROUND ##{$round_count} begins!"
        
            puts "#{$p1_hero} lvl #{@level_count_p1}."
                
            puts "#{$p1_hero} gold #{@gold_count_p1}."
        
            puts "\n HP===#{@heroes[0].hp}===HP"
        
            puts " MP===#{@heroes[0].mp}===MP"

            @heroes[0].passive_skills(@heroes[1], @level_count_p1, @gold_count_p1, 0, 0)

            if $action_points >= 1

                @heroes[1].round

                $action_points = 0

                battle_loop_p2

            end

            @heroes[0].action(@heroes[1], @level_count_p1, @gold_count_p1, 0, 0)
        
            action = STDIN.gets.chomp
        
            case action

            when ''

                @heroes[1].round

                battle_loop_p2

            when '1?'

                @heroes[0].first_info

            when '2?'

                @heroes[0].second_info

            when '3?'

                @heroes[0].third_info

            when '4?'

                @heroes[0].fourth_info

            when 's'

                @heroes[1].round

                battle_loop_p2

            when '0'

                @heroes[0].default_attack(@heroes[1], @level_count_p1,  @gold_count_p1, 0)

                if $action_points >= 1

                    @heroes[1].round

                    $action_points = 0

                    battle_loop_p2

                else

                    battle_loop_p1

                end

        
            when '1'
        
                @heroes[0].first_skill(@heroes[1], @level_count_p1,  @gold_count_p1)

                if $action_points >= 1

                    @heroes[1].round

                    $action_points = 0

                    battle_loop_p2

                else

                    battle_loop_p1

                end

        
            when '2'
        
                @heroes[0].second_skill(@heroes[1], @level_count_p1,  @gold_count_p1)
                            
                if $action_points >= 1

                    @heroes[1].round

                    $action_points = 0

                    battle_loop_p2

                else

                    battle_loop_p1

                end

        
            when '3'
        
                @heroes[0].third_skill(@heroes[1], @level_count_p1,  @gold_count_p1)

                if $action_points >= 1

                    @heroes[1].round

                    $action_points = 0

                    battle_loop_p2

                else

                    battle_loop_p1

                end

        
            when '4'

                @heroes[0].fourth_skill(@heroes[1], @level_count_p1,  @gold_count_p1)

                if $action_points >= 1

                    @heroes[1].round
                    
                    $action_points = 0

                    battle_loop_p2

                else

                    battle_loop_p1

                end
            end
        end
    end


    def battle_loop_p2

        while @heroes[0].hp > 0 && @heroes[1].hp > 0
            
            system 'clear'
        
            puts "                                 ROUND ##{$round_count}"
        
            puts "#{$p2_hero} lvl #{@level_count_p2}."
                
            puts "#{$p2_hero} gold #{@gold_count_p2}."
        
            puts "\n HP===#{@heroes[1].hp}===HP"
        
            puts " MP===#{@heroes[1].mp}===MP"

            @heroes[1].passive_skills(@heroes[0], @level_count_p2, @gold_count_p2, 0, 0)

            if $action_points >= 1

                $action_points = 0

                @heroes[0].round

                action_after_round

                battle_loop_p1
                
            end

            @heroes[1].action(@heroes[0], @level_count_p2, @gold_count_p2, 0, 0)

            action = STDIN.gets.chomp
        
            case action

                when ''

                    @heroes[0].round

                    action_after_round

                    battle_loop_p1

                when '1?'

                    @heroes[1].first_info

                when '2?'

                    @heroes[1].second_info

                when '3?'

                    @heroes[1].third_info

                when '4?'

                    @heroes[1].fourth_info

                when 's'

                    @heroes[0].round

                    action_after_round

                    battle_loop_p1

                when '0'

                    @heroes[1].default_attack(@heroes[0], @level_count_p2, @gold_count_p2)

                    if $action_points >= 1

                        $action_points = 0

                        @heroes[0].round

                        action_after_round

                        battle_loop_p1

                    else

                        battle_loop_p2

                    end

                when '1'
        
                    @heroes[1].first_skill(@heroes[0], @level_count_p2, @gold_count_p2)

                    if $action_points >= 1

                        $action_points = 0

                        @heroes[0].round

                        action_after_round

                        battle_loop_p1

                    else

                        battle_loop_p2

                    end
        
                when '2'
        
                    @heroes[1].second_skill(@heroes[0], @level_count_p2, @gold_count_p2)
                            
                    if $action_points >= 1

                        $action_points = 0

                        @heroes[0].round

                        action_after_round

                        battle_loop_p1

                    else

                        battle_loop_p2

                    end

                when '3'
        
                    @heroes[1].third_skill(@heroes[0], @level_count_p2, @gold_count_p2)

                    if $action_points >= 1

                        $action_points = 0

                        @heroes[0].round

                        action_after_round

                        battle_loop_p1

                    else

                        battle_loop_p2

                    end

                when '4'

                    @heroes[1].fourth_skill(@heroes[0], @level_count_p2, @gold_count_p1)

                    if $action_points >= 1

                        $action_points = 0

                        @heroes[0].round

                        action_after_round

                        battle_loop_p2

                    else

                        battle_loop_p1

                    end

                end

            end
            
        if @heroes[0].hp > @heroes[1].hp 

            puts "p1 (#{$p1_hero}) wins!"

               a = STDIN.gets.chomp

            abort

        elsif @heroes[0].hp == @heroes[1].hp || @heroes[0].hp < 0 && @heroes[1].hp < 0

            puts "draw"

            a = STDIN.gets.chomp

            abort

        else 

            puts "p2 (#{$p2_hero}) wins!"

            a = STDIN.gets.chomp

            abort

        end 

        battle_loop_p1 

    end
end