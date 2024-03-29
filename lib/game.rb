class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @letters_normalize = letters_normalize
    @user_guesses = []
  end

  def errors
    return @user_guesses - @letters
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(letter_normalize(letter))
          letter
        else
          nil
        end
      end

    return result
  end

  def lost?
    return errors_allowed == 0
  end

  def over?
    return won? || lost?
  end

  def play!(letter)
    if !over? && !@user_guesses.include?(letter_normalize(letter))
      @user_guesses << letter_normalize(letter)
    end
  end

  def letter_normalize(letter)
    case letter
    when "Ё"
      "Е"
    when "Й"
      "И"
    else
      letter
    end
  end

  def letters_normalize
    result =
      @letters.map { |letter| letter_normalize(letter) }
    result.uniq
  end

  def won?
    return (@letters_normalize - @user_guesses).empty?
  end

  def word
    return @letters.join
  end
end
