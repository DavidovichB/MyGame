require_relative 'pick_stage'
require_relative 'battle_stage'


class Skills_stats
    
    attr_accessor :dmg, :mk, :cd, :chance, :debuff, :illusion_hp, :illusion_atk, :level, :has_healing, :debuff_duration, :miss, :buff_duration, :healing, :name, :mana_gain, :spell_supression
    #заменяет гетеры и сеттеры

    def initialize(skill, level)
        @dmg = skill['dmg']
        @mk = skill['mk']
        @cd = skill['cd']
        @chance = skill['chance']
        @debuff = skill['debuff']
        @illusion_hp = skill['illusion_hp']
        @illusion_atk = skill['illusion_atk']
        @level = level
        @has_healing = skill['has_healing']
        @healing = skill['healing']
        @debuff_duration = skill['debuff_duration']
        @miss = skill['miss']
        @buff_duration = skill['buff_duration']
        @name = skill['name']
        @mana_gain = skill['mana_gain']
        @spell_supression = skill['spell_supression']
    end

    def to_s
        "#{@dmg} #{@mk} #{@cd} #{@chance} #{@debuff} #{@illusion_hp} #{@illusion_atk} #{@level} #{@healing} #{@miss}"
    end

    def skill_info
        "\ncurrent main params of your skill (level #{@level}):\n\nDamage: #{@dmg}\nManacost: #{@mk}\nCooldown: #{@cd}"
    end

end

