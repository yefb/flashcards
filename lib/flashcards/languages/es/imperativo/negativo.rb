require_relative '../subjuntivo/presente'

Flashcards::Language.define(:es) do
  conjugation_group(:imperativo_negativo) do |verb, infinitive|
    tense = Flashcards::Tense.new(self, :imperativo_negativo, infinitive) do
      [verb.subjuntivo.stem, {
        tú: delegate(:tú, verb.subjuntivo, :usted) { |command| "#{command}s" },
        nosotros: delegate(:nosotros, verb.subjuntivo, :nosotros),
        vosotros: delegate(:vosotros, verb.subjuntivo, :vosotros)
      }]
    end

    tense.alias_person :vos, :tú
    tense.alias_person :nosotras, :nosotros
    tense.alias_person :vosotras, :vosotros

    tense.define_singleton_method(:pretty_inspect) do
      super([nil, :tú], [:nosotros, :vosotros])
    end

    tense
  end
end
