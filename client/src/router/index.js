import Vue from 'vue'
import Router from 'vue-router'
import Groups from '@/Groups'
import Reports from '@/Reports'
import ReportViewer from '@/ReportViewer'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Groups',
      component: Groups
    }, {
      path: '/workspace/:workspaceName',
      name: 'Reports',
      component: Reports
    }, {
      path: '/workspace/:workspaceName/report/:reportName',
      name: 'ReportViewerByName',
      component: ReportViewer
    }
  ]
})
