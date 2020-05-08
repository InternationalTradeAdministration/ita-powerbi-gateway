import Vue from 'vue'
import Router from 'vue-router'
import GroupList from '@/GroupList'
import ReportList from '@/ReportList'
import ReportFactory from '@/ReportFactory'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'GroupList',
      component: GroupList
    }, {
      path: '/workspace/:workspaceName',
      name: 'ReportList',
      component: ReportList
    }, {
      path: '/workspace/:workspaceName/report/:reportName',
      name: 'ReportFactory',
      component: ReportFactory
    }
  ]
})
