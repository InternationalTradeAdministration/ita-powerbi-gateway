import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import ReportFactory from '@/ReportFactory.vue'
import Default from '@/reports/Default'
import OtexaAnnual from '@/reports/OtexaAnnual'

describe('ReportFactory.vue', () => {

  it('returns the default report', async () => {
    const wrapper = await renderReportFactory('MATRIX', 'Neo v1')
    expect(wrapper.contains(Default)).to.be.true
  })

  it('returns the otexa annual report', async () => {
    const wrapper = await renderReportFactory('OTEXA-PUBLIC', 'Annual Data v2')
    expect(wrapper.contains(OtexaAnnual)).to.be.true
  })

  let repository = {
    getReport: () => ({
      powerBiReport: {
        id: 'fake-id',
        embedUrl: 'fake-embed-url'
      },
      powerBiToken: {
        token: 'fake-embed-token'
      }
    })
  }

  const pbi = {
    models: {
      TokenType: {
        Embed: 'tigers'
      },
      Permissions: {
        All: 'frogs'
      }
    }
  }

  async function renderReportFactory(workspaceName, reportName) {
    const $route = {
      params: {
        workspaceName,
        reportName
      }
    }

    const wrapper = shallowMount(ReportFactory, {
      propsData: {
        repository, pbi
      },
      stubs: ['router-link'],
      mocks: {
        $route
      }
    })

    await wrapper.vm.$nextTick()

    return wrapper;
  }
})
