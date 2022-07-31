
class Elementalist

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

        @elem_hit_count = 0

        @using_2 = 0

        @skill_points = 0

        @used_this_turn = 0

        @dealed_damage = []

        @sleeping = 0

    end

    def first_info

        puts "Active. switchable. all elements. directed. 

        Increases the strength of the next attack 
        random elemental, dealing basic damage and 
        +10/20/30/40 additional elemental damage 
        on target"

        a = nil

        while a != "c"

            puts "\n'c' to continue"

            a = STDIN.gets.chomp

        end

        $action_points = $action_points + 0

    end

    def second_info

        puts "Passive. Air. undirected.

        The hero envelops himself with the force of the wind element and 
        With a chance to repel a directed attack on his next turn
        or ability"
        
        a = nil

        while a != "c"

            puts "\n'c' to continue"

            a = STDIN.gets.chomp
            
        end

        $action_points = $action_points + 0

    end

    def third_info

        puts "Active. non-directed.

        The character sets fire to his mp, removing half and 
        has a chance to gain +25/30/35/40 mp
        for each of the next 4 turns"
        
        a = nil

        while a != "c"

            puts "\n'c' to continue"

            a = STDIN.gets.chomp
            
        end

        $action_points = $action_points + 0

    end

    def fourth_info

        puts "Active. All Elements. Directed.

        Deals damage equal to the damage he dealt to enemies during the previous turns
        Can't be used at the turn you learned it"
        
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

        if @cd_2 > 0 

            @cd_2 = @cd_2 - 1

        end

        if @cd_3 > 0 

            @cd_3 = @cd_3 - 1

        end

        if @cd_4 > 0 

            @cd_4 = @cd_4 - 1

        end

        if @duration_2 > 0

            @duration_2 = @duration_2 - 1

        end

        if @duration_2 == 0

            @spell_supress = @spell_supress * 0 

            @miss = @miss * 0 

        end

        if @duration_3 > 0

            puts "\nElementalist returns burned mana!"

            puts "+ #{@skills_p1.abilities[2].mana_gain}mp"
    
            @mp = @mp + @skills_p1.abilities[2].mana_gain

            @duration_3 = @duration_3 - 1
        end

    end

    def action(enemy, level, gold, cd_1 = 0, elem_hit_count = 0, cd = 0)



        if  @skill_points > 0

            puts "\nyou have #{@skill_points} unused skill point(s) left!"

        end

        #buffs

        puts "\n\nchoose spell that you want to hit on (#{@cd_1.to_s + "*" if @cd_1 > 0 }#{"1" if @cd_1 <= 0},#{@cd_2.to_s + "*" if @cd_2 > 0 }#{"2-passive" if @cd_2 <= 0},#{@cd_3.to_s + "*" if @cd_3 > 0 }#{"3" if @cd_3 == 0},#{@cd_4.to_s + "*" if @cd_4 > 0 }#{"4" if @cd_4 == 0} or default attack 0)\n's' or enter to skip turn"
        
        puts "\nput skill number + ? to open skill info"
        
        puts "\n-spell supress buff: #{@spell_supress}% chance #{@duration_2} more turns" if @duration_2 > 0
        
        puts "\n-evasion buff: #{@miss}% chance #{@duration_2} more turns" if @duration_2 > 0
        
        puts "\n-mana gain buff: +#{@skills_p1.abilities[2].mana_gain} mana #{@duration_3} more turns" if @duration_3 > 0

        ########################################

        #debuffs

        puts "\n-hit chance debuff" if enemy.miss >= 8

    end

    def passive_skills(enemy, level, gold, cd_1 = 0, elem_hit_count = 0, cd = 0)

        if enemy.sleeping > 0

            enemy.sleeping = enemy.sleeping - 1

            return $action_points = $action_points + 1

        end

        if @cd_2 == 0 && @skills_p1.abilities[1].level > 0 && @skills_p1.abilities[1].mk <= @mp
        
            chance_to_activate_2 = 0

            chance_to_activate_2 = rand(101)

            if chance_to_activate_2 >= 1 && chance_to_activate_2 <= @skills_p1.abilities[1].chance

                @mp = @mp - @skills_p1.abilities[1].mk

                @spell_supress = @spell_supress + @skills_p1.abilities[1].spell_supression

                @miss = @miss + @skills_p1.abilities[1].miss

                @cd_2 = @cd_2 + @skills_p1.abilities[1].cd

                @duration_2 = @duration_2 + @skills_p1.abilities[1].buff_duration

                puts "Elementalist gain buff #{@skills_p1.abilities[1].spell_supression}% spell supression on next #{@skills_p1.abilities[1].buff_duration} turn!"

                return $action_points = $action_points + 0
                    
            else

                puts "Elementalist unsuccessfully trying to get buff"

                @cd_2 = (@cd_2 * 0) + @cd_2 + @skills_p1.abilities[1].cd

                return $action_points = $action_points + 0

            end 
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
        
            enemy.hp = enemy.hp - (atk * enemy.magick_reduction)

            @elem_hit_count = @elem_hit_count + (atk * enemy.magick_reduction)

            @dealed_damage << @atk * enemy.magick_reduction
        
            puts "\nElementalist deals #{atk * enemy.magick_reduction} damage to #{enemy.name}!"
        
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
        
            #первый элемa
            if @cd_1 > 0
        
                puts "this spell is on cooldown #{@cd_1} more turns!"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            elsif @mp < @skills_p1.abilities[0].mk
        
                puts "not enough mana!(need #{@skills_p1.abilities[0].mk - @mp} more!)"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            else
        
                random_element = 0

                random_element = rand(5)

                supress_chance = 0

                supress_chance = rand(101)  

                if supress_chance <= enemy.spell_supress && supress_chance >= 1

                    puts "enemy supressed damage!"

                    @cd_1 = @cd_1 + @skills_p1.abilities[0].cd 

                    action = STDIN.gets.chomp

                    $action_points = $action_points + 1   

                else         
        
                    if random_element == 1
                                        
                        @mp = @mp - @skills_p1.abilities[0].mk

                        enemy.hp = enemy.hp - (enemy.fire_res * (@skills_p1.abilities[0].dmg + @atk))
    
                        puts "Elementalist gain buff +#{@skills_p1.abilities[0].dmg} damage!"

                        puts "Elementalist deals #{enemy.fire_res * (@skills_p1.abilities[0].dmg + @atk)} fire damage to #{enemy.name}!"
    
                        @elem_hit_count = @elem_hit_count + (enemy.fire_res*(@skills_p1.abilities[0].dmg + @atk))

                        @dealed_damage << enemy.hp - (enemy.fire_res*(@skills_p1.abilities[0].dmg + @atk))
                        
                    end
            
                    if random_element == 2
                                            
                        @mp = @mp - @skills_p1.abilities[0].mk

                        enemy.hp = enemy.hp - (enemy.water_res*(@skills_p1.abilities[0].dmg + @atk))
    
                        puts "Elementalist gain buff +#{@skills_p1.abilities[0].dmg} damage!"

                        puts "Elementalist deals #{enemy.water_res*(@skills_p1.abilities[0].dmg + @atk)} water damage to #{enemy.name}!"
            
                        @elem_hit_count = @elem_hit_count + (enemy.water_res*(@skills_p1.abilities[0].dmg + @atk))

                        @dealed_damage << enemy.hp - (enemy.water_res*(@skills_p1.abilities[0].dmg + @atk))
            
                    end
            
                    if random_element == 3
                                            
                        @mp = @mp - @skills_p1.abilities[0].mk

                        enemy.hp = enemy.hp - (enemy.earth_res*(@skills_p1.abilities[0].dmg + @atk))
    
                        puts "Elementalist gain buff +#{@skills_p1.abilities[0].dmg} damage!"

                        puts "Elementalist deals #{enemy.earth_res*(@skills_p1.abilities[0].dmg + @atk)} earth damage to #{enemy.name}!"
            
                        @elem_hit_count = @elem_hit_count + (enemy.earth_res*(@skills_p1.abilities[0].dmg + @atk))

                        @dealed_damage << enemy.hp - (enemy.earth_res*(@skills_p1.abilities[0].dmg + @atk))
            
                    end
            
                    if random_element == 4
                                            
                        @mp = @mp - @skills_p1.abilities[0].mk

                        enemy.hp = enemy.hp - (enemy.wind_res*(@skills_p1.abilities[0].dmg + @atk))
    
                        puts "Elementalist gain buff +#{@skills_p1.abilities[0].dmg} damage!"

                        puts "Elementalist deals #{enemy.wind_res*(@skills_p1.abilities[0].dmg + @atk)} wind damage to #{enemy.name}!"
            
                        @elem_hit_count = @elem_hit_count + (enemy.wind_res*(@skills_p1.abilities[0].dmg + @atk))

                        @dealed_damage << enemy.hp - (enemy.wind_res*(@skills_p1.abilities[0].dmg + @atk))
            
                    end
        
                    @cd_1 = @cd_1 + @skills_p1.abilities[0].cd + 1

                    action = STDIN.gets.chomp

                    $action_points = $action_points + 1   

                end                       
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
        
            elsif @skills_p1.abilities[1].level >= 1

                puts "this passive skill is already using if you have enought mana"

                action = STDIN.gets.chomp
    
                return $action_points = $action_points + 0

            elsif @skills_p1.abilities[1].level < 1

                puts "you haven't learned this skill yet"

                action = STDIN.gets.chomp
    
                return $action_points = $action_points + 0
                
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
        
            elsif @mp < @skills_p1.abilities[2].mk
        
                puts "not enough mana!(need #{@skills_p1.abilities[2].mk - @mp} more!)"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0

            elsif @skills_p1.abilities[2].level < 1

                puts "you haven't learned this skill yet"

                action = STDIN.gets.chomp
    
                return $action_points = $action_points + 0

            else

                buff_chance = 0

                buff_chance = rand(101)

                @mp = @mp / 2

                @cd_3 = @cd_3 + @skills_p1.abilities[2].cd

                puts "you have burned 50% of your mana!"


                if buff_chance <= @skills_p1.abilities[2].chance && buff_chance >= 1

    
                    puts "\nElementalist returns burned mana!"

                    puts "+ #{@skills_p1.abilities[2].mana_gain}mp"
        
                    @mp = @mp + @skills_p1.abilities[2].mana_gain

                    @used_this_turn = @used_this_turn + 1

                    @duration_3 = @duration_3 + @skills_p1.abilities[2].buff_duration

                end

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
        
        if action == 'y' && @skills_p1.abilities[3].level > 0
        
            #4 элемa
            if @cd_4 > 0
        
                puts "this spell is on cooldown #{@cd_4} more turns!"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            elsif @mp < @skills_p1.abilities[3].mk
        
                puts "not enough mana!(need #{@skills_p1.abilities[3].mk - @mp} more!)"
        
                action = STDIN.gets.chomp

                return $action_points = $action_points + 0
        
            else

                supress_chance = 0

                supress_chance = rand(enemy.spell_supress)  

                if supress_chance <= enemy.spell_supress && supress_chance >= 1

                    puts "enemy supressed damage!"

                    @cd_4 = @cd_4 + @skills_p1.abilities[3].cd 

                    action = STDIN.gets.chomp

                    return $action_points = $action_points + 1   

                else   
                            
                    fire = 0

                    water = 0

                    earth = 0

                    wind = 0
            
                    fire = (@elem_hit_count / 4) * enemy.fire_res 

                    water = (@elem_hit_count / 4) * enemy.water_res 

                    earth = (@elem_hit_count / 4) * enemy.earth_res 

                    wind = (@elem_hit_count / 4) * enemy.wind_res

                    full_damage = fire + wind + water + earth

                    enemy.hp = enemy.hp - full_damage

                    @dealed_damage << full_damage
            
                    puts "Elementalist concentrating elemental power in one beam.."
            
                    puts "Elementalist dealing #{full_damage} damage to the enemy!"

                    @cd_4 = @cd_4 + @skills_p1.abilities[3].cd 

                    action = STDIN.gets.chomp

                    return $action_points = $action_points + 1
            
                end      

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

                return $action_points = $action_points * 0
            
            when 'n'

                return $action_points = $action_points * 0

            end
        
        else
        
            puts "you don't have enough passive points to learn this ability!"
        
            action = STDIN.gets.chomp

            return $action_points = $action_points + 0
        
        end
    end
end