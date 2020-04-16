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
      path: '/workspace/:workspaceId',
      name: 'Reports',
      component: Reports
    }, {
      path: '/workspace/:workspaceId/report/:reportId',
      name: 'ReportViewerById',
      component: ReportViewer
    }, {
      path: '/workspace/:workspaceId/reportName/:reportName',
      name: 'ReportViewerByName',
      component: ReportViewer
    }
  ]
})