class Skills

    def initialize(skill_params, hero_name)
        #skill_params массив, который состоит из такого кол-ва элементов, сколько есть скиллов
        @abilities = []

        skillstats = {
            
            'Morpheus'=> [[
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 0,"cd" => 0,"chance" => 0,"miss" => 0,"debuff" => 0,"healing"=> 0,"has_healing" => false,"mana_gain" => 0,"debuff_duration" => 0,"buff_duration" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 25,"cd" => 4,"chance" => 4,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 1,"buff_duration" => 1},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 25,"cd" => 4,"chance" => 6,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 2,"buff_duration" => 2},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 25,"cd" => 4,"chance" => 8,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 3,"buff_duration" => 3},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 25,"cd" => 4,"chance" => 10,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 4,"buff_duration" => 4}],
                
                        [{"name"=>"Morpheus","dmg" => 0,"mk" => 0,"cd" => 0,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => false,"illusion_hp" => 0, "illusion_atk" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 35,"cd" => 3,"spell_supression" => 100,"chance" => 14,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1,"illusion_hp" => 0, "illusion_atk" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 35,"cd" => 3,"spell_supression" => 100,"chance" => 16,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1,"illusion_hp" => 0, "illusion_atk" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 35,"cd" => 3,"spell_supression" => 100,"chance" => 18,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1,"illusion_hp" => 0, "illusion_atk" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 35,"cd" => 3,"spell_supression" => 100,"chance" => 20,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1,"illusion_hp" => 0, "illusion_atk" => 0}],
                
                        [{"name"=>"Morpheus","dmg" => 0,"mk" => 0,"cd" => 0,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => false},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 30,"cd" => 4,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 1,"healing"=> 0,"mana_gain" => 25,"has_healing" => false,"debuff_duration" => 1,"buff_duration" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 30,"cd" => 4,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 1,"healing"=> 0,"mana_gain" => 30,"has_healing" => false,"debuff_duration" => 1,"buff_duration" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 30,"cd" => 4,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 2,"healing"=> 0,"mana_gain" => 35,"has_healing" => false,"debuff_duration" => 2,"buff_duration" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 30,"cd" => 4,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 2,"healing"=> 0,"mana_gain" => 40,"has_healing" => false,"debuff_duration" => 2,"buff_duration" => 0}],
                
                        [{"name"=>"Morpheus","dmg" => 0,"mk" => 60,"cd" => 0,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 0},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 60,"cd" => 5,"spell_supression" => 100,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 60,"cd" => 4,"spell_supression" => 100,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1},
                        {"name"=>"Morpheus","dmg" => 0,"mk" => 60,"cd" => 3,"spell_supression" => 100,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 2}]],
                    
            'Elementalist'=> [[
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 0,"cd" => 0,"chance" => 0,"miss" => 0,"debuff" => 0,"healing"=> 0,"has_healing" => false,"mana_gain" => 0,"debuff_duration" => 0,"buff_duration" => 0},
                        {"name"=>"Elementalist","dmg" => 10,"mk" => 20,"cd" => 3,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 0},
                        {"name"=>"Elementalist","dmg" => 20,"mk" => 20,"cd" => 3,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 0},
                        {"name"=>"Elementalist","dmg" => 30,"mk" => 20,"cd" => 3,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 0},
                        {"name"=>"Elementalist","dmg" => 40,"mk" => 20,"cd" => 3,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 0}],
                        
                        [{"name"=>"Elementalist","dmg" => 0,"mk" => 0,"cd" => 0,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => false},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 40,"cd" => 3,"spell_supression" => 100,"chance" => 14,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 40,"cd" => 3,"spell_supression" => 100,"chance" => 16,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 40,"cd" => 3,"spell_supression" => 100,"chance" => 18,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 40,"cd" => 3,"spell_supression" => 100,"chance" => 20,"miss" => 100,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 1}],
                        
                        [{"name"=>"Elementalist","dmg" => 0,"mk" => 0,"cd" => 0,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => false},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 0,"cd" => 4,"spell_supression" => 0,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 25,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 4},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 0,"cd" => 4,"spell_supression" => 0,"chance" => 20,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 30,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 4},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 0,"cd" => 4,"spell_supression" => 0,"chance" => 25,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 35,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 4},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 0,"cd" => 4,"spell_supression" => 0,"chance" => 30,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 40,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => 4}],
                        
                        [{"name"=>"Elementalist","dmg" => 0,"mk" => 50,"cd" => 0,"spell_supression" => 0,"chance" => 0,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => false},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 50,"cd" => 7,"spell_supression" => 0,"chance" => 15,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => false},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 50,"cd" => 6,"spell_supression" => 0,"chance" => 20,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => false},
                        {"name"=>"Elementalist","dmg" => 0,"mk" => 50,"cd" => 6,"spell_supression" => 0,"chance" => 100,"miss" => 0,"debuff" => 0,"healing"=> 0,"mana_gain" => 0,"has_healing" => false,"debuff_duration" => 0,"buff_duration" => false}]]
                    }
    
            @skills = skillstats[hero_name]
            #достает по хиронейму героя статы 

            skill_params.each_with_index do |level,index|
            #в betlle stage создается массив в который передаются приколы, цикл проходит по каждому индексу массива, выполняя блок do end,
            #level передает значение текущей итерации, может быть любое другое слово, индекс передает номер текущей итеарции, может быть любое другое слово
            @abilities << Skills_stats.new(@skills[index][level],level)
            #передает номер способности, её лвл из массивов, level - значение уровня скилла
            #a = Skills.new([1,2,4,0],'Elementalist') => 0 25 4 100 4  1
                                                        #0 25 5 100 6   2
                                                        #0 25 7 100 10  4
                                                        #0 0 0 0 0      0
            #puts a.abilities
        end


    end

    

    def abilities
        @abilities
    end
    #геттер чтобы достать абилитис из вне

    def lvl_up(skill_number)

        current_skill_level = @abilities[skill_number].level
        #присваивает переменной значение уровня по номеру скилла, через точку вызываем геттер поля level класса skills stats, level это текущий уровень способности

        @abilities[skill_number] = Skills_stats.new(@skills[skill_number][current_skill_level + 1], current_skill_level +1)
        #вытягиваем способность по номеру, записывая её статы с уровнем +1, вторым параметром передаем уровень способности +1

    end
end     
