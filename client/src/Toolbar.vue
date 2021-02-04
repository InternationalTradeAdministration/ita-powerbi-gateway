<template>
  <div>
    <div class="toolbar">
      <div class="toolbar-btns">
        <slot />
      </div>
      <div class="toolbar-btns">
        <button v-show="!loadingReport" v-bind:disabled="isExportReportInProgress" @click="selectExportFormat">
          <img class="bar-chart"
            src="/images/bar-chart.svg"
            alt="Export Report"
            title="Export Report"
          />
        </button>
        <button v-if="!loadingReport && this.$route.query.exportdata != 0">
          <img
            src="/images/download.svg"
            alt="Export Data"
            title="Export Data"
            @click="displayExportDialog"
          />
        </button>
        <button>
          <img
            src="/images/fullscreen.svg"
            alt="Full Screen"
            title="Full Screen"
            @click="fullscreen"
          />
        </button>
      </div>
    </div>
    <modal name="export-dialog" :reset="true" height="auto" :pivotY="0.25">
      <div class="dialog-content">
      <header>
        <span class="dialog-title">Export Data</span>
      </header>
      <span v-if="loadingExportDialog">loading...</span>
      <div v-else>
        <div class="active-page-name">
          <span>{{ activePageName }}</span>
        </div>
        <table>
          <tr>
            <th>Visualization</th>
            <th>Summarized</th>
            <th v-if="!workspaceName.includes('OTEXA')">Underlying</th>
          </tr>
          <tr v-for="(v, i) in getVisualsWithData()" :key="i">
            <td>
              {{
                v.title ? v.title : 'Visual #' + (i + 1) + ' (' + v.type + ')'
              }}
            </td>
            <td>
              <button @click="exportData(i, true)">Export</button>
            </td>
            <td v-if="!workspaceName.includes('OTEXA')">
              <button @click="exportData(i, false)">Export</button>
            </td>
          </tr>
        </table>
      </div>
      <div class="dialog-btns">
        <button @click="closeExportDialog">
          Close
        </button>
      </div>
      </div>
    </modal>

    <modal name="export-report-dialog" :reset="true" height="auto" :pivotY="0.25">
      <div class="dialog-content">
      <div v-if="exportReportFileFormat === null" class="select-export-format">
        <header>
          <span class="dialog-title">Select Export Format</span>
        </header>
        <ul>
          <li><button @click="exportReport('PDF')">
            <img src="/images/pdf.png"
                 alt="PDF"
                 title="PDF" />
            PDF</button>
          </li>
          <li><button @click="exportReport('PPTX')">
            <img src="/images/pptx.png"
                 alt="PowerPoint"
                 title="PowerPoint" />
            PowerPoint</button>
          </li>
          <li><button @click="exportReport('PNG')">
            <img src="/images/png.png"
                 alt="PNG"
                 title="PNG" />
            PNG</button>
          </li>
        </ul>
      </div>
      <div v-else-if="isExportReportInProgress">
        <header>
          <span class="dialog-title">Export To {{ this.exportReportFileType }} in progress</span>
          <span class="progress-indicator">
            <img src="/images/three-dots.svg" alt="Spinner" />
          </span>
        </header>
        <p>
          Your report {{ this.$route.params.reportName }} is being exported to {{ this.exportReportFileType }}.
          This might take a few minutes.
        </p>
      </div>
      <template v-else>
        <div v-if="isExportToPdfSuccessful">
          <header>
            <span class="dialog-title">{{ this.exportReportFileType }} file is ready for download</span>
          </header>
          <p>
            The report {{ this.$route.params.reportName }} was exported to {{ this.exportReportFileType }}.
          </p>
        </div>
        <div v-else>
          <header>
            <span class="dialog-title">PDF file export failed</span>
          </header>
          <p>
            The report {{ this.$route.params.reportName }} was not exported to {{ this.exportReportFileType }}.
          </p>
        </div>
      </template>
      <div class="dialog-btns">
        <button @click="closeExportToPdfDialog">
          Close
        </button>
      </div>
      </div>
    </modal>
  </div>
</template>
<script>

const querystring = require('querystring')
import Vue from 'vue'
import VueModal from 'vue-js-modal'
Vue.use(VueModal)

