require 'flashcards'
require 'flashcards/language'

describe 'Subjunctivo imperfecto' do
  let(:spanish) { Flashcards.app.language }

  describe 'verbs ending with -ar' do
    let(:hablar) { spanish._verb('hablar') }

    it 'is regular' do
      expect(hablar.infinitive).to eql('hablar')
      expect(hablar.subjuntivo_imperfecto.infinitive).to eql('hablar')
      # expect(hablar.subjuntivo_imperfecto.root).to eql('habl') # TODO: is it called root or stem?

      expect(hablar.subjuntivo_imperfecto.irregular?(:yo)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:tú)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:vos)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:él)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:ella)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:usted)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:nosotros)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:nosotras)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:vosotros)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:vosotras)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:ellos)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:ellas)).to be(false)
      expect(hablar.subjuntivo_imperfecto.irregular?(:ustedes)).to be(false)

      expect(hablar.subjuntivo_imperfecto.yo).to eql(['hablara', 'hablase'])
      expect(hablar.subjuntivo_imperfecto.tú).to eql(['hablaras', 'hablases'])
      expect(hablar.subjuntivo_imperfecto.vos).to eql(hablar.subjuntivo_imperfecto.tú)
      expect(hablar.subjuntivo_imperfecto.él).to eql(['hablara', 'hablase'])
      expect(hablar.subjuntivo_imperfecto.ella).to eql(hablar.subjuntivo_imperfecto.él)
      expect(hablar.subjuntivo_imperfecto.usted).to eql(hablar.subjuntivo_imperfecto.él)

      expect(hablar.subjuntivo_imperfecto.nosotros).to eql(['hablaramos', 'hablasemos'])
      expect(hablar.subjuntivo_imperfecto.nosotras).to eql(hablar.subjuntivo_imperfecto.nosotros)
      expect(hablar.subjuntivo_imperfecto.vosotros).to eql(['hablarais', 'hablaseis'])
      expect(hablar.subjuntivo_imperfecto.vosotras).to eql(hablar.subjuntivo_imperfecto.vosotros)
      expect(hablar.subjuntivo_imperfecto.ellos).to eql(['hablaran', 'hablasen'])
      expect(hablar.subjuntivo_imperfecto.ellas).to eql(hablar.subjuntivo_imperfecto.ellos)
      expect(hablar.subjuntivo_imperfecto.ustedes).to eql(hablar.subjuntivo_imperfecto.ellos)
    end
  end

  describe 'verbs ending with -er' do
    let(:comer) { spanish._verb('comer') }

    it 'is regular' do
      expect(comer.infinitive).to eql('comer')
      expect(comer.subjuntivo_imperfecto.infinitive).to eql('comer')
      # expect(comer.subjuntivo_imperfecto.root).to eql('com') # TODO: is it called root or stem?

      expect(comer.subjuntivo_imperfecto.irregular?(:yo)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:tú)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:vos)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:él)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:ella)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:usted)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:nosotros)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:nosotras)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:vosotros)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:vosotras)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:ellos)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:ellas)).to be(false)
      expect(comer.subjuntivo_imperfecto.irregular?(:ustedes)).to be(false)

      expect(comer.subjuntivo_imperfecto.yo).to eql(['comiera', 'comiese'])
      expect(comer.subjuntivo_imperfecto.tú).to eql(['comieras', 'comieses'])
      expect(comer.subjuntivo_imperfecto.vos).to eql(comer.subjuntivo_imperfecto.tú)
      expect(comer.subjuntivo_imperfecto.él).to eql(['comiera', 'comiese'])
      expect(comer.subjuntivo_imperfecto.ella).to eql(comer.subjuntivo_imperfecto.él)
      expect(comer.subjuntivo_imperfecto.usted).to eql(comer.subjuntivo_imperfecto.él)

      expect(comer.subjuntivo_imperfecto.nosotros).to eql(['comieramos', 'comiesemos'])
      expect(comer.subjuntivo_imperfecto.nosotras).to eql(comer.subjuntivo_imperfecto.nosotros)
      expect(comer.subjuntivo_imperfecto.vosotros).to eql(['comierais', 'comieseis'])
      expect(comer.subjuntivo_imperfecto.vosotras).to eql(comer.subjuntivo_imperfecto.vosotros)
      expect(comer.subjuntivo_imperfecto.ellos).to eql(['comieran', 'comiesen'])
      expect(comer.subjuntivo_imperfecto.ellas).to eql(comer.subjuntivo_imperfecto.ellos)
      expect(comer.subjuntivo_imperfecto.ustedes).to eql(comer.subjuntivo_imperfecto.ellos)
    end
  end

  describe 'verbs ending with -ir' do
    let(:vivir) { spanish._verb('vivir') }

    it 'is regular' do
      expect(vivir.infinitive).to eql('vivir')
      expect(vivir.subjuntivo_imperfecto.infinitive).to eql('vivir')
      # expect(vivir.subjuntivo_imperfecto.root).to eql('viv') # TODO: is it called root or stem?

      expect(vivir.subjuntivo_imperfecto.irregular?(:yo)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:tú)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:vos)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:él)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:ella)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:usted)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:nosotros)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:nosotras)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:vosotros)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:vosotras)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:ellos)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:ellas)).to be(false)
      expect(vivir.subjuntivo_imperfecto.irregular?(:ustedes)).to be(false)

      expect(vivir.subjuntivo_imperfecto.yo).to eql(['viviera', 'viviese'])
      expect(vivir.subjuntivo_imperfecto.tú).to eql(['vivieras', 'vivieses'])
      expect(vivir.subjuntivo_imperfecto.vos).to eql(vivir.subjuntivo_imperfecto.tú)
      expect(vivir.subjuntivo_imperfecto.él).to eql(['viviera', 'viviese'])
      expect(vivir.subjuntivo_imperfecto.ella).to eql(vivir.subjuntivo_imperfecto.él)
      expect(vivir.subjuntivo_imperfecto.usted).to eql(vivir.subjuntivo_imperfecto.él)

      expect(vivir.subjuntivo_imperfecto.nosotros).to eql(['vivieramos', 'viviesemos'])
      expect(vivir.subjuntivo_imperfecto.nosotras).to eql(vivir.subjuntivo_imperfecto.nosotros)
      expect(vivir.subjuntivo_imperfecto.vosotros).to eql(['vivierais', 'vivieseis'])
      expect(vivir.subjuntivo_imperfecto.vosotras).to eql(vivir.subjuntivo_imperfecto.vosotros)
      expect(vivir.subjuntivo_imperfecto.ellos).to eql(['vivieran', 'viviesen'])
      expect(vivir.subjuntivo_imperfecto.ellas).to eql(vivir.subjuntivo_imperfecto.ellos)
      expect(vivir.subjuntivo_imperfecto.ustedes).to eql(vivir.subjuntivo_imperfecto.ellos)
    end
  end

  # TODO: This should return "se vive" etc rather than just "vive".
  it 'handles reflective verbs' do
    expect(spanish._verb('hablarse').subjuntivo_imperfecto.él).to eql(spanish._verb('hablar').subjuntivo_imperfecto.él)
    expect(spanish._verb('comerse').subjuntivo_imperfecto.él).to eql(spanish._verb('comer').subjuntivo_imperfecto.él)
    expect(spanish._verb('vivirse').subjuntivo_imperfecto.él).to eql(spanish._verb('vivir').subjuntivo_imperfecto.él)
  end

  # TODO: How about ir? What's the stem of voy?
end
