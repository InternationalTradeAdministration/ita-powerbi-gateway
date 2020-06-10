<template>
  <div>
    <div class="toolbar">
      <button v-if="!loadingReport">
        <img
          src="/images/download.svg"
          alt="Export Data"
          @click="displayExportDialog"
        />
      </button>
      <button>
        <img
          src="/images/fullscreen.svg"
          alt="Full Screen"
          @click="fullscreen"
        />
      </button>
    </div>
    <dialog ref="export-dialog">
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
            <th>Underlying</th>
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
            <td>
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
    </dialog>
  </div>
</template>
<script>
export default {
  name: 'Toolbar',
  props: ['loadingReport', 'pbi'],
  data: () => ({
    loadingExportDialog: false,
    activePageName: null,
    activePageIndex: 0,
    activePageVisuals: []
  }),
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
      this.$refs['export-dialog'].showModal()
      const report = this.getReport()
      let pages = await report.getPages()
      this.activePageIndex = pages.findIndex(p => p.isActive)
      this.activePageName = pages[this.activePageIndex].displayName
      this.activePageVisuals = await pages[this.activePageIndex].getVisuals()
      this.loadingExportDialog = false
    },
    async exportData (visualIndex, summarized) {
      const visual = this.activePageVisuals[visualIndex]
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
      this.$refs['export-dialog'].close()
    },
    getVisualsWithData () {
      return this.activePageVisuals.filter(
        v => !['image', 'textbox', 'card', 'slicer'].includes(v.type)
      )
    }
  }
}
</script>
<style scoped>
.toolbar {
  display: flex;
  height: 34px;
  background-color: #eaeaea;
  justify-content: flex-end;
}

.toolbar > button {
  border: none;
  background: none;
  cursor: pointer;
  padding: 0;
}

.toolbar > button > img {
  padding: 8px 10px;
}

.toolbar > button > img:hover {
  background-color: white;
}

header {
  margin: 16px 0 26px 0px;
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

</style>
