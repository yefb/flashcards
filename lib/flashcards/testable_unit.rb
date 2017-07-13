require 'yaml'
require 'pathname'

module Flashcards
  class TestableUnit
    FLASHCARD_FILE_PATH = '~/Dropbox/Data/Data/Flashcards/%lang%.yml'
    # "~/.config/flashcards/#{self.language_config.name}.yml",

    def self.data_file(language_name)
      Pathname.new(
        FLASHCARD_FILE_PATH.sub('%lang%', language_name)
      ).expand_path
    end

    def self.load(language_name)
      # YAML treats an empty string as false.
      (YAML.load(self.data_file(language_name).read) || Array.new).map do |flashcard_data|
        begin
          self.new(flashcard_data)
        rescue => error
          abort "Loading item #{flashcard_data.inspect} failed: #{error.message}.\n\n#{error.backtrace}"
        end
      end
    rescue Errno::ENOENT
      Array.new
    end

    def self.save(language_name, items)
      self.data_file(language_name).open('w') do |file|
        file.puts(items.to_yaml)
      end
    end

    attr_reader :data
    def initialize(data)
      @data = data
      @data[:metadata] ||= Hash.new
    end

    def mark(answer, key = :default, &block)
      if block.call
        self.mark_as_correct(key)
      else
        self.mark_as_failed(key)
      end
    end

    def mark_as_failed(key = :default)
      self.correct_answers.delete(key) # Treat as new.
      return false
    end

    def mark_as_correct(key = :default)
      self.correct_answers[key].push(Time.now)
      return true
    end

    def should_run?(key = nil)
      self.new?(key) || self.time_to_review?(key)
    end

    def schedule
      Flashcards.app.config.schedule
    end

    def variants
      [:default]
    end

    def time_to_review?(key = nil)
      key = self.variants.first if self.variants.length == 1

      if key
        return false if self.new?(key)

        number_of_days = self.schedule[self.correct_answers[key].length - 1] || (365 * 2)

        tolerance = (5 * 60 * 60) # 5 hours.
        self.correct_answers[key].last < (Time.now - ((number_of_days * 24 * 60 * 60) - tolerance))
      else
        self.variants.any? do |key|
          self.time_to_review?(key)
        end
      end
    end

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

    def new?(key = nil)
      key = self.variants.first if self.variants.length == 1

      if key
        self.correct_answers[key].empty?
      else
        self.variants.any? do |key|
          self.new?(key)
        end
      end
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