export default {
  name: 'Toolbar',
  props: ['repository', 'loadingReport', 'pbi'],
  data: () => ({
    exportReportFileFormat: null,
    exportReportFileType: null,
    exportReportFileTypes: {
      PPTX: 'PowerPoint',
      PDF: 'PDF',
      PNG: 'PNG'
    },
    isExportReportInProgress: false,
    isExportToPdfSuccessful: false,
    isExportReportDone: true,
    loadingExportDialog: false,
    activePageName: null,
    activePageIndex: 0,
    activePageVisuals: [],
    workspaceName: null
  }),
  created () {
    this.workspaceName = this.$route.params.workspaceName
  },
  methods: {
    getReport () {
      let embedContainer = this.$parent.$refs['embed-container']
      return window.powerbi.get(embedContainer)
    },
    fullscreen () {
      this.getReport().fullscreen()
    },
    async displayExportDialog () {
      this.loadingExportDialog = true
      this.$modal.show('export-dialog')
      const report = this.getReport()
      let pages = await report.getPages()
      this.activePageIndex = pages.findIndex(p => p.isActive)
      this.activePageName = pages[this.activePageIndex].displayName
      this.activePageVisuals = await pages[this.activePageIndex].getVisuals()
      this.loadingExportDialog = false
    },
    async exportData (visualIndex, summarized) {
      const visual = this.getVisualsWithData()[visualIndex]
      const exportType = summarized
        ? this.pbi.models.ExportDataType.Summarized
        : this.pbi.models.ExportDataType.Underlying
      const visualData = await visual.exportData(exportType)
      var encodedUri =
        'data:text/csv;charset=utf-8,' + encodeURI(visualData.data)
      var link = document.createElement('a')
      link.setAttribute('href', encodedUri)
      link.setAttribute('download', 'data.csv')
      document.body.appendChild(link)
      link.click()
    },
    closeExportDialog () {
      this.$modal.hide('export-dialog')
    },
    getVisualsWithData () {
      return this.activePageVisuals.filter(v =>
        [
          'barChart',
          'columnChart',
          'clusteredColumnChart',
          'lineChart',
          'lineStackedColumnComboChart',
          'pieChart',
          'pivotTable',
          'tableEx'
        ].includes(v.type)
      )
    },
    selectExportFormat() {
      this.exportReportFileFormat = null
      this.$modal.show('export-report-dialog')
    },
    exportReport (format) {
      this.exportReportFileFormat = format
      this.exportReportFileType = this.exportReportFileTypes[this.exportReportFileFormat]
      this.isExportReportInProgress = true
      this.isExportToPdfSuccessful = false
      let workspaceName = this.$route.params.workspaceName
      let reportName = this.$route.params.reportName
      this.getReport().bookmarksManager.capture()
      .then(bookmark => this.startExportToFile(workspaceName, reportName, bookmark.state, this.exportReportFileFormat))
      .then(exportStatus => this.getFinalExportStatus(workspaceName, reportName, exportStatus.id, 15000))
      .then(exportStatus => this.processFinalExportStatus(workspaceName, reportName, exportStatus))
    },
    closeExportToPdfDialog () {
      this.$modal.hide('export-report-dialog')
    },
    startExportToFile(workspaceName, reportName, bookmarkState, format) {
      this.$modal.show('export-report-dialog')
      return this.repository.exportToFile(workspaceName, reportName, bookmarkState, format)
    },
    getFinalExportStatus(workspaceName, reportName, exportStatusId, timeout = 2000) {
      let finalExportStates = ['Succeeded', 'Failed']
      return new Promise((resolve) => {
        setTimeout( () => {
          this.repository.getExportToFileStatus(workspaceName, reportName, exportStatusId)
          .then(exportStatus => {
            if (finalExportStates.includes(exportStatus.status)) {
              resolve(exportStatus)
            } else {
              resolve(this.getFinalExportStatus(workspaceName, reportName, exportStatus.id))
            }
          })
        }, timeout)
      })
    },
    async processFinalExportStatus(workspaceName, reportName, exportStatus) {
      if (exportStatus.status === 'Succeeded') {
        let exportStatusId = exportStatus.id
        let params = {
          workspaceName, reportName, exportStatusId
        }
        var link = document.createElement('a')
        link.setAttribute('href', '/api/pbi-admin/export-file?' + querystring.stringify(params))
        let fileName = await this.getDownloadFileName(reportName, this.exportReportFileFormat)
        link.setAttribute('download', fileName)
        document.body.appendChild(link)
        link.click()

        this.isExportToPdfSuccessful = true
        this.isExportReportInProgress = false
      } else {
        this.isExportToPdfSuccessful = false
        this.isExportReportInProgress = false
      }
      this.$modal.show('export-report-dialog')
    },
    async getDownloadFileName(reportName, format) {
      console.log('format ' + format)
      let extension = null
      if (format === 'PNG') {
        let report = this.getReport()
        let pages = await report.getPages()
        extension = pages.length > 1 ? 'zip' : 'png'
      } else {
        extension = format.toLowerCase()
      }
      return reportName + '.' + extension
    }

  }
}
</script>
<style scoped>
.toolbar {
  display: flex;
  height: 34px;
  background-color: #eaeaea;
  justify-content: space-between;
}

.toolbar-btns > button {
  border: none;
  background: none;
  cursor: pointer;
  padding: 0;
}

.toolbar-btns > button:disabled {
  cursor: default;
}

.toolbar-btns > button > img {
  padding: 8px 10px;
}

.toolbar-btns > button:not([disabled]) > img:hover {
  background-color: white;
}

.toolbar-btns .bar-chart {
  width: 18px;
  height: 18px;
}

header {
  margin: 16px 0;
}

.active-page-name {
  margin: 20px 0;
  font-size: 20px;
}

th {
  text-align: left;
  padding-right: 14px;
  padding-bottom: 12px;
}

td {
  text-align: left;
  padding-right: 14px;
  padding-bottom: 6px;
}

td button {
  border: none;
  cursor: pointer;
  background: none;
}

td button:hover {
  text-decoration: underline;
}

.dialog-content {
  padding: 0 2em 1em;
}

.dialog-title {
  font-size: 28px;
}

dialog {
  top: 25%;
  border: 1px solid gray;
}

.dialog-btns {
  margin-top: 22px;
  text-align: right;
}

.dialog-btns > button {
  margin: 4px;
}

.progress-indicator {
  margin-left: 15px;
}

.progress-indicator img {
  width: 80px;
  height: 20px;
}

.select-export-format ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.select-export-format li {
  margin-bottom: 0.5em;
}

.select-export-format button {
  border: none;
  cursor: pointer;
  background: none;
  outline: 0;
  font-size: 0.875em;
}

.select-export-format button img {
  width: 14px;
  height: 14px;
}

.select-export-format button:hover {
  text-decoration: underline;
}
</style>
