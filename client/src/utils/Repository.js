export async function getReports () {
  const reports = await getRequest('/api/list-reports')
  console.log(reports)
  return reports.value
}

export async function getReport (reportId) {
  return getRequest('/api/get-report?reportId=' + reportId)
}

export async function generateEmbedToken (reportId) {
  return getRequest('/api/generate-embed-token?reportId=' + reportId)
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
