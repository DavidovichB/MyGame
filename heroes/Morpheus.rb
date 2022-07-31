
class Morpheus

    attr_accessor :hp, :mp, :atk, :miss, :name, :physical_reduction, :magick_reduction, :spell_supress, :fire_res, :water_res, :earth_res, :wind_res, :poison_res, :dealed_damage, :sleeping

    def initialize(hp, mp, atk, miss, name, physical_reduction, magick_reduction, spell_supress, poison_res, wind_res, earth_res, water_res, fire_res, dealed_damage, sleeping, hero_name)

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

        @hero_name = hero_name

        @dealed_damage = dealed_damage

        @sleeping = sleeping

        @skills_p1 = Skills.new([0,0,0,0],hero_name)

        @cd_1 = 0

        @cd_2 = 0

        @cd_3 = 0

        @cd_4 = 0

        @duration_1 = 0

        @duration_2 = 0

        @duration_3 = 0

        @duration_4 = 0

        @using_2 = 0

        @skill_points = 0

        @used_this_turn = 0

        @illusion_alive = false

        @died_recently = false

        @illusion_count = 0

        @cd_2 = 0

        @illusion_def_hp = 0

        @hp_tag = 0

        @hp_def = 0

        @hp_tag = @hp_tag + @hp

        @dealed_damage = []

        @used_1 = true

        @counter_1 = 0

        @sleeping = 0

        @skills_p1.abilities[1].illusion_hp = 0

    end

    def first_info

        puts "Active. Undirected. 

        Sprays Stupefying gas, which on 1/2/3/4 turns
        Increases the miss chance of enemy 
        characters. Negative effect 
        can be removed."

        a = nil

        while a != "c"

            puts "\n'c' to continue"

            a = STDIN.gets.chomp

        end

        $action_points = $action_points + 0

    end

    def second_info

        puts "Active. Undirected.

        Creates a copy of 
        itself, which has a health 10/20/30/40% of the 
        of the hero's health. Repeats all of his attacks 
        (not abilities) with the same damage. 
        Takes all attacks on Morpheus on himself. 
        Can be summoned only one copy at the same time. "
        
        a = nil

        while a != "c"

            puts "\n'c' to continue"

            a = STDIN.gets.chomp
            
        end

        $action_points = $action_points + 0

    end

    def third_info

        puts "Active. Directed. 

        Cast Sleep on a selected enemy character 
        For 1/1/2/2 turns. The effect on the last 
        level may not be removed. "
        
        a = nil

        while a != "c"

            puts "\n'c' to continue"

            a = STDIN.gets.chomp
            
        end

        $action_points = $action_points + 0

    end

    def fourth_info

        puts "Passive. 

        Every few turns the hero 
        Creates a protective dome above himself, which 
        Neutralizes any enemy damaging abilities 
        (directed and non-directed)."
        
        a = nil

        while a != "c"

            puts "\n'c' to continue"

            a = STDIN.gets.chomp
            
        end

        $action_points = $action_points + 0

    end

    def sp 

        @skill_points = @skill_points + 1

    end
    
    def round

        if @cd_1 > 0 

            @cd_1 = @cd_1 - 1

        end

        if @cd_3 > 0 

            @cd_3 = @cd_3 - 1

        end

        if @cd_4 > 0 

            @cd_4 = @cd_4 - 1

        end

        if @duration_1 > 0

            @duration_1 = @duration_1 - 1

        end

        if @duration_2 > 0

            @duration_2 = @duration_2 - 1

        end

        if @duration_3 > 0

            @duration_3 = @duration_3 - 1

        end

        if @duration_4 > 0

            @duration_4 = @duration_4 - 1

        end

        if @cd_2 == 0

            @died_recently == false

            @illusion_alive == false

            @illusion_count = @illusion_count * 0
            
        end

        if @died_recently == true && @cd_2 > 0

            @cd_2 = @cd_2 - 1

        end

    end

    def action(enemy, level, gold, cd_1 = 0, hit_count = 0, cd = 0)

        if  @skill_points > 0

            puts "\nyou have #{@skill_points} unused skill point(s) left!"

        end

        #buffs

        puts "\n\nchoose spell that you want to hit on (#{@cd_1.to_s + "*" if @cd_1 > 0 }#{"1" if @cd_1 <= 0},#{@cd_2.to_s + "*" if @cd_2 > 0}#{"alive" if @died_recently == false && @skills_p1.abilities[1].illusion_hp > 0}#{"2" if @cd_2 <= 0 && @skills_p1.abilities[1].illusion_hp == 0},#{@cd_3.to_s + "*" if @cd_3 > 0 }#{"3" if @cd_3 == 0},#{@cd_4.to_s + "*" if @cd_4 > 0 }#{"4-passive" if @cd_4 == 0} or default attack 0)\n's' or enter to skip turn"
        
        puts "\nput skill number + ? to open skill info"
        
        puts "\n-spell supress buff: #{@spell_supress}% chance #{@duration_2} more turns" if @duration_2 > 0
        
        puts "\n-evasion buff: #{@miss}% chance #{@duration_2} more turns" if @duration_2 > 0

        puts "\n-miss buff: #{@miss}% chance #{@duration_1} more turns" if @duration_1 > 0

        puts "\n-created illusion have #{@skills_p1.abilities[1].illusion_hp - enemy.dealed_damage.sum} hp" if @illusion_alive == true 

    end

    def passive_skills(enemy, level, gold, cd_1 = 0, elem_hit_count = 0, cd = 0)

        if enemy.sleeping > 0

            enemy.sleeping = enemy.sleeping - 1

            return $action_points = $action_points + 1

        end

        if @used_1 == true && @duration_1 == 0
        
            @miss = @miss - @skills_p1.abilities[0].miss

            @used_1 = false

            @counter_1 = @counter_1 * 0

        end


        if @skills_p1.abilities[1].illusion_hp <= enemy.dealed_damage.sum && @illusion_alive == true
            
            @illusion_alive = false
            
            @died_recently = true

            @skills_p1.abilities[1].illusion_hp = @skills_p1.abilities[1].illusion_hp * 0

            @cd_2 = @cd_2 + 3

            @hp_tag = @hp

            for damage in enemy.dealed_damage do

                enemy.dealed_damage.pop(10000)

            end

        end

        if @duration_4 == 0

            @spell_supress = @spell_supress * 0

        end

        if @cd_4 == 0 && @skills_p1.abilities[3].level > 0 && @skills_p1.abilities[3].mk <= @mp

            @cd_4 = @cd_4 + @skills_p1.abilities[3].cd

            @mp = @mp - @skills_p1.abilities[3].mk

            @spell_supress = @spell_supress + 100

            @duration_4 = @duration_4 + @skills_p1.abilities[3].buff_duration

            puts "Morpheus gain 100% spell supression buff on next #{@duration_4} turns!"

        end

    end

    ######################################################################

    def default_attack(enemy, level, gold, cd_1 = 0)

        num = rand(101)
        
        if num >= 1 && num <= enemy.miss
        
            puts 'miss!'
        
            turn = STDIN.gets.chomp
        
            $action_points = $action_points + 1
                            
        else
        
            enemy.hp = enemy.hp - (@atk * enemy.physical_reduction)

            @dealed_damage << @atk * enemy.physical_reduction

            if @illusion_alive == true

                if num >= 1 && num <= enemy.miss
        
                    puts 'illusion miss!'

                    $action_points = $action_points + 1

                else

                    enemy.hp = enemy.hp - (@atk * enemy.physical_reduction)

                    @dealed_damage << @atk * enemy.physical_reduction

                    puts "illusion helps Morpheus, dealing #{@atk * enemy.physical_reduction} damage"

                end
            end
        
            puts "\nMorpheus deals #{@atk * enemy.physical_reduction} damage to #{enemy.name}!"
        
            puts "\n#{enemy.name} HP #{enemy.hp} left!"

            puts "#{enemy.name} MP #{enemy.mp} left!"
        
            puts "\n\npress 'Enter' to change the turn."

            turn = STDIN.gets.chomp
        
            if turn == ''

                $action_points = $action_points + 1

            end
        end

    end

    def first_skill(enemy, level, gold)

        puts "\nYou want to hit with this spell?(level #{@skills_p1.abilities[0].level}) (y/n).\n"

        action = STDIN.gets.chomp
        
        if action == 'y' && @skills_p1.abilities[0].level > 0
        
            #первый morpha
            if @cd_1 > 0
        
                puts "this spell is on cooldown #{@cd_1} more turns!"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            elsif @mp < @skills_p1.abilities[0].mk
        
                puts "not enough mana!(need #{@skills_p1.abilities[0].mk - @mp} more!)"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            else       

                @mp = @mp - @skills_p1.abilities[0].mk
        
                puts "Morpheus spreading gypnotic gas."

                chance_to_debuff = 0

                chance_to_debuff = rand(101)
    
                if chance_to_debuff >= 1 && chance_to_debuff <= @skills_p1.abilities[0].chance
    
                    @miss = @miss + @skills_p1.abilities[0].miss
    
                    puts "#{@hero_name} debuffed #{enemy.name} on next #{@skills_p1.abilities[0].debuff_duration} turns!"

                    @used_1 = true
    
                end 

                @duration_1 = @duration_1 + @skills_p1.abilities[0].buff_duration
        
                @cd_1 = @cd_1 + @skills_p1.abilities[0].cd + 1

                action = STDIN.gets.chomp

                $action_points = $action_points + 1   
                     
            end
        
        elsif @skill_points > 0 && @skills_p1.abilities[0].level < 4
        
            puts "\nAre you sure you want to learn this spell? (y/n)."
                        
            action = STDIN.gets.chomp
                            
            case action

            when 'y'
            
                @skill_points = @skill_points - 1

                @skills_p1.lvl_up(0)
            
                puts "current skill level: #{@skills_p1.abilities[0].level}"
                                    
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
            
            when 'n'

                return $action_points = $action_points + 0

            end
        
        else
        
            puts "you don't have enough passive points to learn this ability!"
        
            action = STDIN.gets.chomp

            return $action_points = $action_points + 0
        
        end
    end


    def second_skill(enemy, level, gold)

        puts "\nYou want to use this spell?(level #{@skills_p1.abilities[1].level}) (y/n).\n"

        action = STDIN.gets.chomp
        
        if action == 'y'
        
            if @cd_2 > 0
        
                puts "this spell is on cooldown #{@cd_2} more turns!"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            elsif @mp < @skills_p1.abilities[1].mk
        
                puts "passive: not enough mana!(need #{@skills_p1.abilities[1].mk - @mp} more!)"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0

            elsif @skills_p1.abilities[1].level < 1

                puts "you haven't learned this skill yet"

                action = STDIN.gets.chomp
    
                return $action_points = $action_points + 0

            else

                if @illusion_count == 0 && @illusion_alive == false

                    @mp = @mp - @skills_p1.abilities[1].mk

                    puts "\nMorpheus have summoned his guard-illusion!"

                    for damage in enemy.dealed_damage do

                        enemy.dealed_damage.pop(10000)
        
                    end

                    @illusion_alive = true

                    @illusion_count = @illusion_count + 1

                    if @skills_p1.abilities[1].level == 1

                        @skills_p1.abilities[1].illusion_hp = @skills_p1.abilities[1].illusion_hp + ((@hp.to_i * 10) / 100)
        
                        @skills_p1.abilities[1].illusion_atk = @skills_p1.abilities[1].illusion_atk + @atk

                        @hp_tag = @hp
   
                    end
        
                    if @skills_p1.abilities[1].level == 2
        
                        @skills_p1.abilities[1].illusion_hp = @skills_p1.abilities[1].illusion_hp + ((@hp.to_i * 20) / 100)
        
                        @skills_p1.abilities[1].illusion_atk = @skills_p1.abilities[1].illusion_atk + @atk
        
                        @hp_tag = @hp

                    end
        
                    if @skills_p1.abilities[1].level == 3
        
                        @skills_p1.abilities[1].illusion_hp = @skills_p1.abilities[1].illusion_hp + ((@hp.to_i * 30) / 100)
        
                        @skills_p1.abilities[1].illusion_atk = @skills_p1.abilities[1].illusion_atk + @atk

                        @hp_tag = @hp
        
                    end
        
                    if @skills_p1.abilities[1].level == 4
        
                        @skills_p1.abilities[1].illusion_hp = @skills_p1.abilities[1].illusion_hp + ((@hp.to_i * 40) / 100)
        
                        @skills_p1.abilities[1].illusion_atk = @skills_p1.abilities[1].illusion_atk + @atk2

                        @hp_tag = @hp
        
                    end

                    @illusion_def_hp = @skills_p1.abilities[1].illusion_hp

                    @hp = @hp + @skills_p1.abilities[1].illusion_hp

                    puts "created illusion have #{@skills_p1.abilities[1].illusion_hp} hp"

                    action = STDIN.gets.chomp
    
                    return $action_points = $action_points + 1

                end

                action = STDIN.gets.chomp
    
                return $action_points = $action_points + 1
                
            end
        
        elsif @skill_points > 0 && @skills_p1.abilities[1].level < 4
        
            puts "\nAre you sure you want to learn this spell? (y/n)."
                        
            action = STDIN.gets.chomp
                            
            case action

            when 'y'
            
                @skill_points = @skill_points - 1

                @skills_p1.lvl_up(1)
            
                puts "current skill level: #{@skills_p1.abilities[1].level}"
                                    
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
            
            when 'n'

                return $action_points = $action_points + 0

            end
        
        else @skill_points <= 0
        
            puts "you don't have enough passive points to learn this ability!"
        
            action = STDIN.gets.chomp

            return $action_points = $action_points + 0

        end
    end

    def third_skill(enemy, level, gold)

        puts "\nYou want to use this spell?(level #{@skills_p1.abilities[2].level}) (y/n).\n"

        action = STDIN.gets.chomp
        
        if action == 'y'
        
            if @cd_3 > 0
        
                puts "this spell is on cooldown #{@cd_3} more turns!"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            elsif @mp < 0
        
                puts "not enough mana!(need #{@skills_p1.abilities[2].mk - @mp} more!)"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0

            elsif @skills_p1.abilities[2].level < 1

                puts "you haven't learned this skill yet"

                action = STDIN.gets.chomp
    
                return $action_points = $action_points + 0

            else

                @mp = @mp - @skills_p1.abilities[2].mk

                @duration_3 = @duration_3 + @skills_p1.abilities[2].debuff_duration

                @cd_3 = @cd_3 + @skills_p1.abilities[2].cd + @duration_3

                puts "Morpheus opiate #{enemy.name} on next #{@duration_3} turns!"

                @sleeping = @sleeping + @duration_3

                action = STDIN.gets.chomp

                return $action_points = $action_points + 1

            end
        
        elsif @skill_points > 0 && @skills_p1.abilities[2].level < 4
        
            puts "\nAre you sure you want to learn this spell? (y/n)."
                        
            action = STDIN.gets.chomp
                            
            case action

            when 'y'
            
                @skill_points = @skill_points - 1

                @skills_p1.lvl_up(2)
            
                puts "current skill level: #{@skills_p1.abilities[2].level}"
                                    
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
            
            when 'n'

                return $action_points = $action_points + 0

            end
        
        else @skill_points <= 0
        
            puts "you don't have enough passive points to learn this ability!"
        
            action = STDIN.gets.chomp

            return $action_points = $action_points + 0

        end

    end

    def fourth_skill(enemy, level, gold)

        puts "\nYou want to hit with this spell?(level #{@skills_p1.abilities[3].level}) (y/n).\n"

        action = STDIN.gets.chomp
        
        if action == 'y'
        
            if @cd_4 > 0
        
                puts "this spell is on cooldown #{@cd_4} more turns!"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            elsif @mp < @skills_p1.abilities[3].mk
        
                puts "passive: not enough mana!(need #{@skills_p1.abilities[3].mk - @mp} more!)"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            elsif @skills_p1.abilities[3].level >= 1

                puts "this passive skill is already using if you have enought mana"

                action = STDIN.gets.chomp
    
                return $action_points = $action_points + 0

            elsif @skills_p1.abilities[3].level < 1

                puts "you haven't learned this skill yet"

                action = STDIN.gets.chomp
    
                return $action_points = $action_points + 0
                
            end
        
        elsif @skill_points > 0 && @skills_p1.abilities[3].level < 4
        
            puts "\nAre you sure you want to learn this spell? (y/n)."
                        
            action = STDIN.gets.chomp
                            
            case action

            when 'y'
            
                @skill_points = @skill_points - 1

                @skills_p1.lvl_up(3)
            
                puts "current skill level: #{@skills_p1.abilities[3].level}"
                                    
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
            
            when 'n'

                return $action_points = $action_points + 0

            end
        
        else @skill_points <= 0
        
            puts "you don't have enough passive points to learn this ability!"
        
            action = STDIN.gets.chomp

            return $action_points = $action_points + 0

        end
    end
end