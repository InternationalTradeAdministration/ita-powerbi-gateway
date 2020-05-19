import Vue from 'vue'
import Router from 'vue-router'
import GroupList from '@/GroupList'
import ReportList from '@/ReportList'
import ReportFactory from '@/ReportFactory'
import Repository from '@/utils/Repository'
import * as pbi from "powerbi-client";

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'GroupList',
      component: GroupList,
      props: {
        repository: new Repository()
      }
    }, {
      path: '/workspace/:workspaceName',
      name: 'ReportList',
      component: ReportList,
      props: {
        repository: new Repository()
      }
    }, {
      path: '/workspace/:workspaceName/report/:reportName',
      name: 'ReportFactory',
      component: ReportFactory,
      props: {
        pbi,
        repository: new Repository()
      }
    }
  ]
})
