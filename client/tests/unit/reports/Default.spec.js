import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import Default from '@/reports/Default.vue'
import { forIt } from '../TestUtils'
import Sinon from 'sinon'

describe('Default.vue', () => {

  let repository = {
    generateToken: (workspaceName, reportName) => ({
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

  it('user may view a power bi report', async () => {
    let powerbiEmbedSpy = Sinon.spy();
    window.powerbi = {
      embed: powerbiEmbedSpy,
      get: () => {
        return {
          on: () => {}
        }
      }
    };

    const wrapper = shallowMount(Default, {
      propsData: { repository, pbi },
      stubs: ['router-link'],
      mocks: {
        $route: {
          params: {
            workspaceName: 'Matrix',
            reportName: 'Neo v1'
          }
        }
      }
    })

    await wrapper.vm.$nextTick();
    await forIt(100)

    const embedConfig = powerbiEmbedSpy.lastCall.args[1]
    expect(embedConfig.id).to.eq('fake-report-id')
    expect(embedConfig.embedUrl).to.eq('https://Matrix/fake-embed-url')
    expect(embedConfig.accessToken).to.eq('fake-embed-token')
    expect(embedConfig.type).to.eq('report')
    expect(embedConfig.tokenType).to.eq('puppies')
    expect(embedConfig.permissions).to.eq('kittens')
  })
})
