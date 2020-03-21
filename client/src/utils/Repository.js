export async function getReports () {
  return await getRequest('/api/list-reports')
}

export async function getReportById (reportId) {
  return getRequest('/api/get-report-by-id?reportId=' + reportId)
}

export async function getReportByName (reportName) {
  const response = await fetch('/api/get-report-by-name', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      reportName
    })
  })
  const responseJson = await response.json()
  return responseJson
}

async function getRequest (url) {
  const response = await fetch(url, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  }
  )
  const responseJson = await response.json()
  return responseJson
}
