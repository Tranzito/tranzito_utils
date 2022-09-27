class PeriodSelector {
  init () {
    this.autoSubmit = !(
      document.getElementById('timeSelectionBtnGroup').attributes['data-nosubmit']?.value === 'true'
    )
    this.enablePeriodSelection()
  }

  urlParamsWithoutPeriod () {
    const urlParams = new URLSearchParams(window.location.search)
    urlParams.delete('period')
    urlParams.delete('timezone')
    urlParams.delete('start_time')
    urlParams.delete('end_time')
    urlParams.append('timezone', window.localTimezone)
    return urlParams
  }

  urlParamsWithNewPeriod (selectedPeriod = null) {
    // If it's null, empty, undefined or anything other than string
    if (typeof selectedPeriod !== 'string') {
      // If not passed the period, Figure it out, defaulting to all
      selectedPeriod = document.querySelector('#timeSelectionBtnGroup .btn.active').attributes['data-period']?.value || 'all'
    }

    const urlParams = this.urlParamsWithoutPeriod()
    urlParams.append('period', selectedPeriod)

    if (selectedPeriod === 'custom') {
      urlParams.append('start_time', document.getElementById('start_time_selector').value)
      urlParams.append('end_time', document.getElementById('end_time_selector').value)
    }
    return urlParams
  }

  enableCustomSelection () {
    // Show the custom selection inputs
    document
      .querySelectorAll('#timeSelectionBtnGroup .period-select-standard')
      .forEach((btn) => {
        btn.classList.remove('active')
      })
    document.getElementById('periodSelectCustom').classList.add('active')
    document.getElementById('timeSelectionBtnGroup').classList.add('custom-period-selected')
    document.getElementById('timeSelectionCustom').classList.add('in')
    document.getElementById('timeSelectionCustom').style.display = 'flex'
  }

  disableCustomSelection () {
    document.getElementById('timeSelectionCustom').classList.remove('in')
    document.getElementById('timeSelectionCustom').style.display = 'none'
    document.getElementById('timeSelectionBtnGroup').classList.remove('custom-period-selected')
  }

  urlForPeriod (selectedPeriod = null) {
    return window.location.origin + location.pathname + '?' + this.urlParamsWithNewPeriod(selectedPeriod).toString()
  }

  enablePeriodSelection () {
    const self = this
    document.querySelectorAll('#timeSelectionBtnGroup .btn').forEach((btn) => {
      btn.addEventListener('click', (e) => {
        let eventTarget = e.target
        let selectedPeriod = eventTarget.attributes['data-period']?.value
        // Sometimes, the target isn't the button, it's something inside the button. In that case, find the correct period
        if (typeof selectedPeriod === 'undefined') {
          // If we can't figure out what the target was, return false, so the user clicks again
          if (!eventTarget.parentElement?.classList.contains('btn')) return

          eventTarget = eventTarget.parentElement?.classList.contains('btn')
          selectedPeriod = eventTarget.attributes['data-period']?.value
        }
        // If it's a link (e.g. "past hour") just follow the link!
        if (eventTarget.attributes.href?.value) {
          return true
        }

        if (selectedPeriod === 'custom') {
          return self.enableCustomSelection()
        } else {
          // Not really necessary, but makes it a little slicker
          self.disableCustomSelection()
        }
        document.querySelector('#timeSelectionBtnGroup .period-select-standard.active').classList.remove('active')
        eventTarget.classList.add('active')
        if (self.autoSubmit) {
          return (location.href = self.urlForPeriod(selectedPeriod))
        } else {
          // log.debug(self.urlForPeriod(selectedPeriod));
          return true
        }
      })
    })

    // If not autosubmitting, this needs to be managed separately
    if (self.autoSubmit) {
      document
        .getElementById('timeSelectionCustom')
        .addEventListener('submit', (e) => {
          location.href = self.urlForPeriod('custom')
          return false
        })
    }
  }
}

export default PeriodSelector
