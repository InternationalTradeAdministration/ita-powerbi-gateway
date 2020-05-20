import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import OtexaAnnual from '@/reports/OtexaAnnual.vue'
import { forIt } from '../TestUtils'
import Sinon from 'sinon'

describe('OtexaAnnual.vue', () => {
  let htsRepositoryStub = Sinon.stub().resolves([
    {
      hts: '123456',
      longHts: 'Socks'
    },
    {
      hts: '987654',
      longHts: 'Hats'
    }
  ])

  let repository = {
    getOtexaCountries: () => ([{
      ctryId: 0,
      ctryDescription: 'WORLD'
    }, {
      ctryId: 1,
      ctryDescription: 'GREECE'
    }]),
    getOtexaCategories: () => ([
      {
        catId: 11,
        longCategory: 'Frogs'
      }, {
        catId: 22,
        longCategory: 'Dogs'
      }
    ]),
    getOtexaChapters: () => ([
      {
        chapter: 33,
        longChapter: 'Chapter 33'
      }, {
        chapter: 44,
        longChapter: 'Chapter 44'
      }
    ]),
    getOtexaHts: htsRepositoryStub,
    getReport: (workspaceName, reportName) => ({
      powerBiReport: {
        id: 'fake-report-id',
        name: reportName,
        embedUrl: 'https://' + workspaceName + '/fake-embed-url'
      },
      powerBiToken: {
        token: 'fake-embed-token'
      }
    })
  }

  let pbi = {
    models: {
      TokenType: {
        Embed: 'puppies'
      },
      Permissions: {
        All: 'kittens'
      }
    }
  }

  it('user may filter report by country, category, chapter, and hts', async () => {
    let powerbiEmbedSpy = Sinon.spy();
    window.powerbi = {
      embed: powerbiEmbedSpy
    };
  
    const wrapper = shallowMount(OtexaAnnual, {
      propsData: { repository, pbi },
      stubs: ['router-link'],
      mocks: {
        $route: {
          params: {
            workspaceName: 'OTEXA',
            reportName: 'Annual Report v2'
          }
        }
      }
    })

    await forIt(100)

    wrapper.find('#countries').findAll('option').at(0).setSelected()
    wrapper.find('#categories').findAll('option').at(0).setSelected()
    wrapper.find('#categories').findAll('option').at(1).setSelected()
    wrapper.find('#chapters').findAll('option').at(0).setSelected()
    wrapper.find('#chapters').findAll('option').at(1).setSelected()

    expect(htsRepositoryStub.lastCall.args[0]).to.eql([11, 22])
    expect(htsRepositoryStub.lastCall.args[1]).to.eql([33, 44])

    await forIt(100)

    wrapper.find('#hts').findAll('option').at(0).setSelected()
    wrapper.find('#hts').findAll('option').at(1).setSelected()    

    wrapper.find('#submit-button').trigger('click')

    const embedConfig = powerbiEmbedSpy.lastCall.args[1]

    expect(embedConfig.id).to.eq('fake-report-id')
    expect(embedConfig.embedUrl).to.eq('https://OTEXA/fake-embed-url')
    expect(embedConfig.accessToken).to.eq('fake-embed-token')
    expect(embedConfig.type).to.eq('report')
    expect(embedConfig.tokenType).to.eq('puppies')
    expect(embedConfig.permissions).to.eq('kittens')
    expect(embedConfig.settings.filterPaneEnabled).to.eq(true)

    expect(embedConfig.filters).to.eql([{
      '$schema': 'http://powerbi.com/product/schema#basic',
      values: ['WORLD'],
      operator: 'In',
      target: { column: 'Country', table: 'OTEXA_EXE_HTS_VW2' },
      filterType: 1
    },
    {
      '$schema': 'http://powerbi.com/product/schema#basic',
      values: ['Frogs', 'Dogs'],
      operator: 'In',
      target: { column: 'Category', table: 'OTEXA_EXE_HTS_VW2' },
      filterType: 1
    },
    {
      '$schema': 'http://powerbi.com/product/schema#basic',
      values: ['Chapter 33', 'Chapter 44'],
      operator: 'In',
      target: { column: 'Chapter', table: 'OTEXA_EXE_HTS_VW2' },
      filterType: 1
    },
    {
      '$schema': 'http://powerbi.com/product/schema#basic',
      values: ['Socks', 'Hats'],
      operator: 'In',
      target: { column: 'HTS', table: 'OTEXA_EXE_HTS_VW2' },
      filterType: 1
    }]
    )
  })
})
