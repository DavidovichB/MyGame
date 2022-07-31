

class Pick

    attr_accessor :p1_input, :p2_input, :p1_hero, :p2_hero


    def initialize
        @p1_input = p1_input
        @p2_input = p2_input
        @p1_hero = p1_hero
        @p2_hero = p2_hero
    end

    def say_hi
        puts "\nWelcome!"
    end

    def game_rules

        rules_path = 'rules/rules.txt'

        if File.exist?(rules_path)
            file = File.new(rules_path, 'r:UTF-8')
            rules = file.readlines
            puts rules
            file.close 
        else
            abort 'game rules is not available!'
        end

        puts 'enter for continue'

        enter = STDIN.gets.chomp

        while enter != '' do 
            system 'clear'
            puts rules
            puts "\n\ndid you read the rules?(press enter)"
            puts 'enter for continue'
            enter = STDIN.gets.chomp
        end


    end

    def heroes_list

        heroes_list_path = 'heroes/all_heroes.txt'

        if File.exist?(heroes_list_path)
            file = File.new(heroes_list_path, 'r:UTF-8')
            all_heroes = file.readlines
            puts all_heroes
            file.close 
        else
            abort 'heroes list is not available!'
        end
    end

    def p1_choose

        all_heroes_array = ['Elementalist','Morpheus']
        all_heroes_array_seen = ['1. Elementalist','2. Morpheus']

        system 'clear'
        
        puts "\np1, it's your's turn to pick.\n(enter hero number)\n\n"
        puts all_heroes_array_seen
        puts

        p1_input = STDIN.gets.chomp

        case p1_input
        when '1'
            puts 'p1 chose Elementalist'
            system 'clear'
            $p1_hero = all_heroes_array[0]
        when '2'
            puts 'p1 chose Morpheus'
            system 'clear'
            $p1_hero = all_heroes_array[1]
        else 
            puts 'wrong hero argument!'
        abort
        end
    end

    def p2_choose

        all_heroes_array = ['Elementalist','Morpheus']
        all_heroes_array_seen = ['1. Elementalist','2. Morpheus']
        puts "\np2, it's yours's turn to pick.\n(enter hero number)\n\n"
        puts all_heroes_array_seen
        puts

        p2_input = STDIN.gets.chomp

        case p2_input
        when '1'
            system 'clear'
            puts 'p2 chose Elementalist'
            $p2_hero = all_heroes_array[0]
        when '2'
            system 'clear'
            puts 'p2 chose Morpheus'
            $p2_hero = all_heroes_array[1]
        else 
            puts 'wrong hero argument!'
        abort
        end
    end

    def p1_select
        p1_choose
    end

    def p2_select
        p2_choose
    end
end