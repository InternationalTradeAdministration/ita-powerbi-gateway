import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import GroupList from '@/GroupList.vue'

describe('GroupList.vue', () => {
  let repository = {
    pbiAdminListGroups: () => ([{
      name: 'John Wick',
      onDedicatedCapacity: true
    }])
  }
  it('renders a list of powerbi workspaces', async () => {
    const wrapper = shallowMount(GroupList, {
      propsData: { repository },
      stubs: ['router-link']
    })

    await wrapper.vm.$nextTick()

    expect(wrapper.text()).to.include('Workspaces')
    expect(wrapper.text()).to.include('John Wick')
  })
})
