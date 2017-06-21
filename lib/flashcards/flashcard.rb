require 'flashcards' # FIXME: Extract Flashcards.app to flashcards/app.rb and change this.

module Flashcards
  class Example
    attr_reader :expression, :translation
    def initialize(expression, translation)
      @expression, @translation = expression, translation
    end

    def data
      {@expression => @translation}
    end
  end

  class Flashcard
    attr_reader :data
    def initialize(data)
      @data = data
      @data[:metadata] ||= Hash.new

      deserialise_singular_or_plural_key(:example, data)
      self.examples.map! do |hash_or_example|
        if hash_or_example.is_a?(Example)
          hash_or_example
        elsif hash_or_example.keys.length == 1
          Example.new(hash_or_example.keys.first, hash_or_example.values.first)
        else
          raise ArgumentError.new("Incorrect example: #{hash_or_example.inspect}")
        end
      end

      deserialise_singular_or_plural_key(:tag, data)
      @data[:conjugations] ||= Hash.new if self.tags.include?(:verb)

      deserialise_singular_or_plural_key(:expression, data)
      if self.expressions.empty?
        raise ArgumentError.new('At least one expression has to be provided!')
      end

      deserialise_singular_or_plural_key(:translation, data)
      if self.translations.empty?
        raise ArgumentError.new('Translations has to be provided!')
      end

      deserialise_singular_or_plural_key(:silent_translation, data)
    end

    ATTRIBUTES = [
      :expressions, :translations, :silent_translations, :note, :hint, :tags, :conjugations, :examples, :metadata
    ]

    ATTRIBUTES.each do |attribute|
      define_method(attribute) { @data[attribute] }
    end

    def data
      @data.dup.tap do |data|
        serialise_singular_or_plural_key(:tag, data)
        self.examples.map!(&:data)
        serialise_singular_or_plural_key(:example, data)
        serialise_singular_or_plural_key(:expression, data)
        serialise_singular_or_plural_key(:translation, data)
        serialise_singular_or_plural_key(:silent_translation, data)

        data.delete(:tags) if tags.empty?
        data.delete(:examples) if examples.empty?

        correct_answers = self.correct_answers.reduce(Hash.new) do |hash, (key, values)|
          hash.merge!(key => values) unless values.empty?
          hash
        end

        if correct_answers.keys == [:default]
          correct_answers = data[:metadata][:correct_answers] = correct_answers[:default]
        end

        data[:metadata].delete(:correct_answers) if correct_answers.empty?

        data.delete(:metadata) if metadata.empty?
      end
    end

    def ==(anotherFlashcard)
      self.expressions.sort == anotherFlashcard.expressions.sort && self.translations.sort == anotherFlashcard.translations.sort
    end

    # TODO: Refactor the code to use it.
    # Also deal with correct_answers.push. Maybe I have to
    # do the same as with metadata, bootstrap it and tear down if empty.
    # self.metadata[:correct_answers] ||= Hash.new { |hash, key| hash[:default] }
    # self.metadata[:correct_answers][:default] = Array.new
    def correct_answers
      if self.metadata[:correct_answers].is_a?(Array)
        self.metadata[:correct_answers] = {default: self.metadata[:correct_answers]}
      else
        (self.metadata[:correct_answers] ||= Hash.new).tap do |correct_answers|
          correct_answers.default_proc = Proc.new do |hash, key|
            hash[key] = Array.new
          end
        end
      end
    end

    def new?
      self.correct_answers.all?(&:empty?)
    end

    def schedule
      Flashcards.app.config.schedule
    end

    def verb
      Flashcards.app.language.verb(self.expressions.first, self.conjugations || Hash.new)
    end

    def time_to_review?
      return false if self.new?

      number_of_days = self.schedule[self.correct_answers[:default].length - 1] || (365 * 2)

      tolerance = (5 * 60 * 60) # 5 hours.
      correct_answers[:default].last < (Time.now - ((number_of_days * 24 * 60 * 60) - tolerance))
    end

    def mark(answer)
      if self.translations.include?(answer) || self.silent_translations.include?(answer)
        self.metadata[:correct_answers][:default].push(Time.now)
        return true
      else
        self.mark_as_failed
      end
    end

    def mark_as_failed
      self.metadata.delete(:correct_answers) # Treat as new.
      return false
    end

    protected
    def deserialise_singular_or_plural_key(key, data)
      if value = data.delete(key)
        data["#{key}s".to_sym] = [value].flatten
      elsif data["#{key}s".to_sym].is_a?(String)
        data["#{key}s".to_sym] = [data["#{key}s".to_sym]]
      elsif data["#{key}s".to_sym].is_a?(Array)
        # Already in the correct form.
      else
        data["#{key}s".to_sym] = Array.new
      end

      data["#{key}s".to_sym].map! do |value|
        value.is_a?(Integer) ? value.to_s : value
      end
    end

    def serialise_singular_or_plural_key(key, data)
      if data["#{key}s".to_sym].length == 1
        data[key] = data["#{key}s".to_sym][0]
        data.delete("#{key}s".to_sym)
      elsif data["#{key}s".to_sym].empty?
        data.delete("#{key}s".to_sym)
      end
    end
  end
end
