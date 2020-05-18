import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import ReportList from '@/ReportList.vue'

describe('ReportList.vue', () => {
  let repository = {
    listReports: () => ([{
      name: 'Morpheus'
    },
    {
      name: 'Tank'
    }])
  }

  const $route = {
    params: {
      workspaceName: 'Matrix'
    }
  }

  it('renders a list of powerbi reports', async () => {
    const wrapper = shallowMount(ReportList, {
      propsData: { repository },
      stubs: ['router-link'],
      mocks: {
        $route
      }
    })

    await wrapper.vm.$nextTick()

    expect(wrapper.text()).to.include('Matrix')
    expect(wrapper.text()).to.include('Morpheus')
    expect(wrapper.text()).to.include('Tank')
  })
})
