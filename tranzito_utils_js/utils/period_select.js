const urlForPeriod = (selectedPeriod) => {
  return (
    window.location.origin +
    location.pathname +
    '?' +
    urlParamsWithNewPeriod(selectedPeriod).toString()
  )
}

const urlParamsWithoutPeriod = () => {
  const urlParams = new URLSearchParams(window.location.search)
  urlParams.delete('period')
  urlParams.delete('timezone')
  urlParams.delete('start_time')
  urlParams.delete('end_time')
  urlParams.append('timezone', window.localTimezone)
  return urlParams
}

const urlParamsWithNewPeriod = (selectedPeriod) => {
  const urlParams = urlParamsWithoutPeriod()
  urlParams.append('period', selectedPeriod)

  if (selectedPeriod === 'custom') {
    urlParams.append(
      'start_time',
      document.getElementById('start_time_selector').value
    )
    urlParams.append(
      'end_time',
      document.getElementById('end_time_selector').value
    )
  }
  return urlParams
}

export { urlForPeriod }
