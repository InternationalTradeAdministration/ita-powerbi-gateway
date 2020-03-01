import Vue from 'vue'
import Router from 'vue-router'
import Reports from '@/Reports'
import ReportViewer from '@/ReportViewer'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Reports',
      component: Reports
    },
    {
      path: '/view',
      name: 'ReportViewer',
      component: ReportViewer
    }
  ]
})
