def rpn(expression)
  priority = {
    '^' => 4,
    '*' => 3,
    '/' => 3,
    '+' => 2,
    '-' => 2,
    '(' => 1 # щоб правильно робило вирази з дужками
  }

  output = [] #
  operators = [] #
  tokens = expression.split(/\s*/) #

  tokens.each do |token|
    if token =~ /\d+/ # якщо число, додати до виходу
      output << token
    elsif token == '(' # якщо це відкриваюча дужка, додати до operators
      operators << token
    elsif token == ')' # якщо закриваюча дужка, витягти всі оператори із operators до відкриваючої дужки
      while operators.last != '('
        output << operators.pop
      end
      operators.pop # видаляємо відкриваючу дужку
    else
      # якщо це оператор, перевірка пріорітету
      while !operators.empty? && priority[token] <= priority[operators.last]
        output << operators.pop
      end
      operators << token # додати поточний оператор до operators
    end
  end
  # витягти всі оператори зі стеку та додати їх до виходу
  while !operators.empty?
    output << operators.pop
  end
  return output.join(' ')
end
# приклад використання
mexample = "2 + 1 * 4"
rpn_expression = rpn(mexample)
puts "Input: #{mexample}"
puts "Output (RPN): #{rpn_expression}"
