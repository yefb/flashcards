Flashcards.app.define_language(:es) do
  conjugation_group(:pretérito) do |infinitive|
    tense = Flashcards::Tense.new(:pretérito, infinitive) do
      case infinitive
      when /^(.+)ar(se)?$/
        [$1, {
          yo: 'é',    nosotros: 'amos',
          tú: 'aste', vosotros: 'asteis',
          él: 'ó',    ellos: 'aron'
        }]
      when /^(.*)[ei]r(se)?$/ # ir, irse
        [$1, {
          yo: 'í',    nosotros: 'imos',
          tú: 'iste', vosotros: 'isteis',
          él: 'ió',   ellos:    'ieron'
        }]
      end
    end

    tense.irregular(/car(se)?$/, yo: Proc.new { |root| "#{root[0..-2]}qué" })
    tense.irregular(/gar(se)?$/, yo: Proc.new { |root| "#{root[0..-2]}gué" })
    tense.irregular(/zar(se)?$/, yo: Proc.new { |root| "#{root[0..-2]}cé"  })

    tense.alias_person(:vos, :tú)
    tense.alias_person(:usted, :él)
    tense.alias_person(:ustedes, :ellos)

    tense.define_singleton_method(:pretty_inspect) do
      super(
        [:yo, :tú, :él],
        [:nosotros, :vosotros, :ellos])
    end

    tense
  end
end
