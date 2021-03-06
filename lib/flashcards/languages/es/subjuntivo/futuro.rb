require_relative '../indicativo/preterito'

Flashcards::Language.define(:es) do
  conjugation_group(:subjuntivo_futuro) do |verb, infinitive|
    language = self
    tense = Flashcards::Tense.new(self, :subjuntivo_futuro, infinitive) do
      if verb.infinitive != infinitive # Irregular infinitive.
        stem = self.infinitive[0..-4]
      else
        stem = verb.pretérito.ellos[0..-4]
      end

      # NOTE: It might or might not be the right stem, but anyhow, I don't think it matters.
      [stem[0..-2], {
         yo: "#{stem[-1]}re",   nosotros: "#{language.syllabifier.accentuate(stem[-1], 0)}remos",
         tú: "#{stem[-1]}res",  vosotros: "#{stem[-1]}reis",
         él: "#{stem[-1]}re",   ellos: "#{stem[-1]}ren"
      }]
    end

    tense.alias_person(:vos, :tú)
    tense.alias_person(:ella, :él)
    tense.alias_person(:usted, :él)
    tense.alias_person(:nosotras, :nosotros)
    tense.alias_person(:vosotras, :vosotros)
    tense.alias_person(:ellas, :ellos)
    tense.alias_person(:ustedes, :ellos)

    tense.define_singleton_method(:pretty_inspect) do
      super(
        [:yo, :tú, :él],
        [:nosotros, :vosotros, :ellos])
    end

    tense
  end
end
