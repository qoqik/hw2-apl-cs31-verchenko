def infix_to_rpn(expression)
  precedence = {
    '^' => 4,
    '*' => 3,
    '/' => 3,
    '+' => 2,
    '-' => 2,
    '(' => 1
  }

  output = [] #
  stack = [] #

  tokens = expression.split(/\s*/)  #(1 + 2) * (3 - 4)

  tokens.each do |token|
    if token =~ /\d+/ # Якщо це число, додати до виходу
      output << token
    elsif token == '(' # Якщо це відкриваюча дужка, додати до стеку
      stack << token
    elsif token == ')' # Якщо це закриваюча дужка, витягти всі оператори зі стеку до відкриваючої дужки
      while stack.last != '('
        output << stack.pop
      end
      stack.pop # Видаляємо відкриваючу дужку зі стеку
    else
      # Якщо це оператор, витягти оператори зі стеку, які мають більший або рівний пріоритет, і додати їх до виходу
      while !stack.empty? && precedence[token] <= precedence[stack.last]
        output << stack.pop
      end
      stack << token # Додати поточний оператор до стеку
    end
  end

  # Витягти всі залишкові оператори зі стеку та додати їх до виходу
  while !stack.empty?
    output << stack.pop
  end

  return output.join(' ')
end

# Приклад використання
input_expression = "2 + 1 * 4"
rpn_expression = infix_to_rpn(input_expression)
puts "Input: #{input_expression}"
puts "Output (RPN): #{rpn_expression}"
